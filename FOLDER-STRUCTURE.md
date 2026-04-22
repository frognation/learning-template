# Folder Structure Guide / 폴더 구조 가이드

> 멀티 허브 PKM 볼트 설계 근거. 두 가지 핵심 결정에 답합니다:
> Multi-hub PKM vault design rationale. Answers two core decisions:
>
> 1. **Hierarchy:** flat hubs vs `Study/` + `Research/` split? → **flat**
> 2. **Obsidian:** one vault or many? → **one**

---

## TL;DR / 결론

```
<vault-root>/
├── README.md, CLAUDE.md, ONBOARDING.md, ...
├── templates/                       ← shared (don't put data)
├── _shared/                         ← cross-hub pages (optional)
│
├── python-fundamentals/             ← study hub
├── design-systems/                  ← study hub
├── llm-research/                    ← research hub
├── ai-ethics-research/              ← research hub
└── personal-health-mixed/           ← mixed hub (often split later)
```

- Hubs sit **flat** under the vault root. Type is declared **inside** each hub (via its `CLAUDE.md`), not by parent folder.
- Open the vault root in **one Obsidian instance**. You get integrated AND per-hub views.

허브는 볼트 루트 바로 아래 평평하게. 타입은 각 허브 안의 `CLAUDE.md`로 선언 (부모 폴더로 분류하지 않음). Obsidian은 루트 1개만 열면 통합 + 허브별 뷰 둘 다 됨.

---

## 1. Why flat (no `Study/` + `Research/` split) / 왜 flat인가

### Decision matrix / 결정 매트릭스

| Criterion / 기준 | `Learning/Study/X` + `Learning/Research/Y` | `Learning/X-study/` + `Learning/Y-research/` (recommended) |
|---|---|---|
| Folder depth / 깊이 | 3 levels (`Learning/Study/python/`) | 2 levels (`Learning/python-study/`) |
| Topic evolves study→research | Move folder across `Study/`↔`Research/` | Just rename suffix in place |
| Hub with both notes & sources | Conflict — which parent? | Use `mixed` type, no conflict |
| Cross-hub linking | `[[../../Research/y/page]]` | `[[../y-research/page]]` |
| Adding a 3rd type later | Need new top folder | Just new suffix |
| Obsidian path filter | `path:Study` filters by category | `path:-study` filters by suffix (works the same) |

**Key insight / 핵심 통찰:**
타입은 폴더 **이름**이나 **내부 메타데이터**로 표현하면 충분합니다. 폴더 **계층**으로 표현하면 카테고리 변경이 어려워집니다.

Type can be expressed via folder **name** or **internal metadata**. Encoding it in folder **hierarchy** makes recategorization painful.

### Type detection / 타입 감지

Claude detects hub type via (in order):

Claude는 다음 순서로 타입 감지:

1. Folder name suffix: `-study` / `-research` / `-mixed`
2. Hub's `CLAUDE.md` declared type
3. Folder contents:
   - `raw/` exists with content → research
   - .md count >> source count → study
   - Mixed signals → ask user

자세한 결정 트리는 [`ONBOARDING.md`](ONBOARDING.md) §B.2 참고.

### Naming convention / 명명 규칙

Two patterns work — pick one and stay consistent within a vault:

두 가지 패턴 모두 가능. vault 안에서는 일관되게 한 가지 사용:

| Pattern / 패턴 | Example / 예시 | Best for / 적합 |
|---|---|---|
| **type-first** (prefix, **recommended for sorting**) | `study-python/`, `research-llm/`, `mixed-neuroscience/` | 파일 탐색기에서 타입별 그룹 정렬, `ls study-*` 와일드카드, 시각 스캔 |
| **topic-first** (suffix) | `python-study/`, `llm-research/`, `neuroscience-mixed/` | 토픽 우선 검색, 같은 토픽의 여러 타입을 인접 배치 |

Claude detects both patterns. Bare `<topic>/` (no prefix/suffix) also works — just lowers classification confidence.

Claude는 두 패턴 모두 인식. 접두/접미 없는 `<topic>/`도 가능 (분류 신뢰도만 떨어짐).

`mixed` is for hubs with both user-authored notes AND external source material. Use sparingly — often a transitional state that eventually splits.

