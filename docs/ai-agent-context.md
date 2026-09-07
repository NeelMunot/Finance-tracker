# AI Agent Context

## What this repository is
A personal finance and investment tracker.

## Source of truth
The source of truth is the repository code plus version-controlled documentation in `docs/`.

MCP tools are access mechanisms, not the authoritative memory store.

## Before changing code
Inspect:
1. Relevant feature implementation.
2. `docs/requirements.md`
3. `docs/architecture.md`
4. `docs/data-model.md`
5. `docs/development-state.md`
6. `docs/decisions.md`

Use current external documentation when implementing APIs that may have changed.

## After changing code
- Run relevant tests.
- Run formatting/static analysis.
- Update `docs/development-state.md` when project state changes.
- Update `docs/decisions.md` for architectural decisions.
- Update `docs/roadmap.md` when roadmap status changes.

## Context hierarchy

```text
Current source code
      >
Architecture / decisions
      >
Requirements
      >
Roadmap / development state
      >
AI conversation history
```

Conversation history must not override explicit repository requirements unless the user deliberately changes them.

## Conflict policy
When a new requirement conflicts with the architecture:
1. Identify the conflict.
2. Explain the technical consequence.
3. Propose the smallest safe architectural change.
4. Record the accepted decision in `docs/decisions.md`.

## AI safety
AI-generated values are suggestions until validated.

Never interpret successful JSON parsing as successful financial validation.

## Current bootstrap status
The repository is being prepared for implementation. The detailed engineering plan should be produced before large-scale coding begins.
