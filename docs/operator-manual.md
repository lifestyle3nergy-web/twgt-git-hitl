# TWGT- Dashboard: Operator's Manual
**Environment:** Local-First Android Node (Termux)
**Architecture:** React (Vite) <-> Node.js API <-> Termux Shell / GitHub CLI

## 1. System Overview
The TWGT- Dashboard runs locally on `localhost:5173`. It bridges the React frontend to your physical Android device and your GitHub repositories via a local Node.js API (`127.0.0.1:9999`).

## 2. Navigation
- **Overview:** Command center showing Governance Health (100/100).
- **Device NetworX:** Live hardware stats (RAM, Storage, Kernel, Uptime) using Termux Linux commands.
- **App dock:** Catalog of workspace tools (Read-only).
- **Repositories:** Fetches all 104 GitHub org repos using `gh` CLI.
- **Dataset memos:** Offline context windows.

## 3. Operations
### Preflight Check (Offline)
Run `./scripts/check-drift.sh` locally. Ensure the dashboard reads 100/100.
### Managing Servers
- Start API: `cd ~/orb-dashboard && nohup node api.cjs > api.log 2>&1 & disown`
- Start UI: `cd ~/orb-dashboard && nohup npm run dev > vite.log 2>&1 & disown`

## 4. Security Constraints
- No Self-Admission. The dashboard cannot merge PRs.
- Read-only. Hardware telemetry never leaves the device.
