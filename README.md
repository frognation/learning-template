# Bilingual LLM Wiki Template — v.0.1 / 영한 병기 LLM 위키 템플릿 v.0.1

> **A multi-hub, bilingual personal knowledge vault** maintained collaboratively by you and an LLM agent.
> 사용자와 LLM 에이전트가 함께 유지하는 **멀티 허브 영한 병기 PKM 볼트**.
>
> Pattern: [llm-wiki.md](llm-wiki.md) (bilingual / 영한 병기).

---

## What this is / 이게 뭔가요

A **clonable template** for organizing many knowledge hubs (study + research) under one Obsidian vault, with an LLM agent that handles the bookkeeping (summaries, cross-links, indexing, logging).

여러 지식 허브(스터디 + 리서치)를 하나의 Obsidian 볼트에 정리하기 위한 **복제 가능한 템플릿**. LLM 에이전트가 부기(요약·상호링크·인덱싱·로깅)를 담당.

**Two hub types / 두 가지 허브 타입:**

| Type | Use for / 용도 |
|---|---|
| `study` | 본인이 직접 작성한 학습 노트 모음 (Python, 디자인 시스템 등). LLM은 종합·요약·연습문제 생성을 도움. |
| `research` | 외부 자료 더미 (PDF·논문·웹클립). LLM이 수집·통합해 위키화. |

---

## Quick start / 빠른 시작

### A. New user / 신규 사용자

1. **Clone or copy** this template to where you want your knowledge vault.
   이 템플릿을 지식 볼트로 쓸 위치에 **복제 또는 복사**.
   ```bash
   git clone <this-repo> my-pkm-vault
   cd my-pkm-vault
   ```
