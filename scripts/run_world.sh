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

export PORT="${WORLD_SERVICE_PORT:-50052}"
export DB_HOST="${WORLD_DB_HOST:-${DB_HOST:-localhost}}"
export DB_PORT="${WORLD_DB_PORT:-${DB_PORT:-5432}}"
export DB_USER="${DB_USER:-postgres}"
export DB_PASSWORD="${DB_PASSWORD:-postgres}"
export DB_NAME="${WORLD_DB_NAME:-world_db}"

cd services/world

go run main.go
