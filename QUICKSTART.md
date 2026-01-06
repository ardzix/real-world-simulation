# 🚀 Quick Start Guide

Panduan cepat untuk menjalankan Realworld Simulation dalam 5 menit.

## Prerequisites

Pastikan sudah terinstall:
- Docker
- Docker Compose

Itu saja! Semua service akan berjalan di container.

## Step 1: Clone & Setup

```bash
cd /home/ardz/Documents/realworld_simulation
```

## Step 2: Start Services

```bash
# Start semua services
make up

# Atau tanpa make:
docker-compose up -d

# Tunggu ~10 detik untuk inisialisasi
```

## Step 3: Seed Database

```bash
make seed

# Atau tanpa make:
chmod +x scripts/seed_all.sh
./scripts/seed_all.sh
```

## Step 4: Test!

### Opsi 1: Via curl

```bash
# Cek status karakter
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "status"}'

# Lihat lokasi terdekat
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "go list"}'

# Mulai kerja
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "work start"}'

# Lihat kontrak
curl -X POST http://localhost:8080/cmd/text \
  -H "Content-Type: application/json" \
  -d '{"text": "contract list"}'
```

### Opsi 2: Web Browser

Buka file `client/web/index.html` di browser:

```bash
# Linux
xdg-open client/web/index.html

# atau langsung
firefox client/web/index.html
```

Kemudian ketik commands seperti:
- `status`
- `go list`
- `work start`
- `help`

### Opsi 3: Terminal Client

```bash
# Build terminal client
cd client/terminal
go build -o terminal-client

# Run
./terminal-client
```

## Available Commands

```
status              - Lihat status karakter
go list             - Lihat lokasi terdekat
go <place>          - Pindah ke lokasi
travel list         - Lihat district yang tersedia
travel <district>   - Travel ke district lain
work start          - Mulai bekerja
work stop           - Berhenti bekerja
eat                 - Makan untuk restore hunger
sleep               - Tidur untuk restore energy
contract list       - Lihat kontrak
contract sign <id>  - Tanda tangan kontrak
help                - Bantuan
```

## Troubleshooting

### Port sudah digunakan?

```bash
# Stop services
make down

# Atau ubah port di docker-compose.yml
```

### Services tidak bisa connect?

```bash
# Restart semua
make restart

# Cek logs
make logs
```

### Reset semua data

```bash
# Hapus semua data dan start fresh
make clean
make up
make seed
```

## Cek Service Health

```bash
# Gateway health
curl http://localhost:8080/health

# Lihat running containers
docker-compose ps

# Lihat logs
docker-compose logs -f gateway
docker-compose logs -f character
```

## Stop Services

```bash
# Stop semua (data tetap ada)
make down

# Stop dan hapus semua data
make clean
```

## Development Mode

Untuk develop tanpa rebuild container:

```bash
# Start hanya databases & infrastructure
docker-compose up postgres-character postgres-world postgres-contracts postgres-ledger postgres-feed pulsar redis -d

# Run services di terminal terpisah
cd services/gateway && go run main.go
cd services/character && go run main.go
cd services/world && go run main.go
# dst...
```

## Next Steps

- Baca [README.md](README.md) untuk dokumentasi lengkap
- Baca [white_paper.md](white_paper.md) untuk design philosophy
- Explore database schema di `migrations/`
- Check proto definitions di `proto/`

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

Selamat bermain! 🎮

