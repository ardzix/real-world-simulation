# Realworld Simulation - Economic Sandbox MMO

Sebuah persistent sandbox MMO yang berfokus pada aktivitas ekonomi, tenaga kerja, logistik, dan relasi kekuasaan - bukan combat atau quest tradisional.

## 📋 Fitur Utama

- **Reality-Consistent Sandbox**: Semua aksi membutuhkan waktu, lokasi, energi, dan tools seperti di dunia nyata
- **Economy-First**: Pemain berkembang melalui kontrak, kepemilikan lahan, logistik, dan reputasi
- **NPC-Driven World**: Ekonomi dasar dijalankan oleh NPC yang mensimulasikan pekerjaan dan konsumsi
- **Command-Driven Interface**: Interaksi berbasis CLI yang dapat diakses dari berbagai client
- **Persistent World**: Dunia terus berjalan bahkan saat pemain offline

## 🏗️ Arsitektur

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

1. **Command Gateway** (Port 8080) - Entry point untuk semua client
2. **Character Service** (Port 50051) - Manajemen state karakter & aktivitas
3. **World Service** (Port 50052) - Peta, lokasi, dan travel
4. **Contracts Service** (Port 50053) - Paper & digital contracts
5. **Ledger Service** (Port 50054) - Double-entry accounting (Rust)
6. **Event Feed Service** (Port 50056) - Notifikasi dan news feed

### Databases

- **character_db** (Port 5432) - Character state & activities
- **world_db** (Port 5433) - Districts, places, travel graph
- **contracts_db** (Port 5434) - Contracts & obligations
- **ledger_db** (Port 5435) - Accounts, transactions, audit
- **feed_db** (Port 5436) - Event feed messages

### Infrastructure

- **Apache Pulsar** (Port 6650, 8080) - Event streaming backbone
- **Redis** (Port 6379) - Caching & rate limiting

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose
- Go 1.21+ (untuk development lokal)
- Rust 1.75+ (untuk Ledger service)
- Make (optional, untuk helper commands)

### Menjalankan Semua Services

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

### Testing Command Gateway

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
- `go <place>` - Pindah ke lokasi terdekat
- `go list` - Lihat lokasi yang bisa dicapai
- `travel <district>` - Travel ke district lain
- `travel list` - Lihat district yang tersedia

### Work
- `work start` - Mulai bekerja
- `work stop` - Berhenti bekerja

### Needs
- `eat` - Makan untuk restore hunger
- `sleep` - Tidur untuk restore energy

### Contracts
- `contract list` - Lihat kontrak yang dimiliki
- `contract sign <id>` - Tanda tangan kontrak

### Info
- `status` - Lihat status karakter
- `help [command]` - Bantuan

## 🔧 Development

### Run Services Locally (tanpa Docker)

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

### Database Migrations

```bash
# Apply migrations manually
docker exec -i character_db psql -U postgres -d character_db < migrations/character_db.sql
docker exec -i world_db psql -U postgres -d world_db < migrations/world_db.sql
docker exec -i contracts_db psql -U postgres -d contracts_db < migrations/contracts_db.sql
docker exec -i ledger_db psql -U postgres -d ledger_db < migrations/ledger_db.sql
docker exec -i feed_db psql -U postgres -d feed_db < migrations/feed_db.sql
```

### Connect to Databases

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

1. **No Free Money**: Mata uang hanya dicetak melalui mekanisme publik (payroll, procurement)
2. **Reality-Consistent**: Aksi membutuhkan waktu, lokasi, energi, tools
3. **Persistent State**: Dunia terus berjalan saat pemain offline
4. **Player as Economic Actor**: Progress melalui kontrak, ownership, logistics

### Contract System

- **Paper Contracts**: Memerlukan kehadiran fisik untuk create/sign
- **Digital Contracts**: Memerlukan device (phone/laptop/PC) dan network
- Contracts enforce obligations dengan deadline dan penalties

### Ledger System (Double-Entry)

- Setiap transaksi balance (debit = credit)
- Immutable audit trail
- Mint currency hanya untuk public payroll (dengan audit)
- Tax system terintegrasi

### Character Needs

- **Energy**: Berkurang saat bekerja, pulih saat tidur
- **Hunger**: Berkurang seiring waktu, pulih saat makan
- **Health**: Dipengaruhi kondisi kerja dan lingkungan

## 🎯 Roadmap

### MVP (Current)
- [x] Command Gateway dengan CLI parsing
- [x] Character service dengan state machine
- [x] World service dengan place & travel
- [x] Contracts service (paper & digital)
- [x] Ledger service dengan double-entry accounting
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
- [ ] Web client dengan UI modern
- [ ] Discord/Telegram bot adapters
- [ ] Graph projection service
- [ ] Advanced analytics & reporting

## 🐛 Troubleshooting

### Services tidak bisa connect ke database
```bash
# Restart database containers
docker-compose restart postgres-character postgres-world postgres-contracts postgres-ledger postgres-feed
```

### Port sudah digunakan
```bash
# Stop semua containers
docker-compose down

# Cek port yang digunakan
sudo netstat -tulpn | grep :5432
sudo netstat -tulpn | grep :8080
```

### Reset semua data
```bash
# Stop dan hapus semua containers + volumes
docker-compose down -v

# Start ulang
docker-compose up -d

# Seed ulang
./scripts/seed_all.sh
```

## 📚 Documentation

- [White Paper](white_paper.md) - Complete design philosophy
- [Proto Definitions](proto/) - gRPC service contracts
- [Database Schemas](migrations/) - All database migrations

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
- CLI-First interaction model
- Economy-First gameplay
- Reality-Consistent sandbox rules
- Microservice event-driven architecture

---

**Status**: MVP Implementation Complete ✅

Untuk pertanyaan dan diskusi, buka issue di repository ini.

