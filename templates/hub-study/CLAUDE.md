# <Hub Name> — Study Hub Schema / 스터디 허브 스키마

> **Hub type:** `study`. User-authored .md notes are authoritative. LLM helps maintain, summarize, generate exercises — but does not modify user notes without explicit request.
> **허브 타입:** `study`. 사용자가 직접 쓴 .md 노트가 권위. LLM은 유지·요약·연습문제 생성을 돕되, 사용자 노트는 명시적 요청 없이 수정하지 않는다.

---

## Hub identity / 허브 정체

- **Name / 이름**: <Hub Name> / <허브 한글명>
- **Domain / 도메인**: <e.g. Python programming, Design systems, React fundamentals>
- **Goal / 목표**: <one sentence — what mastery looks like for this hub>
  <한 문장 — 이 허브에서 "통달"이 어떤 모습인지>

---

## Folder layout / 폴더 구조

```
<hub>/
├── CLAUDE.md             # This file / 이 파일
├── (existing .md files)  # User-authored notes — DO NOT MODIFY without permission
│                          사용자 작성 노트 — 허락 없이 수정 금지
└── wiki/                 # LLM-generated synthesis layer / LLM 생성 종합 레이어
    ├── index.md          # Catalog of synthesis pages / 종합 페이지 카탈로그
    ├── log.md            # Activity log / 활동 로그
    ├── concepts/         # (optional) concept summaries derived from notes
    ├── cheatsheets/      # (optional) quick references
    └── exercises/        # (optional) practice questions, solutions
```

The `wiki/` subfolder is **LLM-owned**. Existing notes outside `wiki/` are **user-owned**.

`wiki/` 하위만 LLM 소유. `wiki/` 밖의 기존 노트는 사용자 소유.

---

## What the LLM does in a study hub / 스터디 허브에서 LLM의 역할

✅ **Allowed by default** / 기본 허용:
- Read all user notes when answering questions.
  질문에 답할 때 사용자 노트를 모두 읽기.
- Generate **synthesis pages** in `wiki/concepts/` summarizing notes across files.
  여러 파일에 걸친 내용을 요약한 **종합 페이지**를 `wiki/concepts/`에 생성.
- Generate **cheatsheets** in `wiki/cheatsheets/`.
- Generate **practice questions/exercises** in `wiki/exercises/`.
- Suggest improvements (typos, missing topics, contradictions) — **as suggestions only**.
  개선점 제안 (오타, 누락 토픽, 모순) — **제안만**.
- Update `wiki/index.md` and `wiki/log.md`.

🛑 **Requires explicit per-action confirmation** / 행동마다 명시적 확인 필요:
- Editing any user-authored .md file (the ones outside `wiki/`).
  사용자 작성 .md 파일(`wiki/` 밖) 편집.
- Renaming or moving user files.
  사용자 파일 이름 변경·이동.
- Deleting anything.
  삭제 전반.

---

## Bilingual format / 영한 병기 형식

Inherit root `CLAUDE.md` §2.1: alternating EN/KO paragraphs, slash-separated headings.

루트 `CLAUDE.md` §2.1 상속: 단락 영한 교대, 제목 슬래시 구분.

If existing notes are KO-only or EN-only, **do not auto-translate them**. Generate new synthesis pages in `wiki/` as bilingual; leave originals as-is.

기존 노트가 한글 전용 또는 영문 전용이면 **자동 번역하지 않음**. `wiki/`의 새 종합 페이지만 영한 병기로 작성, 원본은 그대로.

---

## Workflows / 워크플로우

### W1. Synthesize / 종합 생성

User: "<topic>에 대해 wiki/concepts/ 페이지로 정리해 줘"

1. Read all user notes mentioning the topic.
2. Draft a concept page using `templates/concept.md`.
3. Cite sources via `[[../<note-file>]]` wikilinks.
4. Save under `wiki/concepts/<topic>.md`.
5. Update `wiki/index.md` and append to `wiki/log.md`.

### W2. Quiz me / 퀴즈

User: "<topic> 퀴즈 만들어 줘" or "test me on <topic>"

1. Read relevant notes.
2. Generate 5–10 questions in `wiki/exercises/<topic>-quiz-<date>.md`.
3. Include answer key in collapsed section or separate file.

### W3. Gap analysis / 공백 분석

User: "내가 뭐 빠뜨렸는지 봐 줘" or "what am I missing?"

1. Survey existing notes.
2. Compare against domain canon (use general knowledge or web search).
3. Report missing topics, weak coverage, suggested next reading.
4. **Do NOT auto-fill the gaps**; just report.

### W4. Convert to research mode / 리서치 모드로 전환

If the user starts collecting external sources (PDFs, papers) for this hub:

사용자가 외부 자료(PDF, 논문)를 수집하기 시작하면:

1. Suggest creating `raw/` and switching this hub to `mixed` or `research` type.
2. Update this CLAUDE.md to reflect the new type.

---

## Frontmatter for wiki pages / wiki 페이지 프론트매터

```yaml
---
title: <Title> / <한글 제목>
type: concept | cheatsheet | exercise
hub_type: study
created: <YYYY-MM-DD>
updated: <YYYY-MM-DD>
derived_from: [<note-file-1>, <note-file-2>]   # which user notes this synthesis cites
tags: [tag-en, 태그-한]
---
```

---

## Hub-specific overrides / 허브별 오버라이드

(Add anything specific to this hub here. Examples:)

- Naming convention for notes: `<chapter-NN>-<topic>.md`
- Code blocks default to: `python` / `typescript` / `rust`
- Citation style for external references: APA / MLA / casual