`mixed`는 사용자 노트 + 외부 자료가 섞인 허브용. 보통 결국 분리되는 과도기 상태.

---

## 2. Why one Obsidian vault / 왜 vault 1개

### What you get with ONE vault / vault 1개로 얻는 것

| Goal / 원하는 것 | How / 방법 |
|---|---|
| **Integrated graph** of everything | Default Graph view (Cmd+G). All hubs in one canvas. |
| **Per-hub graph** | Graph → Filters → `path:python-study` (saveable) |
| **Local graph** of current note | Right sidebar — Local Graph (auto, depth-limited) |
| **Global wikilinks** | `[[concept]]` resolves anywhere in vault |
| **Cross-hub explicit link** | `[[../other-hub/page]]` or use Obsidian alias system |
| **Hub-scoped search** | Search → `path:python-study tag:#oop` |
| **Per-hub layouts** | **Workspaces** plugin — save panel arrangements per hub |
| **Hub as index page** | **Folder Notes** plugin — hub folder behaves like a page |
| **Per-hub canvas** | Save `<hub>/canvas/` files; they only show their hub |

### What you LOSE with separate vaults / vault 분리 시 손실

- Cross-hub `[[wikilinks]]` break (each vault has its own resolver)
- Global graph impossible
- Have to switch vaults manually (no quick toggle)
- Settings, plugins, hotkeys duplicated
- Templates duplicated

### When separate vaults DO win / 분리 vault가 정말 나은 경우

Only when one of these is critical:

다음 중 하나가 핵심일 때만:

1. **Hard privacy isolation** — accidental cross-contamination is catastrophic (e.g. work secrets vs personal journal).
2. **Different collaborators** — vault-level access control needed.
3. **Different tools per hub** — Obsidian for one, Logseq/Notion for others.
4. **Massive scale** — single hub > 50k pages affecting graph perf (rare).

Otherwise: **one vault wins by every criterion**.

---

## 3. Operational rules / 운영 규칙

### 3.1 Layered CLAUDE.md / 계층화된 CLAUDE.md

Claude Code reads the nearest `CLAUDE.md` upward. Use this:

Claude Code는 가장 가까운 위쪽 `CLAUDE.md`부터 읽음. 활용:

- **Root `CLAUDE.md`** — rules common to all hubs (bilingual format, naming, linking).
  모든 허브 공통 규칙 (병기, 명명, 링크).
- **Hub `<hub>/CLAUDE.md`** — type, domain, hub-specific overrides.
  타입, 도메인, 허브별 오버라이드.

### 3.2 Templates in one place / 템플릿은 한 곳

`<vault>/templates/` is the only template location. All hubs reference these. Improve once → benefit everywhere.

### 3.3 _shared/ for cross-hub pages / 허브 간 공유는 _shared/

When 2+ hubs need the same page (e.g. a common glossary, a frequently mentioned person):

- Move the page to `_shared/<page>.md`
- Update both hubs to link `[[../_shared/<page>]]`

**When to create:** only when the duplication actually appears. Don't pre-build (premature abstraction).

만들 시점: 중복이 실제로 발생할 때만. 미리 만들지 말 것.

### 3.4 .gitignore for personal data / 개인 데이터는 .gitignore

The default `.gitignore` excludes patterns like:

기본 `.gitignore`는 다음 패턴 제외:

```gitignore
*-private/
personal-*/raw/
**/raw/assets/*.{mp4,mov,large.pdf}
.obsidian/workspace*
```

Add your own patterns as needed.

---

## 4. Migrating an existing folder structure / 기존 폴더 구조 이전

If you already have a `Learning/` folder with subfolders, the recommended migration is:

기존 `Learning/` 폴더가 있다면 권장 이전 절차:

1. **Don't** move existing folders into `Learning/Study/` or `Learning/Research/` containers.
   기존 폴더를 `Learning/Study/`나 `Learning/Research/` 컨테이너로 묶지 말 것.
2. Place this template at the same level as (or replacing) `Learning/`.
   이 템플릿을 `Learning/`과 같은 레벨에 두거나 `Learning/`을 대체.
3. Move each existing subfolder **directly** into the template root.
   기존 하위 폴더를 템플릿 루트로 **직접** 이동.
