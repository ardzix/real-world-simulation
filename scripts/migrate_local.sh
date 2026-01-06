#!/usr/bin/env bash
set -e

# Script ini awalnya memang untuk Postgres lokal (localhost),
# makanya pakai PGHOST/PGUSER default.
# Sekarang kita sinkronkan dengan .env (DB_HOST, DB_PORT, DB_USER, DB_PASSWORD)
# supaya bisa jalan ke VPS juga tanpa diketik manual.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."
if [ -f "${ROOT_DIR}/.env" ]; then
  set -a
  # shellcheck disable=SC1090
  . "${ROOT_DIR}/.env"
  set +a
fi

# Config dasar: ambil dari env app kalau ada, fallback ke default
PGUSER="${PGUSER:-${DB_USER:-postgres}}"
PGHOST="${PGHOST:-${DB_HOST:-localhost}}"
PGPORT="${PGPORT:-${DB_PORT:-5432}}"

# Password non-interaktif (gunakan DB_PASSWORD kalau ada)
if [ -n "${DB_PASSWORD}" ] && [ -z "${PGPASSWORD}" ]; then
  export PGPASSWORD="${DB_PASSWORD}"
fi

CHAR_DB="${CHARACTER_DB_NAME:-character_db}"
WORLD_DB="${WORLD_DB_NAME:-world_db}"
CONTRACTS_DB="${CONTRACTS_DB_NAME:-contracts_db}"
LEDGER_DB="${LEDGER_DB_NAME:-ledger_db}"
FEED_DB="${FEED_DB_NAME:-feed_db}"

echo "==> Migrating ${CHAR_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${CHAR_DB}" -f migrations/character_db.sql

echo "==> Migrating ${WORLD_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${WORLD_DB}" -f migrations/world_db.sql

echo "==> Migrating ${CONTRACTS_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${CONTRACTS_DB}" -f migrations/contracts_db.sql

echo "==> Migrating ${LEDGER_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${LEDGER_DB}" -f migrations/ledger_db.sql

echo "==> Migrating ${FEED_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${FEED_DB}" -f migrations/feed_db.sql

echo "==> Seeding world data into ${WORLD_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${WORLD_DB}" -f migrations/seed_world.sql

echo "==> Seeding ledger data into ${LEDGER_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${LEDGER_DB}" -f migrations/seed_ledger.sql

echo "==> Seeding contracts data into ${CONTRACTS_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${CONTRACTS_DB}" -f migrations/seed_contracts.sql

echo "==> Seeding character data into ${CHAR_DB}"
psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "${CHAR_DB}" -f migrations/seed_character.sql

echo "==> Done."
