# Realworld Simulation - Economic Sandbox MMO

A persistent sandbox MMO focused on economic activity, labor, logistics, and power relations – not combat or scripted quests.

## 📋 Key Features

- **Reality-Consistent Sandbox**: Every action requires time, location, energy, and tools, just like the real world.
- **Economy-First**: Players progress via contracts, land control, logistics capacity, and reputation – not XP or levels.
- **NPC-Driven World**: NPCs keep the baseline economy alive (jobs, consumption, services).
- **Command-Driven Interface**: CLI-first interaction, easy to plug into multiple clients.
- **Persistent World**: Simulation continues while players are offline.

## 🏗️ Architecture

### Microservices (Event-Driven)

```
┌─────────────────┐
│  Command Gateway│ (Go) - HTTP/WebSocket entry point
└────────┬────────┘
         │
    ┌────┴─────────────────────────────────────┐
    │                                           │
┌───▼──────┐  ┌──────────┐  ┌──────────┐  ┌──▼──────┐
│Character │  │  World   │  │Contracts │  │ Ledger  │
│ Service  │  │ Service  │  │ Service  │  │ Service │
│   (Go)   │  │   (Go)   │  │   (Go)   │  │ (Rust)  │
└────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬────┘
     │             │             │             │
     └──────┬──────┴──────┬──────┴─────────────┘
            │             │
       ┌────▼────┐   ┌────▼──────┐
       │ Pulsar  │   │PostgreSQL │
       │ Events  │   │(Per Service)
       └────┬────┘   └───────────┘
            │
       ┌────▼────┐
       │  Feed   │
       │ Service │
       │  (Go)   │
       └─────────┘
```

### Services

1. **Command Gateway** (Port 8080) – Single entry point for all clients.
2. **Character Service** (Port 50051) – Character state & activities.
3. **World Service** (Port 50052) – World map, locations, and travel graph.
4. **Contracts Service** (Port 50053) – Paper & digital contracts.
5. **Ledger Service** (Port 50054) – Double-entry accounting (Rust).
6. **Event Feed Service** (Port 50056) – Notifications and news feed.

### Databases

- **character_db** (Port 5432) – Character state & activities.
- **world_db** (Port 5433) – Districts, places, travel graph.
- **contracts_db** (Port 5434) – Contracts & obligations.
- **ledger_db** (Port 5435) – Accounts, transactions, audit.
- **feed_db** (Port 5436) – Event feed messages.

### Infrastructure

- **Apache Pulsar** (Ports 6650, 8080) – Event streaming backbone.
- **Redis** (Port 6379) – Caching & rate limiting.

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Go 1.21+ (for local development)
- Rust 1.75+ (for Ledger service)
- Make (optional for helper commands)

### Run All Services (via Docker)

```bash
# Clone repository
git clone <repo-url>
cd realworld_simulation

# Start semua services dengan Docker Compose
docker-compose up -d

# Tunggu beberapa detik untuk inisialisasi database
sleep 10

# Seed database dengan data awal
chmod +x scripts/seed_all.sh
./scripts/seed_all.sh

# Cek status services
docker-compose ps

# Lihat logs
docker-compose logs -f gateway
```

### Test Command Gateway

```bash
# Via curl - Text command
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "status"}'

# Lihat karakter status
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "go list"}'

# Travel
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "travel list"}'

# Work
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "work start"}'

# Contracts
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "contract list"}'

# Help
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "help"}'
```

### WebSocket Client

```javascript
// Connect via WebSocket
const ws = new WebSocket('ws://localhost:8080/ws');

ws.onopen = () => {
  console.log('Connected');
  ws.send(JSON.stringify({ text: 'status' }));
};

ws.onmessage = (event) => {
  console.log('Response:', JSON.parse(event.data));
};
```

## 📝 Available Commands

### Movement
- `go <place>` – Move to a nearby location.
- `go list` – Show reachable nearby locations.
- `travel <district>` – Travel to another district.
- `travel list` – Show available destination districts.

### Work
- `work start` – Start working at your current job.
- `work stop` – Stop working.

### Needs
- `eat` – Eat to restore hunger.
- `sleep` – Sleep to restore energy.

### Contracts
- `contract list` – List your contracts.
- `contract sign <id>` – Sign a contract.

### Info
- `status` – Show character status.
- `help [command]` – Show help (optionally for a specific command).

## 🔧 Development

### Run Services Locally (without Docker)

