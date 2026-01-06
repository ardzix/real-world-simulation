## Development Progress Log

Catatan kronologis pekerjaan pada project **Realworld Simulation**.

### 2026-01-06 — Initial MVP Project Setup
- **Project bootstrap**
  - Buat struktur direktori dasar: `proto/`, `services/`, `migrations/`, `docker/`, `scripts/`, `client/`.
  - Tambah `go.mod` untuk root Go module.
- **Proto definitions (gRPC contracts)**
  - `proto/common/types.proto` — ID types, `Money`, `LocationRef`, `OwnerRef`, `UIMessage`, `CommandMetadata`, `EventEnvelope`.
  - `proto/identity/identity.proto` — Auth & user/character linkage (MVP, belum diimplementasi service-nya).
  - `proto/character/character.proto` — Character state, actions, events.
  - `proto/world/world.proto` — World topology (places, districts, travel).
  - `proto/contracts/contracts.proto` — Contracts (paper/digital), obligations, events.
  - `proto/ledger/ledger.proto` — Double-entry ledger, tax, payroll, mint events.
  - `proto/feed/feed.proto` — Player/public feed messages.

### 2026-01-06 — Core Services (Go & Rust)
- **Gateway Service (Go)**
  - File: `services/gateway/main.go`, `handlers/handler.go`, `parser/parser.go`, `router/router.go`.
  - Fitur:
    - HTTP: `POST /cmd`, `POST /cmd/text`, `GET /health`.
    - WebSocket: `GET /ws` (terminal real-time).
    - Auth stub: `POST /auth/register`, `POST /auth/login` (mock responses).
    - CLI parser + alias (`g`, `t`, `w`, `s`, `h` → `go`, `travel`, `work`, `status`, `help`).
    - Router stub untuk command dasar (`go`, `travel`, `work`, `status`, `eat`, `sleep`, `contract`).

- **Character Service (Go)**
  - File: `services/character/main.go`, `services/character/server/server.go`.
  - Koneksi ke Postgres (character DB) + stub koneksi Pulsar.
  - Struktur `Character` + operasi:
    - `GetCharacter`, `CreateCharacter`.
    - Update activity (`UpdateActivity`), needs (`UpdateNeeds`), location (`UpdateLocation`).
    - `ValidateAction` untuk cek energy & state.

- **World Service (Go)**
  - File: `services/world/main.go`, `services/world/server/server.go`.
  - Mengelola:
    - `District`, `Place`, `TravelEdge`.
  - Fitur:
    - `GetPlace`, `GetDistrict`, `ListNearbyPlaces`, `CreatePlace`, `CreateDistrict`, `CreateTravelEdge`.

- **Contracts Service (Go)**
  - File: `services/contracts/main.go`, `services/contracts/server/server.go`.
  - Struktur `Contract`, `ContractSignature`.
  - Fitur:
    - `CreateContract` (paper/digital), menyimpan terms sebagai JSON.
    - `SignContract` + auto-activate jika semua pihak sudah tanda tangan.
    - `GetContract`, `ListContracts`.

- **Ledger Service (Rust)**
  - File: `services/ledger/src/main.rs`, `services/ledger/src/ledger.rs`, `Cargo.toml`.
  - Koneksi Postgres via `sqlx`.
  - Fitur:
    - Create account.
    - Get account / balance.
    - Double-entry transaction posting (`post_transaction`).
    - Transfer antar account (`transfer`).
    - Apply tax (`apply_tax`).
    - Mint currency (`mint_currency`) + audit di `mint_audit`.
  - Invariant:
    - Debit = Kredit (kalau tidak, `UnbalancedTransaction`).
    - Cek balance untuk credit (tidak boleh minus, kecuali akun mint).

- **Feed Service (Go)**
  - File: `services/feed/main.go`, `services/feed/server/server.go`.
  - Tabel `feed_messages` + helper `CreateFeedMessage`, `ListRecentMessages`, `ProcessDomainEvent`.

### 2026-01-06 — Database & Infrastructure
- **Migrations (schema)**
  - `migrations/character_db.sql` — tabel `characters`, `character_activities`, `scheduled_actions`, `processed_commands`.
  - `migrations/world_db.sql` — `districts`, `places`, `travel_edges`, `resource_nodes`, `world_ruleset`.
  - `migrations/contracts_db.sql` — `contracts`, `contract_signatures`, `contract_obligations`, `contract_progress`, `processed_commands`.
  - `migrations/ledger_db.sql` — `accounts`, `ledger_transactions`, `ledger_entries`, `mint_audit`, `tax_rules`, `processed_commands`.
  - `migrations/feed_db.sql` — `feed_messages`, `public_feed_messages`, `player_feed_cursor`.

