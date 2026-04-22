# Status Updates / Status 업데이트

> Weekly (or biweekly) status entries. LLM can auto-generate from recent activity.
> 주간(또는 격주) status 항목. LLM이 최근 활동 기반으로 자동 생성 가능.

## File naming / 파일명

`YYYY-MM-DD-weekly.md` — dated by the Monday (or week-start) of the reporting week.

## Content template / 내용 템플릿

```markdown
---
date: <YYYY-MM-DD>
period_start: <YYYY-MM-DD>
period_end: <YYYY-MM-DD>
type: status-weekly
author: <name or LLM>
---

## Week of <period_start> — <Project Name> status / <프로젝트명> 주간 status

### TL;DR / 한 줄 요약

<One sentence — are we on track, what's the biggest open item.>
<한 문장 — 일정 준수 중인지, 가장 큰 이슈가 무엇인지.>

### Done / 완료

- <item> — [[link]]
- <item>

### In progress / 진행 중

- <item> (<% done or phase>)

### Decisions this week / 이번 주 결정

- [[../meta/decisions.md#<anchor>]] — <one-line>

### Blocked / Risks / 블로커·리스크

- <item> — mitigation: <...>

### Next week / 다음 주

- <item>
- <item>

### Asks / 요청 사항

For client or stakeholders — what's needed to keep moving.

클라이언트·이해관계자에게 — 진행을 위해 필요한 것.

- <ask>
```

## LLM auto-generation / LLM 자동 생성

Ask Claude: `"이번 주 status 정리해 줘"` or `"draft this week's status"`.

Claude will:
1. Read `meta/decisions.md` for entries in past 7 days.
2. Read `research/wiki/log.md` for research activity.
3. Scan `deliverables/` for status changes.
4. Read most recent `comms/` entries.
5. Draft the status entry and ask for review before saving.

Claude가 할 일:
1. 최근 7일 `meta/decisions.md` 항목 읽기.
2. `research/wiki/log.md`에서 리서치 활동 확인.
3. `deliverables/` status 변경 스캔.
4. 최근 `comms/` 항목 읽기.
5. status 초안 작성, 검토 요청 후 저장.