```bash
# Terminal 1 - Start databases dan infrastructure
docker-compose up postgres-character postgres-world postgres-contracts postgres-ledger postgres-feed pulsar redis

# Terminal 2 - Character Service
cd services/character
go run main.go

# Terminal 3 - World Service
cd services/world
go run main.go

# Terminal 4 - Contracts Service
cd services/contracts
go run main.go

# Terminal 5 - Ledger Service
cd services/ledger
cargo run

# Terminal 6 - Feed Service
cd services/feed
go run main.go

# Terminal 7 - Gateway
cd services/gateway
go run main.go
```

### Database Migrations (via Docker)

```bash
# Apply migrations manually
docker exec -i character_db psql -U postgres -d character_db < migrations/character_db.sql
docker exec -i world_db psql -U postgres -d world_db < migrations/world_db.sql
docker exec -i contracts_db psql -U postgres -d contracts_db < migrations/contracts_db.sql
docker exec -i ledger_db psql -U postgres -d ledger_db < migrations/ledger_db.sql
docker exec -i feed_db psql -U postgres -d feed_db < migrations/feed_db.sql
```

### Connect to Databases (via Docker)

```bash
# Character DB
docker exec -it character_db psql -U postgres -d character_db

# World DB
docker exec -it world_db psql -U postgres -d world_db

# Contracts DB
docker exec -it contracts_db psql -U postgres -d contracts_db

# Ledger DB
docker exec -it ledger_db psql -U postgres -d ledger_db

# Feed DB
docker exec -it feed_db psql -U postgres -d feed_db
```

## 📊 Core Concepts

### Economic Rules

1. **No Free Money**: Currency is only minted via public mechanisms (payroll, procurement).
2. **Reality-Consistent**: Actions require time, location, energy, tools.
3. **Persistent State**: The world continues while players are offline.
4. **Player as Economic Actor**: Progress via contracts, ownership, logistics.

### Contract System

- **Paper Contracts**: Require physical presence to create/sign.
- **Digital Contracts**: Require a device (phone/laptop/PC) and network.
- Contracts enforce obligations with deadlines and penalties.

### Ledger System (Double-Entry)

- Every transaction must balance (debit = credit).
- Immutable audit trail.
- Minting only for public payroll (with full audit).
- Integrated tax system.

### Character Needs

- **Energy**: Decreases while working, restored by sleep.
- **Hunger**: Decreases over time, restored by eating.
- **Health**: Affected by work conditions and environment.

## 🎯 Roadmap

### MVP (Current)
- [x] Command Gateway with CLI parsing
- [x] Character service with state machine
- [x] World service with places & travel
- [x] Contracts service (paper & digital)
- [x] Ledger service with double-entry accounting
- [x] Event Feed service
- [x] Docker orchestration
- [x] Database migrations & seed data

### Phase 2 (Next)
- [ ] Inventory Service
- [ ] Logistics Service (vehicles & shipments)
- [ ] Production & Extraction Service
- [ ] NPC Schedule Service (deterministic routines)
- [ ] Full Pulsar integration untuk event streaming
- [ ] Scheduled actions system (Celery/workers)

### Phase 3 (Future)
- [ ] NPC Mind Service (LLM-based planning)
- [ ] WorldGen Service (procedural map generation)
- [ ] Modern web client
- [ ] Discord/Telegram bot adapters
- [ ] Graph projection service
- [ ] Advanced analytics & reporting

## 🐛 Troubleshooting

### Services cannot connect to database
```bash
# Restart database containers
docker-compose restart postgres-character postgres-world postgres-contracts postgres-ledger postgres-feed
```

### Port already in use
```bash
# Stop semua containers
docker-compose down

# Cek port yang digunakan
sudo netstat -tulpn | grep :5432
sudo netstat -tulpn | grep :8080
```

### Reset all data
```bash
# Stop dan hapus semua containers + volumes
docker-compose down -v

# Start ulang
docker-compose up -d

# Seed ulang
./scripts/seed_all.sh
```

## 📚 Documentation

- [White Paper](white_paper.md) – Complete design philosophy
- [Proto Definitions](proto/) – gRPC service contracts
- [Database Schemas](migrations/) – All database migrations

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

MIT License - see LICENSE file for details

## 👥 Team

Developed following the architectural principles from the whitepaper:
- CLI-first interaction model
- Economy-first gameplay
- Reality-consistent sandbox rules
- Microservice event-driven architecture

---

**Status**: MVP Implementation Complete ✅

For questions and discussion, please open an issue in this repository.

