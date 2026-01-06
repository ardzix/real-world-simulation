  
📘 WHITE PAPER

Command-Driven Economic Sandbox MMO

CLI-First, Economy-First, Reality-Consistent

⸻

1. Executive Summary

This project is a persistent sandbox MMO centered on economic activity, labor, logistics, and power relations, rather than combat stats or scripted progression.

Players inhabit a world that:

	•	runs continuously with or without players,

	•	is governed by economic rules instead of quests,

	•	allows inequality, failure, and collapse to occur naturally.

The game uses a command-driven interaction model (CLI-first) to drastically reduce UI and content production cost, while enabling deep systemic simulation. All player actions are expressed as physical or social commands executed by a character inside the world.

The backend is built on Django, emphasizing:

	•	data integrity,

	•	auditable economic flows,

	•	long-term maintainability.

⸻

2. Core Design Philosophy

2.1 Reality-Consistent Sandbox

The sandbox follows a reality-consistency rule:

If an action would require time, location, energy, or tools in real life,

it must require the same in-game.

There are:

	•	no instant actions without context,

	•	no magical menus,

	•	no abstract “economy buttons”.

The system does not protect players from:

	•	bad decisions,

	•	exploitation,

	•	inequality,

	•	systemic failure.

Instead, it ensures that rules are consistent and observable.

⸻

2.2 Player as Economic Actor (Not a Hero)

Players do not progress via:

	•	XP

	•	levels

	•	skill trees

Instead, players progress through:

	•	access to contracts

	•	ownership or control of land

	•	logistics capability

	•	reputation

	•	institutional leverage

A player can become powerful without ever fighting, and can fail without ever losing a battle.

⸻

3. World Model

3.1 NPC-First Persistent World

The world is fully simulated before any player joins.

NPCs:

	•	operate mines, factories, logistics, public services

	•	receive salaries

	•	consume resources

	•	produce inefficiencies

NPCs ensure:

	•	baseline economic activity

	•	price signals

	•	public services availability

Players do not create demand.

Players replace or outperform NPC roles.

⸻

3.2 Land and Facility System

Land

	•	Land is the only ownable immovable asset

	•	Land ownership is exclusive and persistent

	•	Land defines:

	•	zoning

	•	extraction rights

	•	construction permissions

Facilities

Facilities are states attached to land, not assets themselves.

A facility:

	•	can be built

	•	upgraded

	•	downgraded

	•	destroyed

Facilities require:

	•	construction materials

	•	labor

	•	machinery

	•	permits

	•	time

Facilities can be leased independently of land ownership.

This separation prevents “factory spam” and ensures land scarcity remains meaningful.

⸻

3.3 De Jure vs De Facto Power

De Jure (System-Recorded)

De jure structures are:

	•	administrative

	•	hierarchical

	•	explicitly recorded

Examples:

	•	districts

	•	offices

	•	mayors

	•	public payroll

	•	tax authority

There is always one official truth in the system.

⸻

De Facto (Emergent, Unrecorded)

De facto power:

	•	is not stored as a variable

	•	has no meter or flag

	•	exists only through actions

Examples:

	•	extortion

	•	protection rackets

	•	intimidation

	•	informal agreements

The system records events, not claims.

A territory is “controlled” only if actions enforce it.

⸻

4. Economy & Minting Rules

4.1 In-Game Currency Definition

In-game currency represents:

	•	wages

	•	settlement medium

	•	tax base

It is not a reward currency.

⸻

4.2 Currency Minting Rules

Currency can only be minted through public-sector mechanisms:

1. Public Payroll Replacement

When a public role exists (police, sanitation, EMS):

	•	NPCs normally fill it

	•	NPC salary is minted

When a player replaces the NPC:

	•	salary continues

	•	minting continues

	•	flow is redirected

Players capture existing money flow, not generate new demand.

⸻

2. Government Procurement

Public infrastructure requires:

	•	materials

	•	labor

	•	logistics

Government contracts mint currency upon payout.

Budgets are:

	•	finite

	•	time-bound

	•	politically constrained

⸻

3. Emergency Liquidity (Central Bank)

Used only to:

	•	prevent total system freeze

	•	stabilize payroll during crises

This is:

	•	rare

	•	publicly visible

	•	reversible

⸻

4. Catastrophic Compensation

Triggered only by:

	•	large disasters

	•	systemic failures

	•	critical bugs (meta-level)

Not repeatable, not farmable.

⸻

4.3 Prohibited Minting Sources

Currency is never minted from:

	•	player trades

	•	PvP

	•	marketplace

	•	quests

	•	daily login

	•	achievements

All such actions are redistribution only.

⸻

5. Public Payroll Funding Composition

Public payroll is funded in this order:

	1\. Tax Revenue (60–70%)

Income tax, transaction tax, property tax, fines.

	2\. Government Enterprises / BUMN (20–30%)

Utilities, transport, logistics, public media.

	3\. Minted Currency (0–10% normal, up to 35% in crisis)

Emergency buffer only.

Minting:

	•	cannot exceed tax revenue

	•	cannot be permanent

	•	must be publicly reported

⸻

6. Resource Economy

6.1 Resource Creation

Resources are created only via extraction:

	•	mining

	•	farming

	•	drilling

	•	harvesting

There is:

	•	no respawn

	•	no magic regeneration

⸻

6.2 Resource Lifecycle

Resources:

	•	transform through production chains

	•	degrade over time

	•	can be recycled partially

Scarcity is real and cumulative.

⸻

7. Dual Transaction System

7.1 In-Game Transactions

Characteristics:

	•	physical presence

	•	negotiation

	•	in-game currency

	•	taxation

	•	exposure to crime and failure

Used for:

	•	local labor

	•	informal deals

	•	grey economy

