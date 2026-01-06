# 🚀 Quick Start Guide

Quick guide to running Realworld Simulation in 5 minutes.

## Prerequisites

Make sure you have:
- Docker
- Docker Compose

That’s it – all services will run in containers.

## Step 1: Clone & Setup

```bash
cd /home/ardz/Documents/realworld_simulation
```

## Step 2: Start Services

```bash
# Start all services
make up

# Or without make:
docker-compose up -d

# Wait ~10 seconds for initialization
```

## Step 3: Seed Databases

```bash
make seed

# Or without make:
chmod +x scripts/seed_all.sh
./scripts/seed_all.sh
```

## Step 4: Test!

### Option 1: Via curl

```bash
# Check character status
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "status"}'

# Show nearby locations
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "go list"}'

# Start working
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "work start"}'

# List contracts
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "contract list"}'
```

### Option 2: Web Browser

Open `client/web/index.html` in your browser:

```bash
# Linux
xdg-open client/web/index.html

# or directly
firefox client/web/index.html
```

Then type commands like:
- `status`
- `go list`
- `work start`
- `help`

### Option 3: Terminal Client

```bash
# Build terminal client
cd client/terminal
go build -o terminal-client

# Run
./terminal-client
```

## Available Commands

```
status              - Show character status
go list             - List nearby locations
go <place>          - Move to a location
travel list         - List available districts
travel <district>   - Travel to another district
work start          - Start working
work stop           - Stop working
eat                 - Eat to restore hunger
sleep               - Sleep to restore energy
contract list       - List contracts
contract sign <id>  - Sign a contract
help                - Show help
```

## Troubleshooting

### Port already in use?

```bash
# Stop services
make down

# Or change the port in docker-compose.yml
```

### Services cannot connect?

```bash
# Restart everything
make restart

# Check logs
make logs
```

### Reset all data

```bash
# Remove all data and start fresh
make clean
make up
make seed
```

## Check Service Health

```bash
# Gateway health
curl http://localhost:8080/health

# Show running containers
docker-compose ps

# Show logs
docker-compose logs -f gateway
docker-compose logs -f character
```

## Stop Services

```bash
# Stop all (data is preserved)
make down

# Stop and delete all data
make clean
```

## Development Mode

For development without rebuilding containers:

```bash
# Start only databases & infrastructure
docker-compose up postgres-character postgres-world postgres-contracts postgres-ledger postgres-feed pulsar redis -d

# Run services in separate terminals
cd services/gateway && go run main.go
cd services/character && go run main.go
cd services/world && go run main.go
# etc...
```

## Next Steps

- Read [README.md](README.md) for full documentation.
- Read [white_paper.md](white_paper.md) for design philosophy.
- Explore database schemas in `migrations/`.
- Check proto definitions in `proto/`.

## Architecture Overview

```
┌──────────────┐
│   Browser    │ ← Web Client (client/web/index.html)
│   Terminal   │ ← Terminal Client (curl, client/terminal/)
└──────┬───────┘
       │
       ↓
┌──────────────┐
│   Gateway    │ :8080 (HTTP/WebSocket)
└──────┬───────┘
       │
       ├→ Character Service :50051 (gRPC) → PostgreSQL :5432
       ├→ World Service     :50052 (gRPC) → PostgreSQL :5433
       ├→ Contracts Service :50053 (gRPC) → PostgreSQL :5434
       ├→ Ledger Service    :50054 (gRPC) → PostgreSQL :5435
       └→ Feed Service      :50056 (gRPC) → PostgreSQL :5436
       
       All services → Pulsar :6650 (Event Bus)
```

Have fun! 🎮

