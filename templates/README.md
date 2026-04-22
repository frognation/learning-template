# Templates / 템플릿 가이드

> Two layers of templates: **page-level** (used inside any hub's `wiki/`) and **hub-level** (used to bootstrap a new hub).
> 두 층의 템플릿: **페이지 단위** (어떤 허브든 `wiki/` 내부에서 사용) + **허브 단위** (새 허브 부트스트랩).

---

## File map / 파일 지도

### Page-level / 페이지 단위 (used inside any hub's `wiki/`)

| Template | Use for / 용도 | Goes under / 저장 위치 |
|---|---|---|
| [`source.md`](source.md) | One page per ingested external source / 흡수한 외부 자료 1건당 1페이지 | `<hub>/wiki/sources/` (research) |
| [`entity.md`](entity.md) | A person, org, product, place / 인물·조직·제품·장소 | `<hub>/wiki/entities/` |
| [`concept.md`](concept.md) | An idea, theory, framework, or pattern / 아이디어·이론·프레임워크·패턴 | `<hub>/wiki/concepts/` (both types) |

### Hub-level / 허브 단위 (used to bootstrap a new hub)

| Template | Use for / 용도 | See / 참고 |
|---|---|---|
| [`hub-study/`](hub-study/) | Bootstrap a study-type hub (user-authored notes + LLM synthesis) | [`hub-study/README.md`](hub-study/README.md) |
| [`hub-research/`](hub-research/) | Bootstrap a research-type hub (raw sources + LLM-built wiki) | [`hub-research/README.md`](hub-research/README.md) |

> For **project hubs** (time-bounded client work, deliverables, etc.), use the companion [project-template](https://github.com/frognation/project-template) repo.
> **프로젝트 허브**(기간 한정 클라이언트 작업·산출물 등)는 [project-template](https://github.com/frognation/project-template) 짝 리포 사용.

> Bootstrapping happens automatically during the [`ONBOARDING.md`](../ONBOARDING.md) flow.
> 부트스트랩은 [`ONBOARDING.md`](../ONBOARDING.md) 흐름에서 자동 실행됨.

---

## Page-creation criteria / 페이지 생성 기준

When ingesting a source (research hub) or summarizing notes (study hub), the LLM should ask itself:

자료 흡수(리서치 허브) 또는 노트 요약(스터디 허브) 시 LLM이 스스로 점검할 질문:

| Page type | Create when / 생성 시점 |
|---|---|
| **source** | Always for each file in `raw/`. Research hubs only. |
| **entity** | Named person/org/product/place appears in 2+ sources, OR user explicitly cares. |
| **concept** | Idea/theory/framework recurs across sources, OR a single source dedicates significant space, OR user-authored notes converge on a topic worth synthesizing. |

Always: update the hub's `wiki/index.md` and append to `wiki/log.md`.

항상: 허브의 `wiki/index.md` 갱신 + `wiki/log.md`에 항목 추가.

---

## Naming convention / 명명 규칙

- File names: **English, kebab-case**. e.g. `vannevar-bush.md`, `memex.md`, `transformer-architecture.md`.
  파일명: **영문 kebab-case**.
- Page title (in frontmatter): bilingual `English / 한글`.
  페이지 제목(프론트매터): 영한 병기.
- Aliases: include all common variants (English, Korean, abbreviations).
  별칭: 흔히 쓰이는 모든 표기 포함.

---

## Bilingual style / 병기 스타일

Default: **alternating paragraphs** — write a thought in English, then immediately the Korean equivalent below it.

기본: **단락 교대** — 한 생각을 영문으로 쓰고 바로 아래 한글로 옮긴다.

To change style globally, edit root [`CLAUDE.md`](../CLAUDE.md) §3.1 — the LLM will follow the new style.

전역 스타일 변경: 루트 [`CLAUDE.md`](../CLAUDE.md) §3.1 수정 → LLM이 새 스타일 따름.

---

## Modifying templates / 템플릿 수정

- **Add a section** to a page template: just edit the `.md` file. LLM picks up changes on next ingest.
  페이지 템플릿에 섹션 추가: `.md` 파일만 수정.
- **Add a frontmatter field**: edit the template AND root `CLAUDE.md` §3.2.
  프론트매터 필드 추가: 템플릿 + 루트 `CLAUDE.md` §3.2 양쪽 수정.
- **Add a brand-new page type**: create a new template here, document in templates/README.md, reference from a hub's `CLAUDE.md`.
  새 페이지 타입: 여기에 새 템플릿 생성 + 본 README 갱신 + 허브 `CLAUDE.md`에서 참조.
- **Add a brand-new hub type**: create `hub-<type>/` subfolder mirroring `hub-study/` or `hub-research/` structure, then add a row to root `CLAUDE.md` §2.
  새 허브 타입: `hub-<type>/` 서브폴더 생성 (`hub-study/` 또는 `hub-research/` 구조 참고) + 루트 `CLAUDE.md` §2에 행 추가.

---

## Related docs / 관련 문서

- [`../README.md`](../README.md) — vault intro
- [`../CLAUDE.md`](../CLAUDE.md) — root schema (rules common to all hubs)
- [`../ONBOARDING.md`](../ONBOARDING.md) — first-run integration guide
- [`../FOLDER-STRUCTURE.md`](../FOLDER-STRUCTURE.md) — multi-hub design rationale