⸻

7.2 Marketplace Transactions

Characteristics:

	•	formal platform

	•	escrow-based

	•	marketplace currency

	•	platform cut

	•	compliance rules

Marketplace currency:

	•	purchased with real money

	•	non-withdrawable

	•	non-convertible to in-game currency

Marketplace trades are safer but more expensive.

⸻

8. Marketplace Currency Usage (Sandbox-Safe)

Marketplace currency can buy:

	•	administrative acceleration

	•	escrow and arbitration services

	•	insurance contracts (player-driven)

	•	listing priority and visibility

	•	settlement speed

	•	analytics and reporting

	•	cosmetic branding

	•	access to tenders or auctions

Marketplace currency cannot buy:

	•	resources

	•	production multipliers

	•	immunity

	•	combat power

	•	exclusive choke points

⸻

9. Developer Role (Infrastructure Only)

The developer operates as neutral infrastructure, not a market participant.

9.1 Central Bank

	•	sets monetary rules

	•	manages settlement

	•	emergency liquidity only

9.2 Stock Exchange

	•	company listings

	•	shares

	•	IPO

	•	trading fees only

9.3 Internet Authority & Public Media

	•	domains

	•	hosting

	•	ads infrastructure

	•	official news

	•	economic indicators

All dev institutions are:

	•	passive

	•	rule-based

	•	contestable via gameplay

⸻

10. Player Character Model

Each character has:

	•	location

	•	current activity

	•	energy

	•	hunger

	•	health

	•	inventory

	•	active contracts

There are no abstract action points.

⸻

11. Time-Based Action System

All actions:

	•	consume time

	•	consume energy

	•	may introduce risk

Actions continue when logged out.

The simulation advances via server ticks, not client presence.

⸻

12. Command-Driven Interface

12.1 Command Philosophy

Commands represent physical or social actions, not menus.

Examples:

	•	go job-center

	•	work start

	•	operate drill

	•	drive to warehouse

	•	eat

	•	sleep

	•	sign contract

Commands are:

	•	contextual

	•	state-validated

	•	duration-based

⸻

12.2 Movement Discovery

	•	go list shows nearby reachable locations

	•	travel list shows districts/cities

No guessing destinations.

⸻

12.3 Contract Interfaces

Contracts are created via:

	•	paper interaction (physical presence)

	•	digital devices (phone, laptop, PC)

contract create is never globally available.

⸻

13. Client Applications

All clients are thin clients:

	•	Terminal (MVP)

	•	Desktop

	•	Web

	•	Telegram bot

	•	Discord bot

All clients send commands to the same backend.

⸻

14. Technical Architecture (Django-Based)

14.1 Backend

	•	Django

	•	ORM as source of truth

	•	strong data integrity

	•	Django REST Framework

	•	command endpoint

	•	Django Channels

	•	WebSocket events

	•	Celery / Django-Q

	•	simulation ticks

	•	delayed actions

⸻

14.2 Data Layer

	•	PostgreSQL

	•	state

	•	ledger

	•	contracts

	•	event log

	•	Redis

	•	cache

	•	pub/sub

	•	rate limiting

⸻

14.3 Architecture Pattern

	•	Server-authoritative

	•	Event-sourced (append-only logs)

	•	Command → Validation → State Change → Event

⸻

15. Emergent Gameplay (Non-Scripted)

The system naturally produces:

	•	labor exploitation

	•	strikes

	•	inflation / deflation

	•	black markets

	•	logistics choke points

	•	political unrest

	•	corporate monopolies

	•	organized crime

No scripted questlines required.

⸻

16. Development Doctrine (Hard Rules)

	1\. No free money

	2\. No hidden minting

	3\. No dev-owned competitive assets

	4\. No UI bypassing reality

	5\. Every convenience has a cost

	6\. Consequences persist

⸻

17. Status

Core Mechanics: LOCKED

Economic Rules: LOCKED

Interaction Model: LOCKED

Tech Direction (Django): LOCKED

This document is sufficient as:

	•	development blueprint

	•	architectural guardrail

	•	design constitution

System Architecture, Map Generation, and NPC Mind Control

Command-Driven Economic Sandbox MMO (Django + gRPC + Pulsar)

⸻

1) System Architecture Overview

1.1 Architectural Goals

The architecture is designed to support a persistent sandbox MMO where gameplay is expressed as commands(e.g., go, work, drive, operate drill, sleep) executed by characters in a simulated world. The system prioritizes:

	•	Modularity and microservice readiness, so domains can be separated without rewriting logic.

	•	Auditability and economic integrity, ensuring currency/resource rules are enforceable and traceable.

	•	Event-driven simulation, where long-running actions and world progression occur asynchronously and reliably.

	•	Low client complexity, enabling multiple clients (terminal, web, desktop, Discord/Telegram bots) without duplicating business rules.

⸻

1.2 Core Interaction Model: Command → State Change → Event

All player actions follow the same pipeline:

	1\. Client sends a command (text CLI or button-driven structured command).

	2\. Command Gateway authenticates and routes the command to the owning domain service via gRPC.

	3\. The domain service validates preconditions (location, tools, contracts, energy, legal state).

	4\. If accepted, the service mutates authoritative state in its own database.

	5\. The service publishes a domain event to Pulsar (append-only stream).

	6\. Downstream services consume the event to react (payroll, inventory movement, contract progress, notifications).

This pattern ensures:

	•	strict domain ownership,

	•	minimal coupling,

	•	deterministic core simulation,

	•	consistent event history for projections and feeds.

⸻

2) Backend Service Layout (Microservice-Ready)

2.1 Edge Layer

Command Gateway Service (Django)

