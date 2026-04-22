# <Project Name> — Project Hub Schema / 프로젝트 허브 스키마

> **Hub type:** `project`. A time-bounded deliverable with stakeholders, decisions, research, and status tracking.
> **허브 타입:** `project`. 이해관계자·결정·리서치·status 추적이 필요한 기간 한정 프로젝트.

---

## Project identity / 프로젝트 정체

- **Name / 이름**: <Project Name> / <프로젝트 한글명>
- **Client / 클라이언트**: <if applicable / 해당 시>
- **Status / 상태**: active | on-hold | completed | archived
- **Start date / 시작일**: <YYYY-MM-DD>
- **Target completion / 목표 완료일**: <YYYY-MM-DD>
- **Goal / 목표**: <one sentence>
  <한 문장>

Full brief → [`meta/brief.md`](meta/brief.md).

전체 브리프는 [`meta/brief.md`](meta/brief.md).

---

## Folder layout / 폴더 구조

```
<project>/
├── CLAUDE.md             # This file / 이 파일
├── meta/                 # Project-level metadata / 프로젝트 레벨 메타
│   ├── brief.md          # 1-page project brief
│   ├── timeline.md       # milestones
│   ├── stakeholders.md   # people involved
│   └── decisions.md      # ADR-style decision log
├── research/             # Embedded research hub / 내장 research hub
│   ├── raw/              # sources to ingest
│   └── wiki/             # LLM-built wiki (inherits hub-research rules)
├── deliverables/         # One file per deliverable / 산출물당 1파일
├── comms/                # Meeting notes, email digests / 미팅·이메일
└── status/               # Weekly status entries / 주간 status
```

---

## Workflows / 워크플로우

### W1. Brief kickoff / 브리프 착수

User: `"프로젝트 브리프 작성 도와줘"` or `"help me write the brief"`

1. Ask user for: goal, scope (in/out), stakeholders, timeline, constraints, success criteria.
   사용자에게 묻기: 목표, 범위(in/out), 이해관계자, 일정, 제약, 성공 기준.
2. Fill `meta/brief.md` using the template.
3. Create initial `meta/stakeholders.md` and `meta/timeline.md` entries.
4. Log: `## [YYYY-MM-DD] kickoff | brief drafted`.

### W2. Decision logging (ADR) / 결정 로그

Whenever a non-trivial choice is made (architectural, strategic, creative direction):

사소하지 않은 선택(구조·전략·크리에이티브 방향)이 내려질 때마다:

Append to `meta/decisions.md` using ADR template:

```markdown
## [YYYY-MM-DD] Decision: <short title>

### Status / 상태
proposed | accepted | superseded by [[<later-decision>]]

### Context / 맥락
What's the situation, what factors are at play.
어떤 상황이고 어떤 요소들이 작용하는지.

### Decision / 결정
What we decided.
무엇을 결정했는지.

### Consequences / 결과
- Tradeoffs accepted / 수용한 tradeoff
- Risks / 리스크
- Follow-ups / 후속 조치
```

Tag decisions that change course as such so `superseded by` chains remain clear.

방향을 바꾸는 결정은 `superseded by` 체인이 명확하게 유지되도록.

### W3. Research ingestion / 리서치 흡수

The `research/` subfolder **inherits all `hub-research/` workflows**. See [`../hub-research/CLAUDE.md`](../../hub-research/CLAUDE.md).

`research/` 서브폴더는 [`../hub-research/CLAUDE.md`](../../hub-research/CLAUDE.md)의 **모든 워크플로우를 상속**.

Key command: `"<project>/research/raw/<file> ingest해 줘"` → standard ingest flow into `research/wiki/`.

**Project-specific rule:** entities in project research (competitors, the client, key people) may also be referenced from `meta/stakeholders.md`. Keep them in one place (wiki/entities/) and link from stakeholders.md.

**프로젝트 고유 규칙:** 프로젝트 리서치의 엔티티(경쟁사·클라이언트·핵심 인물)는 `meta/stakeholders.md`에서도 참조될 수 있음. 한 곳(wiki/entities/)에 두고 stakeholders.md에서 링크.

### W4. Weekly status / 주간 status

User: `"이번 주 status 정리해 줘"` or auto-triggered by schedule.

1. Scan `meta/decisions.md` for entries in the past 7 days.
   최근 7일의 결정 스캔.
2. Scan `research/wiki/log.md` for ingests/queries.
3. Scan `deliverables/` for changes (git diff or mtime).
4. Draft `status/YYYY-MM-DD-weekly.md`:

```markdown
## [<date>] Week of <start-date> — status

### Done / 완료
- <item> — [[<link>]]

### In progress / 진행 중
- <item>

### Decisions this week / 이번 주 결정
- [[meta/decisions.md#<anchor>]] — <one-line>

### Blocked / Risks / 블로커·리스크
- <item>

### Next week / 다음 주
- <item>
```

### W5. Deliverable creation / 산출물 생성

For each deliverable:

각 산출물마다:

1. Create `deliverables/<deliverable-name>.md` with frontmatter:
   ```yaml
   ---
   title: <Name> / <한글명>
   type: deliverable
   status: draft | in-review | delivered
   owner: <person>
   due: <YYYY-MM-DD>
   linked_decisions: [<decision-anchor>]
   ---
   ```
2. Inside: description, requirements, draft content or link to external file (Figma, PDF).
3. Update on status changes.

### W6. Meeting notes / 미팅 노트

After a meeting, create `comms/YYYY-MM-DD-<topic>.md`:

```markdown
---
date: <YYYY-MM-DD>
attendees: [<names>]
type: meeting | email | call
tags: []
---

## Context / 맥락
<why this meeting>

## Discussed / 논의 사항
- <topic 1>
- <topic 2>

## Decisions / 결정
- [[../meta/decisions.md#<anchor>]]

## Action items / 후속 액션
- [ ] <action> — owner: <person>, due: <date>

## Raw notes / 원 노트
<verbatim if needed>
```

---

## Inheritance / 상속

- Root `CLAUDE.md` rules (bilingual, naming, linking) apply.
- The `research/` subfolder inherits `../hub-research/CLAUDE.md` workflows.
- Hub-specific overrides go below.

---

## Project-specific overrides / 프로젝트별 오버라이드

(Add anything specific to this project here.)

- <e.g. "Deliverables must match the Figma library at <url>">
- <e.g. "Client approval required for any decision in category X">
- <e.g. "Meeting notes stored in comms/ must also be emailed to <person>">

---

## Archive / 아카이브

When project reaches `completed` status:

프로젝트가 `completed` 상태에 도달하면:

1. Update `meta/brief.md` → Status: completed, add retrospective section.
2. Final status entry: `status/YYYY-MM-DD-final.md` with overall summary.
3. (Optional) Identify reusable research for promotion to `Learning/`.
4. User decides: keep in place / move to `_archive/` / export zip.

자동 아카이브하지 않음. 사용자가 명시적으로 이동.
