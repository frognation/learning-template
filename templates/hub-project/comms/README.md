# Communications / 커뮤니케이션

> Meeting notes, email digests, call summaries. One file per event.
> 미팅 노트·이메일 요약·콜 요약. 이벤트당 1파일.

## File naming / 파일명

`YYYY-MM-DD-<topic-or-participants>.md`

Examples / 예시:
- `2026-04-22-kickoff.md`
- `2026-04-25-client-review.md`
- `2026-05-01-vendor-call-packaging.md`

## Frontmatter / 프론트매터

```yaml
---
date: <YYYY-MM-DD>
type: meeting | email | call | async
attendees: [<name1>, <name2>]
duration: <minutes or N/A>
tags: []
---
```

## Content template / 내용 템플릿

```markdown
## Context / 맥락

Why this meeting? What's the goal?

## Discussed / 논의

- <topic 1>
- <topic 2>

## Decisions / 결정

Link decisions made here to [[../meta/decisions.md]]:

- [[../meta/decisions.md#<anchor>]] — <one-line>

## Action items / 후속 액션

- [ ] <action> — owner: <person>, due: <date>
- [ ] <action> — owner: <person>, due: <date>

## Raw notes / 원 노트

Verbatim notes if useful for reference. Often skipped.
원 노트. 참고용. 생략 가능.
```

## Important / 중요

- Action items here should also be copied/referenced in appropriate deliverables or timeline.
  여기 액션 아이템은 관련 deliverable이나 timeline에서도 참조/복사.
- Decisions from meetings go to `meta/decisions.md` as ADR entries, not buried in meeting notes.
  미팅에서 나온 결정은 미팅 노트에 묻지 말고 `meta/decisions.md`에 ADR로.
