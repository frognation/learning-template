# CLAUDE.md — Root Schema (Multi-Hub Vault) / 루트 스키마 (멀티 허브 볼트)

> This vault is a **multi-hub PKM** built on the [LLM Wiki](llm-wiki.md) pattern. This file defines rules common to ALL hubs. Each hub may add its own `<hub>/CLAUDE.md` to override or extend.
> 이 볼트는 [LLM Wiki](llm-wiki.md) 패턴 기반의 **멀티 허브 PKM**입니다. 이 파일은 모든 허브에 공통인 규칙을 정의합니다. 각 허브는 자체 `<hub>/CLAUDE.md`로 오버라이드·확장할 수 있습니다.

---

## 0. First-time / 첫 실행

If you (Claude) detect non-template folders at the vault root that lack a hub `CLAUDE.md`, this is likely a fresh-clone with un-integrated user folders.

볼트 루트에 hub `CLAUDE.md`가 없는 비템플릿 폴더가 있으면, 사용자 폴더가 아직 통합되지 않은 상태입니다.

→ **Read [`ONBOARDING.md`](ONBOARDING.md) and offer to run integration.**
→ [`ONBOARDING.md`](ONBOARDING.md) 읽고 통합 실행 제안.

---

## 1. Vault layout / 볼트 구조

```
<vault-root>/
├── CLAUDE.md             # This file / 이 파일 — common rules
├── README.md             # Human intro / 사람용 소개
├── ONBOARDING.md         # First-run integration guide / 첫 통합 가이드
├── FOLDER-STRUCTURE.md   # Why multi-hub / 멀티 허브 설계 근거
├── llm-wiki.md           # Pattern doc (bilingual) / 패턴 문서 (영한 병기)
├── templates/            # Shared templates / 공용 템플릿
│   ├── source.md, entity.md, concept.md   # page-level / 페이지 단위
│   ├── hub-study/        # study hub bootstrap / 스터디 허브 부트스트랩
│   └── hub-research/     # research hub bootstrap / 리서치 허브 부트스트랩
├── _shared/              # cross-hub shared pages (optional) / 허브 간 공유
│
└── <hub-N>/              # one folder per knowledge hub / 지식 허브당 1개 폴더
    ├── CLAUDE.md         # hub-specific overrides / 허브별 오버라이드
    └── ... (study or research layout)
```

**Reserved names / 예약된 이름** (treated as non-hubs):
`templates`, `_shared`, anything starting with `_` or `.`.

`templates`, `_shared`, `_`나 `.`로 시작하는 모든 이름은 허브 아님.

---

## 2. Hub types / 허브 타입

Three knowledge-oriented types:

지식 지향 3가지:

| Type | Detection / 감지 | Bootstrap from / 부트스트랩 |
|---|---|---|
| `study` | mostly user-authored .md, no/few external sources | `templates/hub-study/` |
| `research` | mostly external sources (PDF/HTML/clips), few/no user notes | `templates/hub-research/` |
| `mixed` | both — user notes alongside external sources | use both templates as needed |

**Naming convention:** Folder names may use a type marker as **prefix** (`study-python/`, `research-llm/`) OR **suffix** (`python-study/`, `llm-research/`). Pick one pattern per vault and stay consistent. Bare names (no marker) also work — Claude infers from contents.

**명명 규칙:** 폴더명은 타입 표시를 **접두**(`study-python/`) 또는 **접미**(`python-study/`)로. vault 내 일관성 유지. 표시 없어도 됨 (Claude가 내용으로 추론).