4. (Optional) Rename with `-study` / `-research` suffix for clarity.
   (선택) `-study`/`-research` 접미사로 이름 변경 (명확성).
5. Run [`ONBOARDING.md`](ONBOARDING.md) Phase B with Claude.

The result is a flat list of hubs at the vault root — no `Study/Research/` parent layer.

결과: vault 루트에 허브들이 평평하게 나열됨. `Study/Research/` 부모 레이어 없음.

---

## 4.5 Type transitions / 타입 전환

Hub types evolve over time. Common transitions:

허브 타입은 시간에 따라 진화. 흔한 전환:

| Transition | Frequency | Trigger |
|---|---|---|
| `study` → `mixed` | Common | You start collecting external sources for a topic you've been studying |
| `research` → `mixed` | Common | Your own notes accumulate alongside ingested sources |
| `mixed` → `study` | Possible | All sources digested; `raw/` becomes archive |
| `mixed` → split into two hubs | Common at scale | Notes and sources have diverged into separate sub-topics |
| Direct `study` ↔ `research` | Rare | Discarding either notes or sources outright (usually undesirable) |

### Procedure for any rename / 이름 변경 절차

```bash
# 1. Rename folder (Obsidian: right-click → Rename, or shell mv)
mv research-llm mixed-llm
# Obsidian asks "Update internal links?" → YES (auto-updates [[wikilinks]])
```

```yaml
# 2. Edit hub CLAUDE.md to declare new type
**Hub type:** mixed   # was: research
```

```markdown
# 3. Append to hub wiki/log.md
## [YYYY-MM-DD] transition | research → mixed
- Reason: <why>
- Structural changes: <what moved, what stayed>
```

```bash
# 4. Search & replace markdown links (NOT auto-updated by Obsidian)
# Obsidian Search → "research-llm" → Replace "mixed-llm"
# (covers [text](path) style; [[wikilinks]] already handled in step 1)
```

**Critical Obsidian setting:** Settings → Files & Links → "Automatically update internal links" must be **ON** for step 1 to work.

**중요 Obsidian 설정:** Settings → Files & Links → "Automatically update internal links" 가 **켜져 있어야** 1단계가 동작.

### Splitting a `mixed` hub / mixed 허브 분리

When a `mixed` hub grows and the study/research portions are clearly separable:

```bash
# example: mixed-llm has gotten too big
mkdir study-llm research-llm
mv mixed-llm/{notes/,my-*.md} study-llm/
mv mixed-llm/{raw/,wiki/sources/} research-llm/
# bootstrap each new hub from templates/hub-study/ and templates/hub-research/
# log the split in BOTH new hubs' wiki/log.md
rmdir mixed-llm
```

Or just tell Claude: `"Split mixed-llm into study-llm and research-llm"` — Claude proposes a plan and applies it.

또는 Claude에게: `"mixed-llm을 study-llm과 research-llm으로 분리해 줘"` — Claude가 계획 제시 후 적용.

---

## 5. Adding new hubs over time / 새 허브 추가

```bash
cd <vault-root>
mkdir new-topic-research
# Tell Claude: "Bootstrap new-topic-research as a research hub"
# Claude copies templates/hub-research/* into the new folder
```

Or just drop the folder and run `"Onboard the new folder new-topic-research"` — same result.

폴더만 만들어 두고 Claude에게 `"Onboard new-topic-research"` 라고 해도 동일 결과.

---

## 6. When (if ever) to split into separate vaults / 언제 vault를 나누나

Ask yourself:

자문:

- **(a)** Is privacy boundary critical? (e.g. work vs personal where leak = job loss)
- **(b)** Are collaborators different per hub? (sharing scenarios)
- **(c)** Is one hub so massive it slows down Obsidian on others?

If **none** of these → **stay with one vault**. The integrated graph and shared templates are too valuable to give up.

위 중 **하나도** 해당 안 되면 → **vault 1개 유지**. 통합 그래프와 공용 템플릿의 가치를 포기할 이유 없음.

If **(a)** is true → consider 2 vaults: `pkm-public/` (this template) and `pkm-private/` (separate).

If **(b)** or **(c)** is true → split that one specific hub into its own vault, keep the rest unified.

