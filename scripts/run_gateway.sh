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

export PORT="${GATEWAY_PORT:-8080}"
export CHARACTER_SERVICE_ADDR="${CHARACTER_SERVICE_ADDR:-localhost:50051}"
export WORLD_SERVICE_ADDR="${WORLD_SERVICE_ADDR:-localhost:50052}"
export CONTRACTS_SERVICE_ADDR="${CONTRACTS_SERVICE_ADDR:-localhost:50053}"
export LEDGER_SERVICE_ADDR="${LEDGER_SERVICE_ADDR:-localhost:50054}"
export IDENTITY_SERVICE_ADDR="${IDENTITY_SERVICE_ADDR:-localhost:50055}"

cd services/gateway

go run main.go