2. **Install [Obsidian](https://obsidian.md)**, open the folder as a vault.
   [Obsidian](https://obsidian.md) 설치 후 폴더를 볼트로 열기.
3. **Move your existing knowledge folders** (study notes, research piles) into this folder's root.
   기존 지식 폴더(학습 노트, 리서치 자료)를 이 폴더 루트로 옮기기.
4. **Start a Claude Code session** here and say: `"Read ONBOARDING.md and integrate my hubs."`
   Claude Code 세션을 여기서 시작하고: `"ONBOARDING.md 읽고 내 허브들 통합해 줘."`

That's it. Claude reads [`ONBOARDING.md`](ONBOARDING.md), classifies each folder (study vs research), proposes a structure, and applies it after your confirmation.

끝. Claude가 [`ONBOARDING.md`](ONBOARDING.md)를 읽고, 폴더를 분류하고, 구조를 제안한 뒤, 확인받고 적용합니다.

### B. Existing user / 기존 사용자

For day-to-day operations after onboarding:

통합 이후 일상 운영:

```text
"<hub-name>의 raw/에 있는 다음 자료 ingest해 줘"     # research hub
"<hub-name>의 OOP 노트들을 wiki/concepts/로 정리해 줘"  # study hub
"<hub-name>에서 빠진 토픽 분석해 줘"                  # study hub gap analysis
"전체 위키 lint해 줘"                                # any hub
```

---

## Setup — Obsidian + AI / 옵시디언 + AI 셋업

### Obsidian

1. Install [Obsidian](https://obsidian.md). Open this folder as a vault.
2. Recommended community plugins:

| Plugin | Why / 용도 |
|---|---|
| **Dataview** | Frontmatter 쿼리 → 동적 인덱스 |
| **Templater** | 변수(날짜·제목) 포함 템플릿 삽입 |
| **Obsidian Web Clipper** (browser ext) | 웹 기사 → 마크다운으로 `_inbox/` 또는 `<hub>/raw/`에 저장 |
| **Folder Notes** | 각 허브 폴더를 인덱스 페이지처럼 표시 |
| **Workspaces** (built-in) | 허브별 레이아웃 저장·전환 |
| **Marp** (optional) | 위키 → 슬라이드 |

3. Settings:
   - **Files & Links** → "Default location for new attachments" = `<active-folder>/raw/assets/` (or per-hub setting)
   - **Files & Links** → "Use [[Wikilinks]]" = ON
   - **Templates / Templater** → template folder = `templates/`
   - **Hotkeys** → bind "Download attachments for current file" to `Ctrl+Shift+D`

### Web Clipper — inbox pattern / 인박스 패턴 (권장)

To avoid typing a path every time you clip:

매 클립마다 경로 입력하지 않으려면:

**Option A (simplest) — single inbox:**
- In Web Clipper extension → New template → "Inbox"
- Note location: `_inbox` (or `Learning/_inbox` if nested in larger vault)
- File name: `{{date}}-{{title}}`
- Tell Claude later: `"_inbox에 쌓인 자료들 적절한 허브로 옮겨서 ingest해 줘"` — Claude classifies and files them.

**Option B — per-hub template (when hubs are stable):**
- Create one Web Clipper template per hub
- Each template's note location = `<hub>/raw/`
- At clip time, pick the right template from dropdown
- (Bonus) Use Web Clipper's URL pattern matching to auto-select template by domain

**Option C — hybrid:** Inbox by default + a couple of high-volume hubs with their own templates.

> The `_inbox/` folder is created on demand. It's listed in `.gitignore` patterns so it doesn't pollute the template repo if you're using one.
> `_inbox/` 폴더는 필요할 때 생성. 템플릿 리포 오염 방지를 위해 `.gitignore` 패턴에 들어 있음.

### AI agent / AI 에이전트

This template supports **Claude Code, Codex CLI, Cursor, Windsurf, and Gemini CLI** through a single `CLAUDE.md` + auto-generated mirrors.

이 템플릿은 **Claude Code, Codex CLI, Cursor, Windsurf, Gemini CLI**를 단일 `CLAUDE.md` + 자동 생성 미러로 지원.

- After editing any `CLAUDE.md`, run: `bash scripts/sync-agent-configs.sh` — regenerates `AGENTS.md` (Codex) and `GEMINI.md` (Gemini) everywhere.
  `CLAUDE.md` 수정 후: `bash scripts/sync-agent-configs.sh` 실행 → `AGENTS.md`·`GEMINI.md` 자동 생성.
- Full guide including **token-optimization tips**: [`MULTI-AGENT-GUIDE.md`](MULTI-AGENT-GUIDE.md).
  **토큰 최적화 팁** 포함 전체 가이드: [`MULTI-AGENT-GUIDE.md`](MULTI-AGENT-GUIDE.md).

---

## How Obsidian sees the multi-hub vault / 옵시디언이 멀티 허브를 보는 방식

**ONE vault, BOTH integrated and per-hub views:**

**볼트 1개로 통합 뷰와 허브별 뷰 둘 다 가능:**

| Want / 원하는 것 | How / 방법 |
|---|---|
| 전체 통합 그래프 | 기본 Graph view (자동) |
| 특정 허브만 그래프 | Graph → Filters → `path:<hub-name>` 입력 |
| 현재 노트 주변 | Local Graph (우측 사이드바, 자동) |
| 전역 위키링크 | `[[page]]` — 어디 있든 자동 해석 |
| 허브 간 명시적 링크 | `[[../<other-hub>/<page>]]` |
| 허브별 워크스페이스 저장 | Workspaces 플러그인 |
| 허브 폴더를 인덱스로 | Folder Notes 플러그인 |

**별도 vault가 필요한 경우만 분리** — 민감정보 절대격리, 다른 협업자, 다른 도구 사용 시.

Open separate vaults only when you need: hard privacy isolation, different collaborators per hub, or different tools.

---

## Folder structure overview / 폴더 구조 개요

```
<vault-root>/
├── README.md            ← this file
├── CLAUDE.md            ← root schema (common rules)
├── ONBOARDING.md        ← first-run integration guide
├── FOLDER-STRUCTURE.md  ← multi-hub design rationale
├── llm-wiki.md          ← pattern doc (bilingual)
│
├── templates/           ← shared, don't put data here
│   ├── source.md, entity.md, concept.md
│   ├── hub-study/       ← scaffold for study hubs
│   └── hub-research/    ← scaffold for research hubs
├── _shared/             ← cross-hub shared pages (optional)
│
├── python-fundamentals/ ← study hub example
│   ├── CLAUDE.md
│   ├── (your .md notes)
│   └── wiki/            ← LLM synthesis
│
└── llm-research/        ← research hub example
    ├── CLAUDE.md
    ├── raw/             ← immutable sources
    └── wiki/            ← LLM-maintained pages
```

Full design rationale: [FOLDER-STRUCTURE.md](FOLDER-STRUCTURE.md).

전체 설계 근거: [FOLDER-STRUCTURE.md](FOLDER-STRUCTURE.md).

---

## Files map / 파일 지도

### Core docs / 핵심 문서

- [`llm-wiki.md`](llm-wiki.md) — pattern doc (bilingual / 영한 병기)
- [`CLAUDE.md`](CLAUDE.md) — root schema for the LLM
- [`ONBOARDING.md`](ONBOARDING.md) — **first-run integration guide ⭐**
- [`FOLDER-STRUCTURE.md`](FOLDER-STRUCTURE.md) — multi-hub design
- [`TEMPLATE-SYNC.md`](TEMPLATE-SYNC.md) — **template ↔ personal vault sync workflow ⭐**
- [`MULTI-AGENT-GUIDE.md`](MULTI-AGENT-GUIDE.md) — **multi-agent usage + token optimization ⭐**

### Templates / 템플릿

- [`templates/README.md`](templates/README.md) — template usage guide
- [`templates/source.md`](templates/source.md), [`entity.md`](templates/entity.md), [`concept.md`](templates/concept.md) — page-level
- [`templates/hub-study/`](templates/hub-study/) — bootstrap for study hubs
- [`templates/hub-research/`](templates/hub-research/) — bootstrap for research hubs

---

## Versioning — Template / Personal Separation / 버전관리 — 템플릿·개인 분리

This is **v.1.0** — the integrated template (pure methodology + page templates + examples). It's designed to be **cloned** for actual use, with improvements **back-ported** to the template over time.

이것은 **v.1.0** — 통합 템플릿 (순수 방법론 + 페이지 템플릿 + 예시). 실사용을 위해 **clone**하고, 개선사항은 시간이 지나며 템플릿에 **back-port** 하도록 설계됨.

### Why separate template from data / 왜 템플릿과 데이터를 분리하나

The core insight: **methodology and data have different lifecycles.**

핵심 통찰: **방법론과 데이터는 다른 생애주기를 가진다.**

| Aspect | Methodology / 방법론 | Data / 데이터 |
|---|---|---|
| What it is / 무엇 | CLAUDE.md, templates, ONBOARDING.md, schemas | Your hubs, raw sources, wiki pages |
| Change rate / 변화 속도 | Slow (weeks–months) | Fast (daily) |
| Who can use / 누가 쓰나 | Anyone (generic) | Only you (personal) |
| Should be public? / 공개? | Yes (helps others) | No (private) |
| Version control unit / 버전 단위 | Semantic (v1.0 → v1.1) | Continuous accumulation |

If you mix the two:

둘을 섞으면:

- ❌ Public sharing leaks personal data / 공개 시 개인 데이터 노출
- ❌ New project = duplicate everything / 새 프로젝트마다 모든 게 복제됨
- ❌ Methodology improvements buried in data noise / 방법론 개선이 데이터 변경에 묻힘
- ❌ Hard for others to fork your methodology / 다른 사람이 방법론만 가져가기 어려움

If you separate:

분리하면:

- ✅ Template is publishable as a clean OSS repo / 템플릿은 깨끗한 OSS 리포로 공개 가능
- ✅ New vault = `git clone <template>` (one line) / 새 vault는 `git clone` 한 줄
- ✅ Methodology evolution has clean commit history / 방법론 진화의 commit 히스토리가 또렷함
- ✅ Anyone can fork your template, you can pull theirs back / 누구나 본인 템플릿 fork 가능, 본인은 그들 것을 백포트 가능

### The architecture / 구조

```
   ┌─────────────────────────────┐         ┌─────────────────────────────┐
   │  TEMPLATE REPO (GitHub)      │         │  PERSONAL VAULT (Dropbox)    │
   │  pkm-test (this folder)     │         │  Learning/                  │
   │                              │         │                              │
   │  ✓ CLAUDE.md                 │         │  ✓ CLAUDE.md  (copied)       │
   │  ✓ templates/                │         │  ✓ templates/  (copied)      │
   │  ✓ ONBOARDING.md             │         │  ✓ ONBOARDING.md  (copied)   │
   │                              │         │                              │
   │  ✗ NO personal data          │         │  ✓ Real learning + research  │
   │  ✓ Anyone can clone          │         │  ─ python-study/             │
   │                              │         │  ─ llm-research/             │
   │                              │         │  ─ ...                       │
   └─────────────────────────────┘         └─────────────────────────────┘
              ▲                                          │
              │                                          │
              │   ① clone once at start                  │
              ├──────────────────────────────────────────┤
              │                                          │
              │   ② daily use (you accumulate hubs       │
              │      in personal vault)                  ▼
              │                              (Dropbox auto-syncs across devices)
              │                                          │
              │   ③ workflow improvement discovered      │
              │      (e.g. "ingest needs step X")        │
              │                                          ▼
              │                              (test it in personal vault)
              │                                          │
              │   ④ once validated, abstract & back-port │
              ◄──────────────────────────────────────────┤
              │                                          │
              │   ⑤ tag new version (v1.1)               │
              │      push to GitHub                      │
              │                                          │
              ▼                                          ▼
        Future you (new vault) starts from v1.1
        Other users benefit from your improvement
```

### Step-by-step workflow / 단계별 워크플로우

#### One-time: initial setup / 1회: 초기 셋업

```bash
# 1. Clone template into your knowledge location
git clone https://github.com/<your-id>/pkm-test.git ~/Dropbox/Obsidian/Learning
cd ~/Dropbox/Obsidian/Learning

# 2. Remove .git inside Dropbox (avoid sync conflicts)
rm -rf .git

# 3. Move your existing knowledge folders into this directory
#    (See ONBOARDING.md Phase A for details)

# 4. Open in Obsidian, start using
```

#### Daily: use the personal vault / 일상: personal vault에서 사용

- Add hubs, ingest sources, query, lint
- Dropbox auto-syncs across your devices
- **Don't commit to git inside Dropbox** — Dropbox handles versioning
- Don't worry about template updates during daily use

추가·흡수·질의·점검을 일상적으로 수행. Dropbox가 디바이스 간 자동 동기화. **Dropbox 안에서는 git commit하지 말 것** — Dropbox가 버전관리.

#### Occasionally: back-port an improvement / 가끔: 개선사항 백포트

When you discover a useful workflow/template change in personal use:

개인 사용 중 유용한 워크플로우·템플릿 변경을 발견하면:

```bash
# 1. Apply & test the change in your personal vault first
cd ~/Dropbox/Obsidian/Learning
# (edit templates/entity.md to add a new field, for example)
# (use it for a few days, validate it's actually useful)

# 2. Mirror the change to the template repo
cd ~/Documents/GitHub/PKM/pkm-test
# (apply the SAME change — abstract version, no personal data)

# 3. Commit, tag, push
git add templates/entity.md
git commit -m "feat(entity): add Pronunciation field for language-learning hubs"
git tag v1.1
git push origin main --tags

# 4. (Optional) Create a GitHub release for v1.1
gh release create v1.1 --notes "Added Pronunciation field to entity template"
```

### 5 critical rules / 핵심 규칙 5가지

1. **No personal data in template** — `.gitignore` blocks common patterns; review before pushing.
   **템플릿에 개인 데이터 X** — `.gitignore`가 일반 패턴 차단. push 전 확인.
2. **No git inside personal vault** — Dropbox + Obsidian handles it. `.git` in Dropbox = sync conflicts.
   **personal vault에 git X** — Dropbox + Obsidian만으로 충분. Dropbox 안의 `.git`은 sync 충돌 유발.
3. **Test improvements in personal first** — only back-port what's been validated for several days.
   **개선은 personal에서 먼저 테스트** — 며칠 검증된 것만 백포트.
4. **Back-port = abstract** — strip your specific examples, generalize the pattern.
   **백포트 = 추상화** — 구체적 예시 제거, 패턴만 일반화.
5. **Tag versions semantically** — v1.0 (initial), v1.1 (small feature), v2.0 (breaking change).
   **버전은 의미 있게** — v1.0(최초), v1.1(소기능), v2.0(파괴적 변경).

### Real-world analogies / 비유

- **Cookbook template** vs **your filled cookbook**: publish the empty form, keep the filled recipes private.
  **빈 요리책 템플릿** vs **본인의 채워진 요리책**: 양식은 공개, 레시피는 본인 것.
- **`create-react-app`** vs **your React app**: starter kit is shared, the app you built is yours.
  스타터 키트는 공유, 만든 앱은 본인 것.
- **Notion template gallery** vs **your Notion workspace**: same pattern in product form.
  Notion 템플릿 vs 본인의 Notion: 동일 패턴.

Once this separation becomes habit, your PKM methodology improves continuously and those improvements compound — both for you (every new vault starts from the latest version) and for anyone who finds your template useful.

이 분리가 습관이 되면, 본인의 PKM 방법론이 꾸준히 개선되고 그 개선이 누적됩니다 — 본인(새 vault 만들 때마다 최신 버전부터)과 본인 템플릿을 유용하다고 느낀 누구에게든.

---

## License / 라이선스

MIT (suggested — adjust as needed).

MIT 권장 — 필요에 따라 조정.
