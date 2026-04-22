# <Hub Name> Activity Log / <허브 한글명> 활동 로그

> Append-only log. Format: `## [YYYY-MM-DD] <action> | <subject>` for grep-parsing.
> 추가 전용 로그. 형식: `## [YYYY-MM-DD] <행동> | <대상>` (grep 파싱용).
>
> Quick scan / 빠른 확인:
> ```bash
> grep "^## \[" wiki/log.md | tail -10
> ```

---

## [<YYYY-MM-DD>] init | hub bootstrapped as study type

- Detected `<N>` existing user-authored .md files (preserved untouched).
  사용자 작성 .md 파일 `<N>`개 감지 (그대로 유지).
- Added `wiki/` for LLM-generated synthesis.
  LLM 종합용 `wiki/` 추가.
- Added hub `CLAUDE.md` defining workflows.
  허브 `CLAUDE.md` 추가 (워크플로우 정의).
