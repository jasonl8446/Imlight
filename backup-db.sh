#!/usr/bin/env bash
# Takes a cold backup of the embedded player database (accounts, characters,
# chat logs, friendships).
#
# The Director must be stopped. RavenDB stores the database as Voron files plus a
# write-ahead log, so an archive taken while the server is writing can capture a
# torn state that will not restore.
#
# usage: ./backup-db.sh [destination-directory]
#        KEEP=10 ./backup-db.sh          how many archives to retain (default 5, 0 keeps all)
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$REPO/src/Imlight.Director/Config/Imlight.ini"
DEST="${1:-$HOME/imlight-backups}"
KEEP="${KEEP:-5}"

ini_value() {
    grep -m1 "^$1[[:space:]]*=" "$CONFIG" | cut -d= -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

[[ -f $CONFIG ]] || { echo "Config not found: $CONFIG" >&2; exit 1; }

data_dir=$(ini_value EmbeddedDatabaseDataDirectory)
db_name=$(ini_value PlayerDatabaseName)
[[ -n $data_dir ]] || { echo "EmbeddedDatabaseDataDirectory is not set in $CONFIG" >&2; exit 1; }

# A relative DataDirectory is resolved by RavenDB against its own server binary,
# so "../Foo" lands beside the build output rather than in the repo root.
if [[ $data_dir == /* ]]; then
    DB_PATH=$(realpath -m "$data_dir")
else
    DB_PATH=$(realpath -m "$REPO/src/Imlight.Director/bin/Debug/net10.0/RavenDBServer/$data_dir")
fi

if [[ ! -d $DB_PATH ]]; then
    echo "No database at $DB_PATH" >&2
    echo "Nothing to back up: the Director has not created it yet." >&2
    exit 1
fi

# Refuse while the store is open. The lock file is held for the server's lifetime.
for proc in /proc/[0-9]*; do
    if ls -l "$proc/fd" 2>/dev/null | grep -q system.lock; then
        echo "The database is in use by pid ${proc#/proc/}:" >&2
        tr '\0' ' ' <"$proc/cmdline" >&2
        echo >&2
        echo "Stop the Director before backing up." >&2
        exit 1
    fi
done

mkdir -p "$DEST"
stamp=$(date +%Y%m%d-%H%M%S)
archive="$DEST/imlight-${db_name}-${stamp}.tar.gz"

echo "Database : $DB_PATH ($(du -sh "$DB_PATH" | cut -f1))"
echo "Archive  : $archive"

tar -C "$(dirname "$DB_PATH")" -czf "$archive" "$(basename "$DB_PATH")"

# An archive that cannot be listed is worse than no archive, because it looks like one.
if ! tar -tzf "$archive" >/dev/null 2>&1; then
    echo "Archive failed verification, removing it: $archive" >&2
    rm -f "$archive"
    exit 1
fi

echo "Verified : $(du -h "$archive" | cut -f1), $(tar -tzf "$archive" | wc -l) entries"

if (( KEEP > 0 )); then
    mapfile -t stale < <(ls -1t "$DEST"/imlight-"${db_name}"-*.tar.gz 2>/dev/null | tail -n +$((KEEP + 1)))
    for old in "${stale[@]:-}"; do
        [[ -n $old ]] || continue
        rm -f "$old"
        echo "Pruned   : $(basename "$old")"
    done
fi

echo
echo "To restore: stop the Director, move $DB_PATH aside, then"
echo "  tar -C $(dirname "$DB_PATH") -xzf $archive"
