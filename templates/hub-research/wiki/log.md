# <Hub Name> Activity Log / <허브 이름> 활동 로그

> Append-only chronological log. Each entry starts with `## [YYYY-MM-DD] <action> | <subject>` so it stays grep-able.
> 추가 전용 시간순 로그. 각 항목은 `## [YYYY-MM-DD] <행동> | <대상>`으로 시작해 grep 파싱 가능하게 유지.
>
> Quick command / 빠른 명령:
> ```bash
> grep "^## \[" wiki/log.md | tail -10
> ```

---

## [<YYYY-MM-DD>] init | hub created

- Bootstrapped hub from `templates/_init/`.
  `templates/_init/`에서 허브 부트스트랩.
- Folder: `<hub-name>/{raw,wiki/{sources,entities,concepts},assets}`.
- Schema inherited from root `CLAUDE.md`. Hub-specific overrides: <none | see hub CLAUDE.md>.
  스키마는 루트 `CLAUDE.md`에서 상속. 허브별 오버라이드: <없음 | hub CLAUDE.md 참조>.