---

## 7. Embedded inside a larger vault / 더 큰 vault에 내장

If you already have an Obsidian vault with multiple top-level categories (e.g. `작업/`, `하우스키핑/`, `Learning/`), you can place this entire template **inside** one of those categories — typically `Learning/`.

기존 vault에 이미 여러 최상위 카테고리(`작업/`, `하우스키핑/`, `Learning/` 등)가 있다면, 이 템플릿을 그중 하나(보통 `Learning/`) **안에** 통째로 넣으면 됩니다.

```
MyVault/                          ← Obsidian vault root (existing)
├── .obsidian/
├── 작업/
├── 하우스키핑/
└── Learning/                     ← place template here
    ├── CLAUDE.md                 ← scoped to Learning subtree
    ├── ONBOARDING.md
    ├── templates/
    ├── _shared/
    ├── _inbox/                   ← clipper landing (optional)
    └── <hubs>/
```

**3 things to know / 알아둘 3가지:**

1. **CLAUDE.md placement** — Put it at `Learning/CLAUDE.md`, NOT vault root. Claude Code reads from cwd upward, so `cd Learning && claude` picks it up automatically. Other categories (`작업/`, `하우스키핑/`) are unaffected.
   `Learning/CLAUDE.md`에 두기. vault 루트에 두지 말 것. `cd Learning && claude` 하면 자동 인식.
2. **Templater plugin conflict** — If you use Templater globally with a different template folder, `Learning/templates/` won't be auto-detected. That's fine — the LLM uses these via direct file path, not via Obsidian's template UI.
   Templater를 vault 전역으로 다른 폴더에서 쓰고 있어도 충돌 없음 — LLM은 파일 경로로 직접 접근.
3. **Graph view filtering** — The default Graph view becomes too dense with all categories. Use `path:Learning` to isolate the Learning subtree.
   전체 카테고리가 그래프에 뜨면 복잡해짐 — `path:Learning` 필터로 격리.

**Wikilinks across categories:** Cross-category wikilinks (e.g. linking a Learning page to a 작업 page) work natively — `[[../작업/some-page]]` or use Obsidian's alias system.

카테고리 간 위키링크는 그대로 동작 — `[[../작업/some-page]]` 또는 alias 활용.

---

## 8. Project-bound research / 프로젝트 단위 리서치

When you do research as part of a specific project (e.g. brand strategy for client X), don't dump it into your long-term `Learning/`. Embed a research hub inside the project folder.

특정 프로젝트(예: 클라이언트 X용 브랜드 전략) 중 리서치할 때, 그것을 장기 `Learning/`에 던져두지 마세요. 프로젝트 폴더 안에 research hub를 임베드하세요.

### Why / 이유

| Aspect | Mixed into Learning/ | Embedded in project (recommended) |
|---|---|---|
| Lifecycle / 라이프사이클 | Learning is permanent; project ends | Archive whole project folder when done |
| Context / 맥락 | Industry knowledge mixed with client context | Project deliverables and research live together |
| Sharing / 공유 | Can't share Learning/ with team | Zip and share project folder |
| Reuse / 재사용 | Hard to identify "project-only" stuff later | Clear boundary |

### Recommended layout / 권장 구조

```
MyVault/
├── CLAUDE.md, templates/        ← template stays at vault root only
├── Learning/                    ← permanent long-term knowledge
│   ├── study-python/
│   └── research-llm/
│
└── Projects/
    └── hotta/                   ← project root
        ├── CLAUDE.md            ← (optional) project-specific overrides
        ├── research/            ← LLM Wiki research hub, scoped to project
        │   ├── raw/             ← industry sources, competitor articles
        │   └── wiki/
        │       ├── sources/
        │       ├── entities/    ← brand, competitors, key people
        │       └── concepts/    ← industry concepts (grading systems, etc.)
        ├── deliverables/        ← strategy docs, designs
        ├── client-comms/        ← meeting notes, emails
        └── meta/                ← brief, timeline, project mgmt
```

The `research/` subfolder is just a research-type hub at a different depth. Templates and methodology are inherited from vault root.

`research/` 서브폴더는 깊이만 다른 research-type hub일 뿐. 템플릿·방법론은 vault 루트에서 상속.