- **Seed data (refactor final)**
  - `migrations/seed_world.sql` — district + places + edges + resources + ruleset.
  - `migrations/seed_ledger.sql` — system accounts + tax rules.
  - `migrations/seed_contracts.sql` — demo employment & delivery contracts + signatures.
  - `migrations/seed_character.sql` — demo character (`demo-character-1`).
  - (Sebelumnya satu file `seed_data.sql` dipakai ke semua DB → menimbulkan error relation tidak ada; kemudian dipecah jadi per-DB dan script migrasi diupdate).

- **Docker infrastrukur (awal, untuk referensi)**
  - `docker-compose.yml` — Postgres per service, Pulsar, Redis, semua services (Go/Rust).
  - Dockerfiles untuk: gateway, character, world, contracts, ledger, feed.
  - Catatan: user memilih **tidak** memakai Docker di lokal, jadi bagian ini lebih berguna untuk deploy / referensi.

- **Helper & tooling**
  - `Makefile` — target `up`, `down`, `seed`, `logs`, `dev-*`, dll.
  - `README.md` — dokumentasi utama.
  - `QUICKSTART.md` — panduan 5 menit.
  - `PROJECT_STRUCTURE.md` — penjelasan struktur & arsitektur.
  - `IMPLEMENTATION_REPORT.md` — laporan implementasi MVP.

### 2026-01-06 — Local Dev (Tanpa Docker) & Integration ke VPS
- **.env & konfigurasi remote**
  - `.env` di root digunakan untuk mengarah ke DB/Pulsar/Redis di VPS:
    - `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`.
    - `CHARACTER_DB_NAME`, `WORLD_DB_NAME`, `CONTRACTS_DB_NAME`, `LEDGER_DB_NAME`, `FEED_DB_NAME` (contoh: `rws_character_db`, dst.).
    - `PULSAR_URL`, dll.

- **Run scripts (Go & Rust services)**
  - `scripts/run_character.sh`
  - `scripts/run_world.sh`
  - `scripts/run_contracts.sh`
  - `scripts/run_feed.sh`
  - `scripts/run_gateway.sh`
  - `scripts/run_ledger.sh`
  - Semua script diupdate agar:
    - Auto load `.env` dari root project.
    - Menggunakan fallback yang benar: `*_DB_HOST` → `DB_HOST` → `localhost`, dan sama untuk port.
    - Ledger: kalau `DATABASE_URL` tidak diset, dibangun dari `DB_*` dan `LEDGER_DB_NAME`.

- **Migration script (single entrypoint)**
  - `scripts/migrate_local.sh` di-update:
    - Load `.env`.
    - Ambil `PGHOST/PGPORT/PGUSER` dari `DB_HOST/DB_PORT/DB_USER`.
    - Gunakan `CHARACTER_DB_NAME`, `WORLD_DB_NAME`, dll untuk `psql -d`.
    - Set `PGPASSWORD` dari `DB_PASSWORD` supaya non-interaktif.
    - Jalankan:
      - Schema migrations untuk semua DB.
      - Seeding per-DB: `seed_world.sql`, `seed_ledger.sql`, `seed_contracts.sql`, `seed_character.sql`.

### 2026-01-06 — Client Applications
- **Terminal client (Go)**
  - File: `client/terminal/main.go`.
  - Fitur:
    - Baca input user (CLI).
    - Kirim `POST /cmd/text` ke Gateway.
    - Menampilkan hasil dengan warna + pretty-print JSON.
    - History command sederhana.

- **Web client (HTML/JS)**
  - File: `client/web/index.html`.
  - Fitur:
    - UI terminal di browser.
    - Status koneksi (health endpoint).
    - History command (panah atas/bawah).
    - Output dengan timestamp.

---

### TODO / Next Steps (High-Level)
- Wire gRPC untuk tiap service (gunakan proto yang sudah ada).
- Integrasi Pulsar beneran (publisher/consumer) di Character, World, Contracts, Ledger, Feed.
- Tambah Inventory & Logistics services.
- Tambah auth beneran (JWT) dan Identity service.
- Tambah worker untuk scheduled actions (travel/work/sleep).


