<!-- AUTO-GENERATED from CLAUDE.md by scripts/sync-agent-configs.sh — do not edit / CLAUDE.md에서 자동 생성. 직접 수정 금지 -->
# <Hub Name> — Hub-Specific Schema / 허브별 스키마

> Optional. Use this only when this hub needs rules that **differ from** the root `PKM/CLAUDE.md`.
> 선택 사항. 이 허브가 루트 `PKM/CLAUDE.md`와 **다른** 규칙이 필요할 때만 사용.
>
> **Inheritance / 상속:** Claude Code reads root `CLAUDE.md` first, then this file. This file overrides or extends the root.
> Claude Code는 루트 `CLAUDE.md`를 먼저 읽고, 그 다음 이 파일을 읽습니다. 이 파일이 루트를 오버라이드하거나 확장합니다.

---

## Hub identity / 허브 정체

- **Name / 이름**: <Hub Name> / <허브 한글명>
- **Domain / 도메인**: <e.g. LLM research, Tolkien books, personal health>
- **Purpose / 목적**: <one sentence>
  <한 문장>
- **Sourcing strategy / 자료 수집 전략**: <how new sources arrive — web clips, PDFs, podcasts, …>
  <새 자료가 어떻게 들어오는지>

---

## Domain-specific page types / 도메인별 페이지 타입 (선택)

If this hub needs page types beyond `entities/`, `concepts/`, `sources/`, declare them here.

이 허브에 `entities/`, `concepts/`, `sources/` 외의 페이지 타입이 필요하면 여기에 선언.

Examples / 예시:
- `wiki/papers/` — academic paper-specific format / 논문 전용 포맷
- `wiki/sessions/` — therapy session notes / 상담 세션 노트
- `wiki/recipes/` — cooking recipes / 레시피
- `wiki/places/` — travel locations / 여행 장소

---

## Naming conventions specific to this hub / 이 허브의 명명 규칙

- <e.g. People pages use `lastname-firstname.md` / 인물 페이지는 `성-이름.md`>
- <e.g. Always include ISBN in book entity frontmatter / 책 엔티티에는 ISBN 필수>

---

## Tone & style overrides / 톤·스타일 오버라이드

- Default conversation language / 기본 대화 언어: <KO | EN | mixed>
- Wiki page formality / 위키 페이지 격식: <academic | casual | clinical>
- Notable conventions / 주목할 컨벤션: <e.g. always cite page numbers, no speculation, …>

---

## Workflows specific to this hub / 이 허브 전용 워크플로우

(Add only if the root workflow needs domain-specific changes.)

(루트 워크플로우에 도메인별 변경이 필요한 경우에만 추가.)