The gateway is the single entry point for all clients. Its responsibilities are orchestration and formatting, not domain logic.

	•	Accepts commands through HTTP (POST /cmd) and optionally provides WebSocket (/events) for streaming responses.

	•	Parses CLI text into structured commands.

	•	Performs authentication/authorization by calling Identity via gRPC.

	•	Routes commands to domain services via gRPC.

	•	Normalizes response into UI-agnostic message blocks (text, table, options), so any client can render them.

The gateway stays thin so you can add new clients cheaply without changing domain logic.

⸻

2.2 Domain Services (MVP-critical)

Identity Service

Owns authentication and identity mapping.

	•	Issues and validates tokens.

	•	Links user to character(s).

Used by: Command Gateway, all services needing identity verification.

⸻

Character Service (State Machine Authority)

Owns the “player character state” and is the primary authority for moment-to-moment gameplay.

It stores:

	•	location

	•	activity state (idle, traveling, working, driving, operating, sleeping)

	•	needs (energy, hunger, health)

	•	equipment slots (e.g., has phone/laptop, license flags)

It validates and executes commands like:

	•	go / travel

	•	work start/stop

	•	eat

	•	sleep

	•	enter vehicle

	•	“start operation” as a physical operator (delegated checks to other services)

It emits events such as:

	•	activity started/completed

	•	location changed

	•	needs updated

	•	action blocked (with reason)

⸻

World Service (World Data Authority)

Owns map definitions and world metadata used by routing and discovery.

It provides:

	•	go list output: nearby reachable places from current location

	•	travel list output: travel destinations from district

	•	place resolution (place IDs, facility IDs)

	•	travel graph information (roads/links)

World Service is authoritative for:

	•	static/semi-static world structure

	•	travel topology and distances

⸻

Contracts Service (Obligations & Enforcement)

Owns contract lifecycle and the distinction between paper vs digital contracts.

Key rules:

	•	Paper contracts require physical presence (e.g., sign contract at site).

	•	Digital contracts require device access (phone/laptop/PC + network + permissions).

Contracts Service controls:

	•	contract creation and signing

	•	obligations, deadlines, penalties

	•	completion and breach conditions

This service emits events:

	•	contract created, signed, activated

	•	contract progressed/completed

	•	contract breached (with penalty instructions)

⸻

Ledger Service (Currency Integrity)

Owns in-game currency and provides auditable transfers.

Responsibilities:

	•	account balances

	•	taxation events

	•	payroll payouts

	•	fines/penalties

	•	rare/controlled minting (with strict audit trail)

This service is strongly consistent and should be implemented as:

	•	double-entry ledger tables

	•	idempotent transaction posting

	•	immutable posting records

Ledger is the enforcement point for “no free money” and “minting constraints.”

⸻

2.3 Domain Services (Phase 2 / soon)

Inventory Service

Owns items and goods location.

It tracks:

	•	ownership (player, facility, vehicle)

	•	quantities and item types

	•	movements (load/unload, produce/consume)

It reacts to:

	•	production/extraction outputs

	•	logistics cargo handling

	•	contract delivery requirements

⸻

Logistics Service

Owns vehicles, shipments, cargo manifests, and movement updates.

It handles:

	•	entering/exiting vehicles

	•	driving actions (validated against character and world)

	•	creating shipments (NPC or player)

	•	cargo load/unload

	•	delivery completion events

⸻

Production & Extraction Service

Owns facilities that generate raw materials and goods.

It models:

	•	extraction rates

	•	reserve depletion

	•	machine wear and maintenance requirements

	•	production queues and outputs

This service is the authority for resource generation, ensuring it happens only via extraction/production rules, not arbitrary spawning.

⸻

3) Event-Driven Backbone (Apache Pulsar)

3.1 Why Pulsar

Pulsar is used to decouple services and to ensure long-running simulation remains reliable. It supports:

	•	scalable consumers (KeyShared)

	•	partitioned topics for high volume

	•	durable event history

3.2 Topic Strategy

Use one tenant and namespaces per domain:

	•	persistent://game/char/character.events

	•	persistent://game/world/world.events

	•	persistent://game/contract/contract.events

	•	persistent://game/ledger/ledger.events

	•	persistent://game/inv/inventory.events

	•	persistent://game/log/logistics.events

	•	persistent://game/prod/production.events

	•	persistent://game/npc/npc.events

Message keys should be chosen to preserve ordering where it matters:

	•	character_id for character stream

	•	contract_id for contract stream

	•	account_id for ledger stream

	•	npc_id for NPC stream

⸻

4) Scheduling, Ticks, and Long Actions

4.1 Avoid “global ticks” in MVP

To keep costs low, the system uses scheduled actions instead of a global per-second tick.

Each authoritative service maintains:

	•	a scheduled actions table: (id, due_time, payload, status)

	•	a worker (Celery) that picks due actions, applies them, and emits completion events

This supports:

	•	travel ETA

	•	shift completion

	•	machine operation cycles

	•	sleep/rest completion

It also ensures actions continue while the player is offline.

⸻

5) Database Approach (Postgres First, Graph Later)

5.1 PostgreSQL as Source of Truth

Each service owns its Postgres schema, enabling:

	•	data integrity and constraints

	•	clean service boundaries

	•	reliable auditing (especially for ledger)

5.2 Graph as Projection/Read Model (Later)

Graph storage is not used for authoritative state.

Instead, a future Graph Projection Service can consume Pulsar events and maintain a graph for:

	•	route optimization queries

	•	social/interaction network queries

	•	hotspot/choke point analysis

This approach preserves microservice autonomy while enabling graph-style insights when needed.

⸻

6) Procedural Map Generation (WorldGen)

6.1 Design Goal

Map generation must produce:

	•	natural world layout

	•	meaningful logistics topology (choke points)

	•	resource distribution that supports supply chains

	•	deterministic and reproducible results

