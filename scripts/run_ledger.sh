#!/usr/bin/env bash
set -e

# Load .env from project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."
if [ -f "${ROOT_DIR}/.env" ]; then
  set -a
  # shellcheck disable=SC1090
  . "${ROOT_DIR}/.env"
  set +a
fi

cd "${ROOT_DIR}"

export BIND_ADDR="${LEDGER_BIND_ADDR:-0.0.0.0:50054}"
# Kalau DATABASE_URL tidak diset, bangun dari variabel global
if [ -z "${DATABASE_URL}" ]; then
  DB_HOST_EFFECTIVE="${LEDGER_DB_HOST:-${DB_HOST:-localhost}}"
  DB_PORT_EFFECTIVE="${LEDGER_DB_PORT:-${DB_PORT:-5432}}"
  DB_USER_EFFECTIVE="${DB_USER:-postgres}"
  DB_PASSWORD_EFFECTIVE="${DB_PASSWORD:-postgres}"
  DB_NAME_EFFECTIVE="${LEDGER_DB_NAME:-ledger_db}"
  export DATABASE_URL="postgres://${DB_USER_EFFECTIVE}:${DB_PASSWORD_EFFECTIVE}@${DB_HOST_EFFECTIVE}:${DB_PORT_EFFECTIVE}/${DB_NAME_EFFECTIVE}"
fi

export PULSAR_URL="${PULSAR_URL:-pulsar://localhost:6650}"

cd services/ledger

cargo run
