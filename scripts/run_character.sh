#!/usr/bin/env bash
set -e

# Load .env from project root (one level up from scripts/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${SCRIPT_DIR}/.."
if [ -f "${ROOT_DIR}/.env" ]; then
  set -a
  # shellcheck disable=SC1090
  . "${ROOT_DIR}/.env"
  set +a
fi

cd "${ROOT_DIR}"

export PORT="${CHARACTER_SERVICE_PORT:-50051}"
export DB_HOST="${CHARACTER_DB_HOST:-${DB_HOST:-localhost}}"
export DB_PORT="${CHARACTER_DB_PORT:-${DB_PORT:-5432}}"
export DB_USER="${DB_USER:-postgres}"
export DB_PASSWORD="${DB_PASSWORD:-postgres}"
export DB_NAME="${CHARACTER_DB_NAME:-character_db}"
export PULSAR_URL="${PULSAR_URL:-pulsar://localhost:6650}"

cd services/character

go run main.go