The map must be “alive” but never violate economic rules (no magical resource creation).

⸻

6.2 WorldGen Service Responsibilities

WorldGen is a separate service that produces district specs.

A district spec includes:

	•	district boundary + zones

	•	land parcels

	•	roads and travel links (graph)

	•	POIs (job center, shelters, markets)

	•	resource nodes (potential extraction sites, with reserves)

	•	initial public infrastructure placements

WorldGen outputs are versioned by:

	•	seed

	•	ruleset_version

	•	district_id

This guarantees reproducibility:

same seed + ruleset_version → same district

⸻

6.3 DeepSeek-Assisted Generation (Planner, Not Authority)

DeepSeek can be used to help generate human-like layouts and narratives, but the output must be constrained.

Recommended approach:

	1\. deterministic procedural system generates a candidate layout

	2\. DeepSeek is asked to propose refinements within constraints:

	•	improve realism (zoning coherence, road naming, POI distribution)

	•	suggest story-friendly neighborhoods

	•	suggest likely choke points

	3\. WorldGen validates and applies only constraint-safe changes

	4\. World Service stores the final district spec

DeepSeek is never allowed to:

	•	create new reserves beyond configured distributions

	•	spawn rare nodes without probability constraints

	•	override determinism without versioning

⸻

6.4 World Expansion Model

The world can expand via “frontier expansion”:

	•	new district generated when population/economy reaches thresholds

	•	expansion is explicit, not continuous

This keeps server load predictable and supports “metropolis growth” over time.

⸻

7) NPC Control System (Schedule + Mind)

7.1 Two-Layer NPC Model

NPC behavior uses a two-layer model to control cost and preserve determinism:

	1\. NPC Schedule Layer (Deterministic Routine)

	•	baseline behavior

	•	always running

	•	cheap to compute

	•	ensures NPCs keep the economy alive

	2\. NPC Mind Layer (LLM Planner)

	•	runs occasionally

	•	generates adaptive “plans”

	•	makes NPC behavior feel alive and reactive

	•	never directly mutates authoritative simulation state

⸻

7.2 NPC Schedule Service (Baseline)

This service defines:

	•	daily/weekly/monthly schedule templates

	•	role constraints (workplace, shift windows, home location)

	•	allowed activity types and durations

	•	safety constraints (e.g., avoid travel at night for low-risk NPCs)

Schedule service drives activity execution by sending commands (internally) to Character/Logistics/Production systems.

NPCs can:

	•	go to work

	•	operate machines

	•	eat and sleep

	•	commute

	•	shop

	•	attend monthly meetings

If LLM is offline, NPCs remain functional because schedules still run.

⸻

7.3 NPC Mind Service (DeepSeek Planner)

The Mind Service makes NPCs feel alive by periodically updating:

	•	preferences (risk tolerance, spending habits, social alignment)

	•	goals (save money, buy device, move district)

	•	schedule adjustments (switch shift, choose safer route)

	•	negotiation style (aggressive/cautious)

Important: Planner-only rule

Mind Service outputs proposals, not direct actions.

Outputs are emitted as events like:

	•	npc.mind.profile.updated

	•	npc.mind.schedule.patch

	•	npc.mind.intent.updated

The Schedule Service applies them only if:

	•	they pass constraints

	•	they are feasible (resources, location, time)

	•	they do not violate game rules

⸻

7.4 NPC Memory & Log Summarization

NPC logs should not be sent raw to DeepSeek. Instead:

	•	consume events related to the NPC

	•	aggregate per time window (daily/weekly)

	•	produce a structured summary (“memory slice”)

Example contents:

	•	work attendance

	•	earnings and spending

	•	incidents witnessed/experienced

	•	relationships (who helped/harmed them)

	•	contracts completed/breached

This summary is what Mind Service sends to DeepSeek.

This reduces:

	•	cost

	•	unpredictability

	•	privacy leakage

	•	token usage

⸻

7.5 Update Frequency (Cost Control)

NPC mind updates are tiered:

	•	Common NPC: weekly

	•	Key NPC (boss, mayor, gang leader): daily

	•	Reactive update: after major event (robbed, injured, fired)

A global budget caps:

	•	number of LLM calls per day

	•	token budget

	•	max update frequency per NPC

When budgets are exceeded:

	•	fallback to schedule-only mode

⸻

7.6 NPC “Feels Alive” Outcome

NPCs feel alive when they:

	•	show consistent patterns over time

	•	adapt to consequences (avoid dangerous areas, change jobs)

	•	remember relationships (trust, fear, loyalty)

	•	pursue long-term goals under constraints

The system produces “life-like” behavior without sacrificing:

	•	determinism of core simulation

	•	economic integrity

	•	predictable infrastructure cost

⸻

8) How This Fits With Multi-Client Plan

MVP uses Terminal client, but architecture supports:

	•	web chat + buttons

	•	desktop app

	•	Telegram/Discord bots

All clients send commands to the Command Gateway; none contain business logic.

Event Feed service consumes Pulsar and delivers:

	•	personal event streams

	•	public news channels

	•	Discord/Telegram announcements

⸻

9) MVP Implementation Sequence (Recommended)

	1\. Identity + Command Gateway

	2\. Character + World (go list, travel list, state machine)

	3\. Paper job contracts + payroll via Ledger

	4\. Scheduled actions (travel ETA, work duration, sleep)

	5\. Event feed (news tail)

	6\. Inventory + Logistics (vehicle + shipments)

	7\. Production/Extraction

	8\. NPC Schedule (baseline economy)

	9\. NPC Mind (DeepSeek planning)

	10\. WorldGen (procedural districts) + expansion triggers

	11\. Graph projection service (optional, later)

