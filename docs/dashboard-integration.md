# Dashboard Integration Architecture

## The Data Suture
The dashboard is a static ARENA.AI React prototype that has been surgically upgraded to function as a live command center.

### 1. The Node API Bridge (`api.cjs`)
- **Endpoint `/api/health`:** Executes `twgt-git-hitl/scripts/check-drift.sh`. Returns the cryptographic status.
- **Endpoint `/api/device`:** Executes `free -m`, `df -h`, `nproc`, `uname`, and `uptime`. Returns live hardware telemetry.
- **Endpoint `/api/repos`:** Executes `gh repo list lifestyle3nergy-web`. Returns GitHub repository metadata.

### 2. The React UI Patches
- **`App.tsx`:** Rebranded to `TWGT-`, linked the `liveHealth` state to `/api/health`.
- **`DeviceDash.tsx`:** Linked the `summary` array and `Local context` panel to `/api/device`.
- **`RepoPullOverview.tsx`:** Replaced the hardcoded array with a `useEffect` hook calling `/api/repos`.
