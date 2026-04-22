# ONBOARDING — First-Run Integration / 첫 실행 통합 가이드

> **Read this when:** you've just cloned this template into a new location and moved (or are about to move) your existing knowledge folders into it.
> **이 문서를 읽을 때:** 이 템플릿을 새 위치에 복제하고, 기존 지식 폴더들을 그 안에 옮겼거나 옮기기 직전.
>
> **Audience / 대상:** the human user (Phase A) AND the next Claude session (Phase B).
> 사람 사용자(Phase A) + 다음 Claude 세션(Phase B) 모두를 위한 문서.

---

## TL;DR

1. **You** (human) move your existing folders into this vault root. Don't create `raw/`, `wiki/`, or `CLAUDE.md` yourself.
   사용자가 기존 폴더들을 이 vault 루트로 옮긴다. `raw/`, `wiki/`, `CLAUDE.md` 같은 건 직접 만들지 마세요.
2. **Start a new Claude session**, tell it: `"Read ONBOARDING.md and integrate my hubs."`
   새 Claude 세션을 시작하고 말하기: `"ONBOARDING.md 읽고 내 허브들 통합해 줘."`
3. Claude classifies each folder (study vs research), proposes the structure, and applies it after your confirmation.
   Claude가 각 폴더를 분류(study vs research)하고, 구조 변경안을 제시한 뒤, 확인을 받고 적용한다.

---

## Phase A — You move your folders / 사용자가 폴더를 옮기는 단계

### A.1 Inventory / 인벤토리

기존 Learning(또는 비슷한) 폴더 안의 모든 하위 폴더를 한 줄씩 적어 보세요. 각각에 대해 다음 중 하나로 라벨링:

List every subfolder in your existing Learning folder. Label each one of:

| 라벨 / Label | 의미 / Meaning | 예시 / Example |
|---|---|---|
| `study` | 체계적으로 정리된 .md 노트 모음. 사용자가 직접 작성. 원본 자료(PDF/HTML)는 거의 없음. | Python 학습 정리, 디자인 시스템 학습 정리 |
| `research` | 외부 자료(PDF, 웹클립, 논문) 더미. LLM이 읽고 위키로 만들 대상. | LLM 논문 모음, 특정 토픽 자료 모음 |
| `mixed` | 정리된 노트 + 원본 자료가 섞여 있음. | 학습 노트와 참고 논문이 같이 든 폴더 |