Best language per microservice

Edge / Platform

	•	Command Gateway (HTTP + WebSocket + gRPC routing): Go

Best for high concurrent connections, low latency, low memory, simple ops.

	•	Event Feed / Notifications (Pulsar → WS/clients): Go

Best for fanout streaming, backpressure handling, and long-lived connections.

	•	Discord Adapter (bot + slash commands + embeds): Go

Best for stable long-running bot + event-driven posting.

	•	Telegram Adapter (bot + inline buttons): Go

Best for stable long-running bot + high message throughput.

⸻

Core Gameplay (hot path)

	•	Character Service (state machine, needs, action scheduling): Go

Best balance of concurrency, speed, and development velocity for core gameplay loops.

	•	World Service (places, topology, go list/travel list, caches): Go

Best for read-heavy queries with caching and low latency.

	•	Logistics Service (vehicles, shipments, ETAs, movement updates): Go

Best for timer-heavy, concurrent, event-driven movement.

	•	Inventory Service (high-volume item movements, ownership/location): Go

Best for throughput + reliability + straightforward idempotency patterns.

	•	Contracts Service (paper/digital, obligations, breaches): Go

Best for rule-heavy workflow service without sacrificing performance.

⸻

Economy Integrity (correctness critical)

	•	Ledger Service (money, tax, payroll, mint audit): Rust

Best for strict invariants, correctness-by-construction, and audit-safe concurrency.

	•	Central Bank / Monetary Policy Service (policy knobs, mint authorization): Rust

Best to keep monetary governance in the same “correctness-first” language family as Ledger.

⸻

Simulation Engines (deterministic + CPU-heavy)

	•	Production & Extraction Service (queues, depletion, machine wear): Rust

Best for deterministic simulation, performance, and safety.

	•	WorldGen Service (procedural generation, seed determinism): Rust

Best for reproducibility and heavy generation workloads.

⸻

NPC System (schedule + LLM mind)

	•	NPC Schedule Service (deterministic routines, always-on): Go

Best for scalable, low-cost scheduling and event-driven execution.

	•	NPC Mind Service (LLM planner, memory summarization, evaluation): Python

Best ecosystem for DeepSeek integration, prompt tooling, structured outputs, and rapid iteration.

⸻

Data Pipeline / Projections

	•	Projection Services (read models, indexes, “official record”, analytics streams): Go

Best for Pulsar-consuming, high-throughput projections with simple ops.

	•	Graph Projection Service (later; routing/social queries from events): Go

Best for building and serving graph-like projections from event streams.

⸻

One-line summary

	•	Go for everything high-concurrency + event plumbing + hot path gameplay

	•	Rust for money + deterministic simulation engines

	•	Python for LLM-driven NPC mind

Awesome. Below is a service catalog you can treat as the “architecture contract” for implementation. For each service I include:

	•	Purpose / responsibilities

	•	gRPC surface (core methods)

	•	Pulsar topics produced / consumed

	•	Owned DB tables (Postgres)

	•	Notes (idempotency, keys, invariants)

Conventions used:

	•	tenant: persistent://game

	•	namespace per domain

	•	Message key for ordering: character_id, npc_id, contract_id, account_id, shipment_id, etc.

	•	Every command has command_id for idempotency.

⸻

0) Cross-cutting Contracts

0.1 Proto strategy

	•	Each service owns its own .proto package (e.g., game.character.v1)

	•	Shared types (IDs, timestamps, Money, LocationRef, UIMessage) go in a common proto repo: game.common.v1

0.2 Event envelope (all Pulsar events)

Every event payload MUST include:

	•	event_id (uuid)

	•	event_type (string)

	•	occurred_at (timestamp)

	•	producer_service

	•	schema_version

	•	entity_type, entity_id (e.g., character, char_123)

	•	correlation_id (command_id / saga_id)

	•	actor (player_id / npc_id / system)

⸻

1) Edge / Platform Services (Go)

1.1 Command Gateway Service (Go)

Purpose

Single entry point for all clients (terminal/web/bots). Parses and routes commands to domain services via gRPC and formats responses into UI-agnostic blocks.

gRPC (server-side)

Normally none (it’s an HTTP/WS edge). Internally it is a gRPC client to all services.

HTTP/WS

	•	POST /cmd (structured command)

	•	POST /cmd/text (CLI text → structured command)

	•	WS /events (optional; if you want gateway to stream a merged feed)

Pulsar

	•	Produces: none (keep gateway stateless)

	•	Consumes (optional): player.feed.\* if it relays events to WS

Owned DB tables

	•	command_audit_log (optional; for debugging / tracing)

	•	rate_limit_bucket (optional; can also be Redis)

Notes

	•	No domain logic.

	•	Must attach command_id and pass through correlation_id everywhere.

⸻

1.2 Event Feed / Notification Service (Go)

Purpose

Consumes domain events and publishes:

	•	per-player feed streams (for news tail, personal notifications)

	•	public channels (official record, district news)

	•	outbound bot posts (Discord/Telegram)

gRPC

	•	SubscribePlayerFeed(player_id) (WS alternative is fine too)

	•	ListRecentFeed(player_id, cursor, limit)

	•	ListPublicFeed(channel_id, cursor, limit)

Pulsar

	•	Consumes: all domain event topics (char, contract, ledger, logistics, prod, npc, world)

	•	Produces:

	•	persistent://game/feed/player.feed (partitioned; key=player_id)

	•	persistent://game/feed/public.feed (key=channel_id)

	•	persistent://game/feed/delivery.status (optional)

Owned DB tables

	•	feed_event (append-only, partitioned by date)

	•	player_feed_cursor (optional)

	•	public_channel / player_channel_subscriptions (optional)