> **Bootstrap this from [`templates/hub-project/`](templates/hub-project/)** — it includes `meta/` (brief, timeline, stakeholders, decisions), `deliverables/`, `comms/`, `status/`, and the embedded `research/`.
> [`templates/hub-project/`](templates/hub-project/)에서 부트스트랩 — `meta/`(브리프·일정·이해관계자·결정), `deliverables/`, `comms/`, `status/`, 내장 `research/` 포함.

### Why a separate `hub-project/` template / 왜 별도 `hub-project/`

PKM (knowledge accumulation) and PM (project management) are different concerns:

PKM(지식 누적)과 PM(프로젝트 관리)은 다른 관심사:

| | PKM (Wiki) | PM (Project) |
|---|---|---|
| Unit / 단위 | Concepts, entities, sources | Decisions, deliverables, status |
| Time / 시간성 | Permanent accumulation | Bounded — start → end |
| Core question / 핵심 질문 | "What do we know?" | "What did we decide? What did we produce? What's next?" |

The `hub-project/` template bundles **lightweight PM** (brief, ADR-style decisions, stakeholders, weekly status, deliverables index, comms archive) alongside the research hub pattern. **Not a replacement** for dedicated PM tools (Linear, Notion, Asana) — use those for tickets, sprints, time tracking, etc.

`hub-project/`는 research hub 패턴에 **경량 PM** (브리프·ADR 결정·이해관계자·주간 status·산출물 인덱스·커뮤니케이션 아카이브)을 번들. 전용 PM 도구(Linear, Notion, Asana)를 **대체하지 않음** — 티켓·스프린트·시간 추적 등은 그쪽에.

### When to also keep something in Learning/ / Learning/에도 둘지 결정

Some research splits naturally:

리서치는 자연스럽게 둘로 나뉠 수 있음:

| Type | Where it goes / 어디로 |
|---|---|
| **General industry knowledge** (reusable across future projects) | `Learning/research-<industry>/` |
| **Project-specific** (this client, this brief, this competitor analysis) | `Projects/<name>/research/` |

Cross-link with relative wikilinks:

상대 경로 위키링크로 cross-link:

```markdown
<!-- in Projects/hotta/research/wiki/index.md -->
관련 일반 지식 / Related general knowledge:
- [[../../../Learning/research-japanese-tea-industry/wiki/concepts/matcha-grading]]
- [[../../../Learning/research-japanese-tea-industry/wiki/entities/uji-region]]
```

**Decision rule / 판단 기준:**

- "다음 일본 F&B 프로젝트에서 또 쓸 것 같다" → Learning/
- "이번 한 번뿐" → Project/ 안에만
- 헷갈리면 → 일단 Project/ 안에. 두 번째 프로젝트에서 재사용 패턴이 보이면 그때 Learning/으로 승격.
  When in doubt → keep in Project/ first. Promote to Learning/ only when reuse pattern actually emerges in a 2nd project.

### Project lifecycle / 프로젝트 라이프사이클

```bash
# Active project
Projects/hotta/

# Project ends — archive
mv Projects/hotta Projects/_archive/2026-04-hotta
# or zip externally
zip -r ~/archive/2026-04-hotta.zip Projects/hotta && rm -rf Projects/hotta

# Optionally extract reusable parts to Learning/
# (only if you noticed truly reusable concepts during the project)
```

Learning/ stays clean of project-specific noise. Industry knowledge accumulates across projects, which is the actual long-term win.

Learning/은 프로젝트별 노이즈 없이 깨끗하게 유지. 산업 지식만 프로젝트 간에 누적됨 — 그게 진짜 장기 이득.

### ONBOARDING.md and nested hubs / 중첩된 허브와 ONBOARDING

The default ONBOARDING scans hubs at vault root. For nested layouts (`Projects/<name>/research/`), tell Claude explicitly:

기본 ONBOARDING은 vault 루트의 hub를 스캔. 중첩 구조(`Projects/<name>/research/`)는 Claude에게 명시적으로:

```
"Projects/hotta/research를 research-type hub로 부트스트랩해 줘"
```

Claude applies `templates/hub-research/` structure at that path.

Claude가 그 경로에 `templates/hub-research/` 구조를 적용.