> **For time-bounded projects** (client work, deliverables, etc.) → use the companion repo [**project-template**](https://github.com/frognation/project-template), installed as a sibling folder (typically `MyVault/Projects/`). It covers: brief · timeline · decisions · contract · working files · deliverables · comms · status + embedded research wiki.
> **기간 한정 프로젝트**(클라이언트 작업·산출물) → 짝 리포 [**project-template**](https://github.com/frognation/project-template) 사용. 형제 폴더(보통 `MyVault/Projects/`)로 설치. 브리프·일정·결정·계약·작업 파일·산출물·커뮤니케이션·status + 내장 리서치 위키.

Type is recorded in the hub's `CLAUDE.md` frontmatter or first paragraph (e.g., `**Hub type:** study`).

타입은 hub `CLAUDE.md`의 frontmatter나 첫 단락에 명시 (예: `**Hub type:** study`).

See [`ONBOARDING.md`](ONBOARDING.md) §B.2 for the full classification decision tree.

전체 분류 결정 트리는 [`ONBOARDING.md`](ONBOARDING.md) §B.2 참고.

---

## 3. Common conventions / 공통 컨벤션

### 3.1 Bilingual format / 영한 병기

Every LLM-generated page is **bilingual**:

LLM이 생성하는 모든 페이지는 **영한 병기**:

- **Headings**: `## English / 한글` (slash-separated).
  **제목**: `## English / 한글` (슬래시 구분).
- **Body**: alternating paragraphs — English first, Korean immediately below.
  **본문**: 단락 교대 — 영문 먼저, 바로 아래 한글.
- **Lists**: each bullet has both, separated by ` / `, or two indented lines.
  **리스트**: 각 항목은 둘 다 (` / ` 구분 또는 두 줄 들여쓰기).
- **Tables**: add a `(KO)` column when meaningful.
  **표**: 의미 있을 때 `(KO)` 열 추가.

**Exception:** User-authored notes in study hubs stay in their original language (don't auto-translate).

**예외:** 스터디 허브의 사용자 작성 노트는 원래 언어 그대로 (자동 번역 금지).

**Single-file rule:** All LLM-generated docs are bilingual in ONE file. Never create `*.ko.md` / `*.en.md` pairs — put both languages in the same file using the alternating-paragraph style.

**단일 파일 규칙:** LLM이 생성하는 모든 문서는 한 파일 안에 영한 병기. `*.ko.md` / `*.en.md` 분리 금지. 한 파일에 단락 교대 스타일로 두 언어 모두 기록.

### 3.2 Frontmatter / 프론트매터

```yaml
---
title: <Title> / <한글 제목>
type: source | entity | concept | index | log | cheatsheet | exercise
hub_type: study | research                  # which hub this lives in / 속한 허브 타입
created: 2026-04-22
updated: 2026-04-22
sources: 0                                  # for research-hub pages / 리서치 허브 페이지용
derived_from: []                            # for study-hub pages / 스터디 허브 페이지용
tags: [tag-en, 태그-한]
aliases: [alias1, 다른이름]
---
```

### 3.3 Linking / 링크

- Within hub: `[[Page Name]]`.
  허브 내: `[[페이지 이름]]`.
- Cross-hub: `[[../<other-hub>/<page>]]` or rely on Obsidian's global wikilink resolution.
  허브 간: `[[../<다른허브>/<페이지>]]` 또는 Obsidian 전역 위키링크 해석에 위임.
- Citing raw sources: `[Title](../raw/file.pdf)`.
  원본 자료 인용: `[제목](../raw/file.pdf)`.

### 3.4 File naming / 파일명

- English, kebab-case. e.g. `vannevar-bush.md`, `transformer-architecture.md`.
  영문, kebab-case.
- Hub folders: descriptive name, optional `-study` / `-research` / `-mixed` suffix.
  허브 폴더: 설명적 이름, 접미사는 선택.

---

## 4. Workflows / 워크플로우

The exact workflow depends on hub type. See:

정확한 워크플로우는 허브 타입에 따라 다름:

- For **study hubs** → see `templates/hub-study/CLAUDE.md` workflows W1–W4.
- For **research hubs** → see `templates/hub-research/CLAUDE.md` (ingest / query / lint).

Common to both:

공통:

- **Always** scope work to the active hub. Don't cross hubs without explicit user request.
  **항상** 활성 허브 범위로 작업. 명시적 요청 없이 허브를 넘나들지 않음.
- **Always** append a log entry to the active hub's `wiki/log.md`.
  **항상** 활성 허브의 `wiki/log.md`에 로그 기록.
- **Never** modify files under `templates/` or root `*.md` files (except logs).
  **절대** `templates/` 또는 루트 `*.md` 수정 금지 (로그 제외).

---

## 5. Language defaults / 기본 언어

- Conversation with user: **Korean**, unless user switches.
  사용자와 대화: **한국어** (사용자가 바꾸지 않는 한).
- LLM-generated wiki pages: **bilingual EN+KO**.
  LLM 생성 위키 페이지: **영한 병기**.
- User-authored notes (study hubs): **whatever the user used**.
  사용자 작성 노트 (스터디 허브): **사용자가 쓴 언어 그대로**.
- File names, code, tags: **English** (kebab-case).
  파일명·코드·태그: **영문** (kebab-case).

---

## 6. Modifying this schema / 스키마 수정

Edit this file directly. Common patterns:

- Add a new hub type → add row to §2 + create a new bootstrap template under `templates/hub-<type>/`.
- Change bilingual style → rewrite §3.1 + update all hub `CLAUDE.md`s.
- Add a global rule (e.g. "never use external APIs without confirmation") → add a new section here.

Hub-level overrides go in `<hub>/CLAUDE.md` and shadow this file's rules for that hub only.

허브 단위 오버라이드는 `<hub>/CLAUDE.md`에. 그 허브에만 적용되며 이 파일을 가린다.