Notes

	•	This is the “glue” for multi-client UX.

	•	Keep it purely projection + delivery (no authoritative state).

⸻

1.3 Discord Adapter Service (Go)

Purpose

Bridge between Discord and Command Gateway + Feed. Slash commands → /cmd, and event feed → channel posts.

gRPC

None (client of Command Gateway/Feed).

Pulsar

	•	Consumes: feed.public.feed, optionally feed.player.feed for DM

	•	Produces: none (posts to Discord)

Owned DB tables

	•	discord_guild_config (channel mapping)

	•	discord_user_link (discord_id ↔ player_id)

⸻

1.4 Telegram Adapter Service (Go)

Same pattern as Discord.

Owned DB tables

	•	telegram_chat_config

	•	telegram_user_link

⸻

2) Core Gameplay Services (Go)

2.1 Character Service (Go)

Purpose

Authoritative character state machine:

	•	location, activity, needs (energy/hunger/health)

	•	validates “physical possibility”

	•	schedules long actions (travel/work/sleep) via internal scheduler

gRPC

	•	GetCharacter(character_id)

	•	GetStatus(character_id) (lightweight snapshot)

	•	SubmitAction(character_id, action_type, params, command_id)

	•	CancelAction(character_id, command_id) (where allowed)

	•	ListAvailableActions(character_id) (optional UX helper)

Action types examples:

	•	GO, TRAVEL, WORK_START, WORK_STOP, SLEEP, REST, EAT

	•	ENTER_VEHICLE, EXIT_VEHICLE (logistics integration)

	•	OPERATE_START, OPERATE_STOP (production integration)

Pulsar

	•	Produces: persistent://game/char/character.events (key=character_id)

	•	character.location.changed

	•	character.activity.started|completed|canceled

	•	character.needs.updated

	•	character.action.rejected

	•	Consumes:

	•	contract.contract.events (to check eligibility/progress if you want async)

	•	logistics.logistics.events (vehicle entered/exited, accidents)

	•	npc.npc.events (if NPCs reuse Character mechanics)

Owned DB tables

	•	character

	•	character_needs

	•	character_activity (current + history)

	•	character_location

	•	scheduled_action (due_time, payload, status)

	•	processed_command (idempotency)

Notes

	•	This is hot path; keep queries indexed and snapshots lightweight.

	•	Never calls LLM.

⸻

2.2 World Service (Go)

Purpose

Authoritative world directory + travel topology.

Provides go list and travel list outputs and resolves location references.

gRPC

	•	ListNearbyLocations(character_location)

	•	ListTravelDestinations(district_id)

	•	ResolvePlace(query_text) → PlaceRef

	•	GetPlace(place_id)

	•	GetTravelCost(origin, destination) (time, risk hints, distance)

Pulsar

	•	Produces: persistent://game/world/world.events

	•	world.place.created|updated

	•	world.district.created|expanded

	•	Consumes: worldgen.worldgen.events (district specs)

Owned DB tables

	•	district

	•	place (job center, shelter, facility entrance, etc.)

	•	travel_edge (graph edges: from_place, to_place, distance, base_risk)

	•	zoning

	•	resource_node (potential + reserves reference)

	•	world_ruleset (ruleset_version)

Notes

	•	Keep topology in relational tables; later you can project to graph.

⸻

2.3 Contracts Service (Go)

Purpose

Creates and enforces paper vs digital contracts and obligations.

Contracts are not “UI commands”; they are created via contextual interactions.

gRPC

	•	CreatePaperContract(issuer, counterparty, terms, command_id)

	•	CreateDigitalContract(issuer, counterparty, terms, device_proof, command_id)

	•	SignContract(contract_id, signer, command_id)

	•	ActivateContract(contract_id) (optional; or activation on sign)

	•	GetContract(contract_id)

	•	ListContracts(owner_id, filters)

	•	ReportProgress(contract_id, progress_event) (optional)

	•	EvaluateBreach(contract_id) (usually internal)

Pulsar

	•	Produces: persistent://game/contract/contract.events (key=contract_id)

	•	contract.created

	•	contract.signed

	•	contract.activated

	•	contract.progressed

	•	contract.completed

	•	contract.breached

	•	Consumes:

	•	char.character.events (attendance/work completed, location)

	•	log.logistics.events (deliveries)

	•	ledger.ledger.events (payout confirmation if needed)

Owned DB tables

	•	contract

	•	contract_party

	•	contract_terms

	•	contract_obligation

	•	contract_signature

	•	contract_event (internal history)

	•	processed_command

Notes

	•	Breach logic should be deterministic and auditable.

	•	Contracts never directly move money; they request ledger actions via event/saga.

⸻

2.4 Inventory Service (Go)

Purpose

Authoritative ownership/location of items and resources:

	•	character inventory

	•	facility stockpiles

	•	vehicle cargo

	•	shipment manifests (or delegated to logistics, but inventory should be source of truth)

gRPC

	•	ListInventory(owner_ref)

	•	MoveItem(item_id, from_ref, to_ref, qty, command_id)

	•	ConsumeItem(owner_ref, item_type, qty, reason, command_id)

	•	CreateItem(owner_ref, item_type, qty, provenance, command_id) (for production output)

	•	GetItem(item_id)

Pulsar

	•	Produces: persistent://game/inv/inventory.events (key=owner_ref or item_id)

	•	inventory.moved

	•	inventory.consumed

	•	inventory.produced

	•	Consumes:

	•	prod.production.events (extraction/production output requests)

	•	log.logistics.events (load/unload confirmations)

	•	contract.contract.events (delivery requirement checks)

Owned DB tables

	•	item_type

	•	item_instance (optional; if unique items exist)

	•	inventory_balance (owner_ref, item_type, qty) — fast path for stackables

	•	inventory_movement (append-only)

	•	processed_command