> Time-bounded **projects** (client work, deliverables) belong in the [project-template](https://github.com/frognation/project-template) repo, not here. If you have project folders, install project-template as a sibling (usually `MyVault/Projects/`) and move them there instead.
> 기간 한정 **프로젝트**는 여기 말고 [project-template](https://github.com/frognation/project-template)으로. 프로젝트 폴더가 있으면 project-template을 형제 폴더(보통 `MyVault/Projects/`)로 설치 후 거기로.

판단 기준 / Decision rules:
- `.md` 파일 위주에 본인이 직접 쓴 노트 → **study**
- PDF/HTML/스크린샷/웹클립 위주, 정리는 거의 안 됨 → **research**
- 둘 다 → **mixed** (Phase B에서 분리 검토)

### A.2 Naming convention (선택) / Optional naming

원하면 폴더 이름에 타입을 표시하세요. Claude가 자동 분류 시 신뢰도를 높여 줍니다.

Optionally rename folders to encode type — improves Claude's auto-classify confidence:

| Pattern | Example |
|---|---|
| **type-first / 접두 (권장)** | `study-python/`, `research-llm/`, `mixed-neuroscience/` |
| **topic-first / 접미** | `python-study/`, `llm-research/`, `neuroscience-mixed/` |

타입 표시가 없어도 Claude가 내용 기반으로 추론. 단지 신뢰도가 떨어질 뿐.

Type marker optional — Claude infers from contents otherwise, just with lower confidence.

> **Pick one pattern per vault and stay consistent.** Don't mix `study-python/` and `llm-research/` in the same vault.
> **vault 안에서는 하나만.** `study-python/`과 `llm-research/`를 한 vault에서 섞지 말 것.

### A.3 Move / 옮기기

옮길 위치: **이 템플릿 폴더의 루트** (이 ONBOARDING.md와 같은 레벨).

Destination: **the root of this template folder** (same level as this ONBOARDING.md).

```
<this-template-folder>/
├── README.md
├── CLAUDE.md
├── ONBOARDING.md            ← this file / 이 파일
├── FOLDER-STRUCTURE.md
├── llm-wiki.md
├── llm-wiki.ko.md
├── templates/                ← DON'T touch / 건드리지 마세요
├── _shared/                  ← DON'T touch / 건드리지 마세요
│
├── python-fundamentals/      ← MOVED HERE / 여기로 옮긴 폴더
├── design-systems/
├── llm-papers/
└── ...
```

### A.4 What NOT to do / 하지 말 것

- ❌ 폴더 안에 `raw/`, `wiki/`, `CLAUDE.md` 미리 만들지 마세요. Claude가 만들어요.
  Don't pre-create `raw/`, `wiki/`, `CLAUDE.md` inside hubs. Claude does that.
- ❌ 기존 파일을 미리 옮기지 마세요 (PDF를 raw/에 넣는 등). Claude가 제안하고 확인받은 뒤 처리.
  Don't pre-move files (e.g. PDFs into a raw/ you made). Claude proposes and confirms.
- ❌ `templates/`, `_shared/`, 루트의 `*.md` 파일들은 절대 덮어쓰지 마세요.
  Never overwrite `templates/`, `_shared/`, or root `*.md` files.

### A.5 Save before continuing / 백업 권장

Phase B 이전에 한 번 git commit하거나 폴더 전체를 백업하세요. Claude가 destructive 작업 전 확인을 받지만, 실수에 대비.

Before Phase B, do a git commit or full backup. Claude confirms before destructive actions, but be safe.

```bash
cd <this-template-folder>
git init && git add -A && git commit -m "snapshot before integration"
```

---

## Phase B — Claude integrates / Claude가 통합하는 단계

> **Claude: this section is your runbook. Follow it step-by-step.**
> Claude가 이 섹션을 따라 단계별로 실행합니다.

### B.0 Trigger / 트리거

User says: "Read ONBOARDING.md and integrate my hubs" (in Korean or English).

Or, on first-message of a session, if Claude detects unintegrated hubs (folders at root that lack a hub `CLAUDE.md`), Claude proactively offers to run integration.

세션 첫 메시지에서, Claude가 루트에 hub `CLAUDE.md`가 없는 폴더들을 발견하면 통합 진행 여부를 먼저 제안.

### B.1 Discover hubs / 허브 발견

```bash
# List candidate hubs at the vault root
ls -d */ | grep -vE '^(templates|_shared|\.)'
```

For each non-underscore, non-template folder at root → candidate hub.

루트의 underscore·템플릿 외 폴더들 = 통합 대상 후보.

### B.2 Classify each hub / 각 허브 분류

For EACH candidate folder, run this decision tree:

각 후보 폴더에 대해 다음 결정 트리 적용:

```
1. Folder has project-management indicators (meta/brief.md, deliverables/, client-*, contract*)?
   → STOP and tell user: "This looks like a project, not a learning hub. Move it to your project-template folder (e.g. ~/Vault/Projects/)."

2. Folder has `raw/` with content?
   → research (already partly bootstrapped)

3. Folder name has type marker (prefix OR suffix)?
   - starts with `study-` OR ends with `-study` → study
   - starts with `research-` OR ends with `-research` → research
   - starts with `mixed-` OR ends with `-mixed` → mixed

4. Count files at folder root and depth ≤2:
   - md_count = number of .md files
   - source_count = number of .pdf / .html / .epub / .docx / image / audio / video files

   - md_count ≥ 5 AND source_count ≤ 2 → study
   - source_count ≥ 5 AND md_count ≤ 2 → research
   - Both ≥ 5 → mixed
   - Both small → ASK user

5. If still ambiguous → ASK user
```

### B.3 Preview plan / 계획 출력

**BEFORE making any changes**, output a markdown table of the plan. Wait for user confirmation.

**아무 변경도 하기 전에**, 계획을 마크다운 표로 출력. 사용자 확인을 기다림.

Example preview:

```markdown
## Integration plan / 통합 계획

| Hub folder | Detected type | Action / 작업 |
|---|---|---|
| python-fundamentals/ | study | Add `wiki/`, hub `CLAUDE.md`. **No file moved.** |
| design-systems/ | study | Add `wiki/`, hub `CLAUDE.md`. **No file moved.** |
| llm-papers/ | research | Move 14 PDFs → `raw/`. Add `wiki/`, hub `CLAUDE.md`. |
| ai-ethics/ | mixed | **ASK USER**: split into `ai-ethics-study/` + `ai-ethics-research/`? |

Total: 4 hubs. 14 files will be moved. 0 files will be deleted.

Proceed? [y/n]
```

### B.4 Apply per type / 타입별 적용

#### B.4.a study hub

For each study hub:

1. Copy `templates/hub-study/CLAUDE.md` → `<hub>/CLAUDE.md`
   - Replace `<Hub Name>` / `<허브 한글명>` placeholders with actual names
   - Replace `<DOMAIN>` with hub's domain (infer from folder name + .md content sampling)
2. Copy `templates/hub-study/wiki/index.md` → `<hub>/wiki/index.md`
3. Copy `templates/hub-study/wiki/log.md` → `<hub>/wiki/log.md`
4. **Do NOT touch existing .md files.** They are user-authored — authoritative.
5. Append to `<hub>/wiki/log.md`:
   ```
   ## [<today>] init | hub bootstrapped as study type
   - Detected <N> existing .md files (preserved untouched).
   - Added wiki/, CLAUDE.md.
   ```

#### B.4.b research hub

For each research hub:

1. Copy `templates/hub-research/CLAUDE.md` → `<hub>/CLAUDE.md` (with placeholder replacement)
2. Create `<hub>/raw/` if missing. **PREVIEW** which files go there:
   - .pdf, .html, .epub, .docx, image/audio/video files
   - Web clips (markdown files that look like clipped articles — frontmatter with `url:` or similar)
   - **DO NOT** auto-move user-authored .md notes — ask separately
3. After confirmation, move source files → `<hub>/raw/`
4. Copy `templates/hub-research/wiki/{index,log}.md` and create `wiki/{sources,entities,concepts}/`
5. Append log entry:
   ```
   ## [<today>] init | hub bootstrapped as research type
   - Moved <N> source files to raw/.
   - Preserved <M> .md notes at hub root (not in raw/, not in wiki/) — pending user review.
   - Added wiki/ scaffolding. No ingest yet — awaiting user instruction.
   ```

#### B.4.c mixed hub

ASK the user before doing anything:

- Option 1: Split into two folders (`<hub>-study/` + `<hub>-research/`).
- Option 2: Keep as one hub. .md notes stay at root, source files go to `raw/`. Use both workflows.

After choice, apply B.4.a or B.4.b accordingly.

### B.5 Update root indices / 루트 인덱스 갱신

After all hubs are processed:

1. Append a section to root `README.md` listing all hubs and their types (under "Hubs" heading).
2. Create root `wiki-log.md` (or similar) noting the onboarding event.

### B.6 Final report / 최종 보고

Output a summary:

```markdown
## Integration complete / 통합 완료

- ✅ 3 hubs integrated as `study`
- ✅ 2 hubs integrated as `research` (16 files moved to raw/)
- ⚠️  1 hub flagged as `mixed` — awaiting user decision

### Next steps / 다음 단계

For research hubs, you can now ingest sources:
> "Ingest the next source in llm-papers/raw/"

For study hubs, you can ask Claude to generate synthesis pages:
> "In python-fundamentals, summarize the OOP notes into a wiki/concepts/ page"
```

---

## Safety contract / 안전 규칙

Claude MUST:

- ✅ Always preview the full plan before any file move/rename
- ✅ Get explicit user confirmation (y/n) before destructive operations
- ✅ NEVER delete user files (only move, with a recorded location)
- ✅ Log every action to the hub's `wiki/log.md`
- ✅ If unsure → ASK; don't guess

Claude MUST NOT:

- ❌ Modify files under `templates/`, `_shared/`, or any root `*.md` (except logs)
- ❌ Edit user-authored .md files in study hubs without explicit per-file request
- ❌ Auto-ingest research hub content during onboarding (that's a separate workflow)
- ❌ Use `rm -rf` or any destructive shell command without showing the exact command + getting `y` first

---

## After onboarding / 통합 이후

This file (`ONBOARDING.md`) stays in the vault. If you add a new hub later:

1. Drop the new folder at root.
2. Tell Claude: `"Onboard the new folder <name>"`.
3. Claude runs Phase B for just that folder.

For day-to-day operations, see [`README.md`](README.md) and [`CLAUDE.md`](CLAUDE.md).

일상 운영은 [`README.md`](README.md)와 [`CLAUDE.md`](CLAUDE.md) 참고.
