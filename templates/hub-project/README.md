# Project Hub Template / 프로젝트 허브 템플릿

> Use this template for **time-bounded projects** where you need to track not only research knowledge but also decisions, deliverables, timeline, stakeholders, and status.
> **기간이 정해진 프로젝트**에 사용. 리서치 지식뿐 아니라 결정·산출물·일정·이해관계자·status까지 추적해야 할 때.

---

## When to use / 언제 쓰나

✅ Use `project` type when:
- A specific deliverable with a deadline (brand strategy, product launch, research report)
- Multiple stakeholders (client, team, vendors)
- Decisions need to be logged (why did we go with X over Y?)
- Mix of activities: research + design + communications + production

❌ Don't use `project` if:
- Open-ended personal study → use [`hub-study/`](../hub-study/)
- Pure knowledge accumulation, no deliverable → use [`hub-research/`](../hub-research/)
- Quick ad-hoc tasks → just a single .md file

## Scope (intentional limits) / 의도적 한계

This template covers what markdown + LLM handle well:

이 템플릿은 markdown + LLM로 잘 할 수 있는 것만 다룹니다:

✅ **Included / 포함:**
- Project brief (1-pager) / 브리프
- Timeline & milestones / 일정·마일스톤
- Stakeholder tracking / 이해관계자 추적
- ADR-style decision log / ADR 스타일 결정 로그
- Weekly status updates / 주간 status
- Deliverables index / 산출물 인덱스
- Meeting notes & comms archive / 미팅·커뮤니케이션 아카이브
- **Embedded research hub** using `hub-research/` pattern / 내장 research hub

❌ **NOT included** (use dedicated tools) / **미포함** (전용 도구 사용):
- Sprint / ticket tracking → Linear, Jira, Asana
- Time tracking → Toggl, Harvest
- Gantt charts / burndown → MS Project, ClickUp
- File versioning for binary assets → Figma, Git-LFS, cloud storage

---

## Bootstrap / 부트스트랩

```bash
# from vault root
PROJECT=hotta
mkdir -p Projects/$PROJECT
cp -r templates/hub-project/* Projects/$PROJECT/
# Edit Projects/$PROJECT/CLAUDE.md and meta/brief.md with real values
```

Or ask Claude: `"Bootstrap Projects/hotta as a project hub"`.

또는 Claude에게: `"Projects/hotta를 프로젝트 허브로 부트스트랩해 줘"`.

---

## Resulting layout / 결과 구조

```
Projects/hotta/
├── CLAUDE.md                ← hub schema (workflows, conventions)
├── meta/
│   ├── brief.md             ← 1-page project brief
│   ├── timeline.md          ← milestones & key dates
│   ├── stakeholders.md      ← people involved
│   └── decisions.md         ← ADR-style decision log
├── research/                ← embedded research hub (inherits hub-research/ rules)
│   ├── raw/                 ← sources to ingest
│   └── wiki/                ← LLM-built wiki
│       ├── index.md
│       ├── log.md
│       ├── sources/
│       ├── entities/        ← competitors, key people in the domain
│       └── concepts/        ← industry concepts
├── deliverables/            ← one file per deliverable
├── comms/                   ← meeting notes, email digests
└── status/                  ← weekly status entries
```

---

## Files in this template / 포함된 파일

- [`CLAUDE.md`](CLAUDE.md) — project hub schema (workflows)
- [`meta/brief.md`](meta/brief.md) — project brief template
- [`meta/timeline.md`](meta/timeline.md) — milestones template
- [`meta/stakeholders.md`](meta/stakeholders.md) — stakeholders template
- [`meta/decisions.md`](meta/decisions.md) — ADR decision log template
- `research/` — empty scaffold (uses hub-research rules, see [`../hub-research/README.md`](../hub-research/README.md))
- `deliverables/README.md`, `comms/README.md`, `status/README.md` — folder-level conventions

---

## Naming / 명명

- As **root-level hub**: `project-<name>/` (e.g. `project-hotta/`)
- As **nested under Projects/**: `Projects/<name>/` (e.g. `Projects/hotta/`) — recommended for many projects

루트 허브: `project-<name>/`. 다수 프로젝트가 있으면 `Projects/<name>/` 중첩 권장.

---

## Archiving a finished project / 완료된 프로젝트 아카이브

```bash
# Option A: move to archive folder
mv Projects/hotta Projects/_archive/2026-04-hotta

# Option B: zip externally
cd Projects && zip -r ~/archive/2026-04-hotta.zip hotta && rm -rf hotta

# Optional: extract reusable industry knowledge to Learning/
# Only promote concepts/entities you'll reuse in FUTURE projects.
```

Don't auto-promote everything — most project research is project-specific. Only promote what you're confident you'll reference again.

모든 걸 자동 승격하지 말 것 — 대부분의 프로젝트 리서치는 프로젝트 한정. 재사용 확신이 있는 것만 승격.