Notes

	•	Use idempotency strongly; movement duplicates are catastrophic.

	•	Consider “balance table + movement log” for audit.

⸻

2.5 Logistics Service (Go)

Purpose

Vehicles + shipments + ETA updates.

Owns:

	•	vehicle state (fuel, condition, location)

	•	shipment lifecycle (created → moving → delivered)

	•	cargo operations coordination (calls Inventory)

gRPC

	•	ListVehicles(owner_ref)

	•	EnterVehicle(character_id, vehicle_id, command_id)

	•	ExitVehicle(character_id, vehicle_id, command_id)

	•	DriveTo(vehicle_id, destination_place, command_id)

	•	CreateShipment(origin, destination, cargo_spec, command_id)

	•	LoadCargo(shipment_id, from_ref, item_type, qty, command_id)

	•	UnloadCargo(shipment_id, to_ref, item_type, qty, command_id)

	•	GetShipment(shipment_id)

Pulsar

	•	Produces: persistent://game/log/logistics.events (key=shipment_id or vehicle_id)

	•	logistics.vehicle.entered|exited

	•	logistics.shipment.created

	•	logistics.shipment.moved (periodic)

	•	logistics.shipment.delivered

	•	logistics.accident.occurred (optional)

	•	Consumes:

	•	char.character.events (driver availability)

	•	world.world.events (topology updates)

	•	contract.contract.events (contract-linked shipments)

Owned DB tables

	•	vehicle

	•	vehicle_location

	•	vehicle_condition

	•	shipment

	•	shipment_leg (route segments)

	•	shipment_cargo_spec

	•	scheduled_action

	•	processed_command

Notes

	•	All ETAs are scheduled actions + event emission.

	•	Don’t embed money logic here.

⸻

3) Simulation Engines (Rust)

3.1 Production & Extraction Service (Rust)

Purpose

Deterministic production engine:

	•	extraction from resource nodes

	•	facility production queues

	•	machine wear/maintenance

	•	outputs goods/events for Inventory

gRPC

	•	StartOperation(machine_id, operator_ref, command_id)

	•	StopOperation(machine_id, command_id)

	•	GetMachine(machine_id)

	•	GetFacilityQueue(facility_id)

	•	ScheduleProduction(facility_id, recipe_id, qty, command_id)

	•	PerformMaintenance(machine_id, parts_ref, command_id)

Pulsar

	•	Produces: persistent://game/prod/production.events (key=facility_id or machine_id)

	•	production.operation.started|stopped|completed

	•	production.resource.extracted

	•	production.item.output.ready (request inventory create/move)

	•	production.machine.degraded

	•	Consumes:

	•	world.world.events (resource node definitions, facility placement)

	•	inv.inventory.events (maintenance parts consumed confirmation)

	•	char.character.events (operator presence if needed)

Owned DB tables

	•	facility

	•	machine

	•	machine_status

	•	resource_reserve (remaining amount, depletion model)

	•	production_recipe

	•	production_queue

	•	scheduled_action

	•	processed_command

Notes

	•	Must be deterministic: same state + inputs → same outputs.

	•	Never mints currency; only produces goods.

⸻

3.2 Ledger Service (Rust)

Purpose

Financial integrity service:

	•	double-entry ledger

	•	taxation

	•	payroll payouts (including public payroll + BUMN + limited mint)

	•	penalties/fines

	•	strict audit trail

gRPC

	•	GetBalance(account_id)

	•	PostTransaction(entries\[\], command_id) (double-entry)

	•	Transfer(from, to, amount, reason, command_id) (wraps PostTransaction)

	•	ApplyTax(tax_type, base_ref, amount, command_id)

	•	PayrollPayout(payroll_id, recipient_account, gross, ruleset_ref, command_id)

	•	GetLedgerEntries(account_id, cursor, limit)

Pulsar

	•	Produces: persistent://game/ledger/ledger.events (key=account_id or txn_id)

	•	ledger.transaction.posted

	•	ledger.tax.collected

	•	ledger.payroll.paid

	•	ledger.mint.executed (rare, audited)

	•	Consumes:

	•	contract.contract.events (payout triggers)

	•	char.character.events (work completed triggers)

	•	gov.policy.events (tax rates, policy updates)

	•	cb.policy.events (mint authorization)

Owned DB tables

	•	account

	•	ledger_transaction

	•	ledger_entry (debit/credit lines)

	•	tax_rule

	•	payroll_batch

	•	mint_audit

	•	processed_command

Notes

	•	Enforce invariants at DB + code:

	•	entries must balance

	•	idempotent postings

	•	immutable ledger rows (no updates, only reversals)

⸻

3.3 Central Bank Policy Service (Rust)

Purpose

Policy authority that controls:

	•	mint authorization envelopes

	•	interest baseline (if used)

	•	emergency liquidity windows

gRPC

	•	GetPolicySnapshot()

	•	AuthorizeMint(amount, purpose, window, command_id)

	•	UpdatePolicy(params, command_id)

Pulsar

	•	Produces: persistent://game/cb/cb.policy.events (key=policy_id)

	•	cb.policy.updated

	•	cb.mint.authorized

	•	Consumes: ledger.ledger.events (for monitoring, optional)

Owned DB tables

	•	cb_policy

	•	cb_mint_authorization

	•	cb_audit_log

	•	processed_command

Notes

	•	Keep this extremely strict and transparent.

⸻

3.4 WorldGen Service (Rust)

Purpose

Deterministic procedural generation engine producing district specs:

	•	parcels, zoning

	•	travel graph

	•	POIs

	•	resource nodes/reserves distribution (within rules)

DeepSeek is used only as a planner to suggest refinement; final output must remain deterministic and versioned.

