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

export PORT="${CONTRACTS_SERVICE_PORT:-50053}"
export DB_HOST="${CONTRACTS_DB_HOST:-${DB_HOST:-localhost}}"
export DB_PORT="${CONTRACTS_DB_PORT:-${DB_PORT:-5432}}"
export DB_USER="${DB_USER:-postgres}"
export DB_PASSWORD="${DB_PASSWORD:-postgres}"
export DB_NAME="${CONTRACTS_DB_NAME:-contracts_db}"
export PULSAR_URL="${PULSAR_URL:-pulsar://localhost:6650}"

cd services/contracts

go run main.go
