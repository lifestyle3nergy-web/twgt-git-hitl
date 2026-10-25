# twgt-git-hitl

**Role:** Human Review Surface (HITL) and Traffic-Light PR Gatekeeper.

## Authority Boundary
Human-facing only. Holds the traffic-light PR template, review labels, CODEOWNERS pattern, and the org-ruleset recipe. Contains no CI job that decides admission (COMMIT-RULES §8). Admission remains a human act.

## Local Execution
Run the drift check before creating any PR:
./scripts/check-drift.sh