gRPC

	•	GenerateDistrict(seed, ruleset_version, district_id, params, command_id)

	•	ExpandFrontier(seed, ruleset_version, frontier_params, command_id)

	•	GetGenerationArtifact(district_id, ruleset_version)

Pulsar

	•	Produces: persistent://game/worldgen/worldgen.events (key=district_id)

	•	worldgen.district.generated

	•	worldgen.district.expanded

	•	Consumes:

	•	world.world.events (current world boundaries, optional)

	•	npc.mind.events (optional “narrative suggestions” only)

Owned DB tables

	•	worldgen_job

	•	worldgen_artifact (serialized district spec)

	•	worldgen_ruleset

	•	processed_command

Notes

	•	Always store seed + ruleset_version + artifact_hash.

	•	Any LLM-assisted change must bump ruleset_version or “decorator version.”

⸻

4) NPC System

4.1 NPC Schedule Service (Go)

Purpose

Always-on deterministic NPC behavior:

	•	daily/weekly/monthly templates

	•	generates and dispatches NPC actions into Character/Logistics/Production

	•	ensures economy continues without players

gRPC

	•	CreateNPC(profile, home, role, command_id)

	•	AssignSchedule(npc_id, schedule_template_id, command_id)

	•	GetSchedule(npc_id)

	•	TriggerScheduleWindow(npc_id, window) (internal)

	•	ListNPCs(filters)

Pulsar

	•	Produces: persistent://game/npc/npc.events (key=npc_id)

	•	npc.schedule.assigned

	•	npc.activity.dispatched

	•	npc.activity.completed (projection-friendly)

	•	Consumes:

	•	npcmind.npcmind.events (schedule patches, intent updates)

	•	world.world.events (topology changes)

	•	ledger.ledger.events (salary outcomes, optional)

	•	incident.events (if you add)

Owned DB tables

	•	npc

	•	npc_role

	•	npc_schedule_template

	•	npc_schedule_instance

	•	npc_intent (current goals)

	•	scheduled_action

	•	processed_command

Notes

	•	This service never calls LLM.

	•	It applies “mind patches” only if constraints pass.

⸻

4.2 NPC Mind Service (Python)

Purpose

LLM planner that makes NPCs feel alive by periodically producing:

	•	profile updates (risk tolerance, spending style)

	•	schedule patches (shift change, route preference)

	•	intents (save money, avoid district, seek job)

It consumes event history, summarizes, calls DeepSeek, outputs structured JSON patches.

gRPC

	•	RequestReplan(npc_id, horizon, reason, command_id) (manual/triggered)

	•	GetMindProfile(npc_id)

	•	GetRecentMemory(npc_id)

Pulsar

	•	Consumes:

	•	npc.npc.events (activity summaries)

	•	ledger.ledger.events (npc financial outcomes)

	•	contract.contract.events (employment, breaches)

	•	log.logistics.events (accidents, delays)

	•	feed.public.feed (public news signals, optional)

	•	Produces: persistent://game/npcmind/npcmind.events (key=npc_id)

	•	npcmind.profile.updated

	•	npcmind.schedule.patch

	•	npcmind.intent.updated

	•	npcmind.cost_budget.used (optional for ops)

Owned DB tables

	•	npc_mind_profile

	•	npc_memory_slice (structured summaries)

	•	npc_llm_run (cost + prompts + outputs + hashes)

	•	processed_command

Notes

	•	LLM is planner-only: outputs proposals; deterministic services validate/apply.

	•	Always require structured JSON output, no free-form.

⸻

5) Projection & Analytics (Go)

5.1 Projection Service (Go)

Purpose

Build read models and official records:

	•	“official incident stats” (if you add incidents)

	•	market tickers (if you add market)

	•	district aggregates (crime, employment, production volume)

	•	leaderboards (optional)

gRPC

	•	GetDistrictStats(district_id, window)

	•	GetEconomicIndicators(window)

	•	GetChokepointSignals(window) (topology-based metrics)

Pulsar

	•	Consumes: all domain topics (curated)

	•	Produces: persistent://game/projection/projection.events (optional)

Owned DB tables

	•	district_stats_daily

	•	economic_indicator_daily

	•	aggregate_counter

	•	projection_checkpoint

⸻

5.2 Graph Projection Service (Go) — later

Purpose

Consumes events and maintains a graph-like projection for:

	•	advanced routing queries

	•	relationship/network queries

	•	hotspot analysis

gRPC

	•	FindRoute(origin, destination, constraints)

	•	FindAssociates(entity_id, depth, window)

	•	Hotspots(district_id, window)

Pulsar

	•	Consumes: world + logistics + npc + incident + contract (selected)

	•	Produces: none (query-only)

Owned DB tables

	•	graph_node

	•	graph_edge

	•	graph_edge_fact (time-windowed interactions)

	•	projection_checkpoint

⸻

MVP Minimal Set (what you can build first)

If you want the terminal loop you demoed (go list → job → paper sign → work → pay), the minimal services are:

	1\. Command Gateway (Go)

	2\. Identity (Go) (not detailed above; can be folded into gateway early)

	3\. Character (Go)

	4\. World (Go)

	5\. Contracts (Go)

	6\. Ledger (Rust)

	7\. Event Feed (Go)

Then add:

	•	NPC Schedule (Go) → NPC baseline world

	•	NPC Mind (Python) → “alive” planning

	•	Logistics/Inventory/Production (Go/Rust) → supply chain depth

	•	WorldGen (Rust) → expansion

⸻

If you want, I’ll generate next:

	1\. Exact gRPC proto skeletons (packages, messages, method signatures) for all MVP services, and

	2\. A Pulsar topic + partition plan (which topics should be partitioned, how many, and keying rules).
