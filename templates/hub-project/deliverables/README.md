# Deliverables / 산출물

> One file per deliverable. Use frontmatter for status tracking.
> 산출물당 1파일. 상태 추적은 frontmatter로.

## Conventions / 컨벤션

- File name: `<kebab-case-name>.md` (e.g. `brand-strategy-v2.md`)
- Frontmatter required:

```yaml
---
title: <Name> / <한글명>
type: deliverable
status: draft | in-review | approved | delivered
owner: <person>
due: <YYYY-MM-DD>
linked_decisions: [<anchor-in-decisions.md>]
linked_research: [[../research/wiki/concepts/<concept>]]
external_artifact: <url or path to Figma/PDF/etc.>
---
```

## Content structure / 내용 구조

Each deliverable file should include:

각 산출물 파일 포함 사항:

1. **Description / 설명** — what this deliverable is
2. **Requirements / 요구사항** — what it must satisfy (link to brief and decisions)
3. **Acceptance criteria / 승인 기준** — how we'll know it's done
4. **Draft content / 초안 내용** OR **link to external artifact** (Figma, PDF, Slides)
5. **Review log / 리뷰 로그** — feedback received, revisions made
6. **Handoff notes / 인계 사항** (when delivered)

## Status flow / 상태 흐름

```
draft → in-review → approved → delivered
              ↑          │
              └──── (revisions) ────┘
```

## Dataview query / Dataview 쿼리

If you use Dataview, this snippet lists deliverables by status:

```dataview
TABLE status, owner, due FROM "deliverables"
WHERE type = "deliverable"
SORT status, due
```
