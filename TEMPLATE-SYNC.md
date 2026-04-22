# TEMPLATE ↔ Personal Vault Sync / 템플릿 ↔ 개인 vault 동기화

> **What this doc is about / 이 문서가 다루는 것:**
> How to keep two things in sync — (1) the public template repo on GitHub, (2) your personal working vault in Dropbox/iCloud — so improvements flow both ways without polluting either.
> 두 가지를 동기화하는 방법 — (1) GitHub의 공개 템플릿 리포, (2) Dropbox/iCloud의 개인 vault — 개선사항이 양쪽으로 흐르되 어느 쪽도 오염시키지 않게.

> **Audience / 대상:** the user (workflow) + AI agents (Claude Code, Codex, etc.) reading this to understand what to do.
> 사용자(워크플로우) + AI 에이전트(Claude Code·Codex 등)가 무엇을 할지 이해하기 위해.

---

## TL;DR

```
TEMPLATE REPO (GitHub)              PERSONAL VAULT (Dropbox)
─────────────────                   ─────────────────
Methodology only                    Methodology + your data
Tracked with git                    NOT tracked with git
Public, anyone can clone            Private, only you
Versioned (v1.0, v1.1, v2.0)        Continuous accumulation

         ▲                                  │
         │   ① clone once at start          │
         ├──────────────────────────────────┤
         │                                  │
         │   ② daily use accumulates data   ▼
         │                       (Dropbox auto-syncs)
         │                                  │
         │   ③ workflow improvement found   │
         │      test in personal first      ▼
         │                                  │
         │   ④ abstract & back-port         │
         ◄──────────────────────────────────┤
         │                                  │
         │   ⑤ tag new version              │
         │                                  │
         ▼                                  ▼
Future you / others get the improvement   You can pull the v.next changes
```

---

## 1. Why the two are separate / 왜 둘을 분리하는가

### The core insight / 핵심 통찰

**Methodology and data have different lifecycles.** Mixing them in one place creates four problems:

**방법론과 데이터는 서로 다른 라이프사이클.** 같은 곳에 섞어두면 네 가지 문제:

| Problem | Detail |
|---|---|
| ❌ Privacy / 프라이버시 | Personal data leaks if you publish the repo |
| ❌ Reuse / 재사용 | New project = duplicate everything (data + methodology) |
| ❌ History / 히스토리 | Methodology improvements buried in data noise commits |
| ❌ Sharing / 공유 | Others can't fork the methodology without your data |

Separating them gives:

분리하면:

| Benefit | Detail |
|---|---|
| ✅ Public template | Methodology is publishable as a clean OSS repo |
| ✅ One-line bootstrap | New vault = `git clone <template>` |
| ✅ Clean history | Each template version corresponds to a methodology change |
| ✅ Forkable | Anyone can fork the template; you can pull their improvements back |

### The mental model / 멘탈 모델

Think of it like:

이렇게 생각하면 됨:

- **Template** = the **cookbook layout** (which sections exist, how recipes are formatted, what fields each recipe has)
- **Personal vault** = the **filled cookbook** (your actual recipes)

You publish the cookbook layout for others to use. You keep your filled recipes private. When you discover that recipes work better with a "Difficulty" field, you add it to the layout and publish v2 of the cookbook.

요리책 레이아웃은 공개. 채워진 본인 요리책은 비공개. "Difficulty" 필드가 있으면 레시피가 더 좋다고 발견하면 레이아웃에 추가하고 v2로 출판.

---

## 2. The two locations / 두 위치

### Location A — Template repo (GitHub) / 템플릿 리포 (GitHub)

```
~/Documents/GitHub/<repo-name>/      # local clone for development
   │
   └── (push to) https://github.com/<your-id>/<repo-name>
```

**Properties / 특성:**
- Tracked with **git**
- Public visibility (recommended)
- Tagged versions: v1.0, v1.1, v2.0...
- Contains: methodology files only (CLAUDE.md, templates/, README.md, etc.)
- **Never** contains personal data
- `.gitignore` blocks common personal data patterns as safety net

**Edits happen here when:** you've validated an improvement in personal use and are abstracting it.

여기서 편집할 때: 개인 사용에서 개선을 검증한 뒤 추상화할 때.

### Location B — Personal vault (Dropbox) / 개인 vault (Dropbox)

```
~/Dropbox/Obsidian/<your-vault>/
├── Learning/                        # cloned from learning-template
└── Projects/                        # cloned from project-template
```

**Properties / 특성:**
- **NOT tracked with git** (Dropbox + git inside Dropbox = sync conflicts in `.git/`)
- Private (only you and your devices)
- No version tags — continuous accumulation
- Contains: methodology files (cloned) + your real data
- Synced across devices via Dropbox

**Edits happen here when:** daily use, hub creation, ingesting sources, project work, decisions, etc.

여기서 편집할 때: 일상 사용, 허브 생성, 자료 흡수, 프로젝트 작업, 결정 등.

### Why no git in personal vault / 왜 personal vault에 git 안 쓰나

`.git/` directory + Dropbox = bad. Git constantly writes binary index files. Dropbox tries to sync them. Multiple devices touching it → `.git/index.lock` conflicts → repo corruption.

`.git/` + Dropbox = 나쁨. Git이 끊임없이 바이너리 index 파일을 씀. Dropbox가 sync 시도. 여러 디바이스가 만지면 → `.git/index.lock` 충돌 → 리포 손상.

**Use Dropbox's own version history** instead (right-click file in web UI → "Version history"). Or pay for **Obsidian Sync** (4 USD/month) — purpose-built for Obsidian, no .git/ involved.

대신 **Dropbox 자체 버전 히스토리** 사용 (웹 UI 우클릭 → "Version history"). 또는 **Obsidian Sync** ($4/월) — Obsidian 전용, .git/ 없이 작동.

---

## 3. Daily workflow / 일상 워크플로우

```
You don't think about templates day-to-day.
You work in Dropbox, Dropbox auto-syncs, life is good.

평소엔 템플릿 신경 안 씀. Dropbox에서 작업, Dropbox가 자동 sync, 평화로움.
```

Examples of daily work:

```
"raw/에 있는 새 자료 ingest해 줘"           # research hub
"이번 주 status 정리해 줘"                  # project
"Hotta 프로젝트의 결정 사항 요약해 줘"      # query
```

No git commits. No template syncing. Just work.

---

## 4. When to back-port / 언제 백포트하나

**Trigger conditions / 트리거 조건:**

You notice in personal use:

개인 사용 중 발견:

- 🔧 Workflow that doesn't quite fit (need a new step in ingest)
- 🆕 Template field you keep adding manually (e.g. "Pronunciation" for language hubs)
- 🐛 Bug or unclear instruction in CLAUDE.md
- 📝 Documentation gap that confused you (or AI in your editor)
- ✨ New page type that emerged from real use

**Validation rule / 검증 규칙:**

Don't back-port immediately. Use it for **at least a few days** in personal vault first. If it still feels right and useful, then back-port.

즉시 백포트 금지. 개인 vault에서 **며칠 이상** 사용 후 여전히 맞고 유용하면 백포트.

---

## 5. The back-port procedure / 백포트 절차

### Step-by-step / 단계별

```bash
# 1. Note what you changed in personal use
#    Example: added "Pronunciation" field to entity.md template
cd ~/Dropbox/Obsidian/Learning
# (you've already edited templates/entity.md here)

# 2. Switch to template repo clone
cd ~/Documents/GitHub/learning-template

# 3. Make the SAME change here — but ABSTRACT
#    Strip your specific examples, keep the pattern
#    Edit templates/entity.md to add the same Pronunciation field
#    Use placeholder examples (<sample-word>), not real data

# 4. Update related docs if needed
#    Sometimes adding a field requires updating CLAUDE.md §3.2 (frontmatter)

# 5. Commit, tag, push
git add templates/entity.md CLAUDE.md
git commit -m "feat(entity): add Pronunciation field for language-learning hubs"
git tag v1.2
git push origin main --tags

# 6. (Optional) Create a GitHub release
gh release create v1.2 --notes "Added Pronunciation field to entity template — useful for language learning hubs."
```

### What "abstract" means / "추상화"의 의미

**Concrete (in personal vault) / 구체 (개인 vault):**
```yaml
# entity.md filled out for Vannevar Bush
pronunciation: "VAN-uh-var BUSH"
```

**Abstract (in template) / 추상 (템플릿):**
```yaml
# entity.md template, with placeholder
pronunciation: <IPA or romanization, e.g. "VAN-uh-var BUSH">
```

The personal example becomes a **comment hint**, not the actual content.

개인 예시는 **주석 힌트**가 되고, 실제 내용은 아님.

### Versioning rules (semver-ish) / 버전 규칙 (semver 비슷)

| Change type | Version bump |
|---|---|
| Bug fix in docs, typo, clarification | v1.1.1 (patch) |
| New optional field, new template, new workflow | v1.2 (minor) |
| Removed feature, restructured folder layout, breaking convention change | v2.0 (major) |

For Korean-style mental model: small fix = small bump.

---

## 6. Pulling template updates into personal vault / 템플릿 업데이트를 개인 vault로 가져오기

This is the **opposite direction** — when the template gets updated (by you or by upstream if you forked someone else's), you may want to apply changes to your personal vault.

반대 방향 — 템플릿이 업데이트되면(본인이 했거나, 다른 사람 것을 fork했다면 upstream에서) 개인 vault에 적용 가능.

### Manual cherry-pick (recommended) / 수동 cherry-pick (권장)

```bash
# 1. See what changed in template
cd ~/Documents/GitHub/learning-template
git log v1.1..v1.2

# 2. Look at specific file diffs
git diff v1.1..v1.2 -- templates/entity.md

# 3. Manually apply ONLY the changes you want, to your personal vault
#    (Don't blindly overwrite — your personal vault may have customizations)
cd ~/Dropbox/Obsidian/Learning
# Edit templates/entity.md, applying the diff manually
```

### Why not auto-merge / 자동 병합 안 하는 이유

Personal vault is not under git. There's no `git merge`. And even if it were:

- Your personal vault may have its own divergent customizations
- Auto-overwriting would clobber them silently
- Some changes need data migration (e.g. existing entity pages need a new field added retroactively)

개인 vault는 git이 아님. `git merge` 없음. 있더라도 개인 customization을 조용히 덮어씀. 일부 변경은 데이터 마이그레이션 필요.

### Letting Claude help / Claude에게 도움 요청

```
TEMPLATE-SYNC 작업: ~/Documents/GitHub/learning-template의 v1.1과 v1.2 사이 변경사항을 보고,
~/Dropbox/Obsidian/Learning에 적용해야 할 부분을 제안해 줘.
- 내가 customize한 부분이 있으면 충돌 표시
- 기존 데이터(엔티티 페이지들)에 새 필드 추가가 필요하면 그것도 알려줘
- 적용 전 plan 출력 후 confirm 받기
```

Claude can read both locations, diff them, and propose a merge plan.

Claude가 두 위치를 읽고, diff 내고, 병합 계획 제안.

---

## 7. The 5 critical rules / 핵심 규칙 5가지

```yaml
rules:
  1. no_personal_data_in_template:
      desc: "Template repo never contains personal/client data."
      enforcement: ".gitignore + manual review before push"
      desc_ko: "템플릿 리포에 개인·클라이언트 데이터 절대 X."

  2. no_git_in_personal_vault:
      desc: "Don't run `git init` inside the Dropbox-synced vault."
      reason: "Dropbox + .git/ = sync conflicts and corruption"
      alternative: "Use Dropbox file history or Obsidian Sync"
      desc_ko: "Dropbox sync 폴더 안에서 git init 금지."

  3. test_in_personal_first:
      desc: "Validate improvements in personal vault for several days before back-porting."
      reason: "Avoids polluting template with half-baked ideas"
      desc_ko: "개선은 personal에서 며칠 검증 후 백포트."

  4. backport_means_abstract:
      desc: "When back-porting, strip personal examples, generalize the pattern."
      example: "Real entity 'Vannevar Bush' → template placeholder '<Entity Name>'"
      desc_ko: "백포트는 추상화 — 개인 예시 제거, 패턴만 일반화."

  5. tag_versions_semantically:
      desc: "v1.0 (initial), v1.1 (small feature), v2.0 (breaking)."
      enforcement: "git tag + GitHub release"
      desc_ko: "버전 태깅은 의미 있게."
```

---

## 8. For AI agents reading this / AI 에이전트를 위한 섹션

If you (Claude Code, Codex, Cursor, etc.) are reading this file because the user is asking you to help with template-personal sync:

이 파일을 읽고 있는 AI(Claude Code, Codex, Cursor 등)가 사용자의 sync 작업을 도울 때:

### Tasks you may be asked to do / 요청받을 수 있는 작업

```yaml
tasks:
  back_port:
    user_says: "이 변경사항을 템플릿에 백포트해 줘"
    you_should:
      - identify the specific change in personal vault
      - locate the corresponding file in template repo path
      - apply the change in abstracted form (replace personal data with placeholders)
      - update related docs (CLAUDE.md sections referenced)
      - propose commit message + version bump
      - DO NOT execute git push without explicit user confirmation

  pull_updates:
    user_says: "템플릿 v1.x → v1.y 업데이트를 내 vault에 적용해 줘"
    you_should:
      - read git diff in template repo between the two versions
      - check personal vault for customizations that might conflict
      - present a diff/plan: "these files in your vault will change..."
      - flag any customizations that conflict
      - apply only after user confirms
      - DO NOT auto-overwrite files with customizations

  sync_check:
    user_says: "내 vault가 템플릿 최신 버전과 얼마나 다른지 봐줘"
    you_should:
      - compare files between template and personal vault
      - report: which template files differ from your personal copies
      - categorize: customizations vs. missed updates
      - suggest cherry-pick candidates
```

### Constraints / 제약

```yaml
constraints:
  must_not:
    - run `git init` in any Dropbox/iCloud-synced path
    - push to GitHub without explicit user confirmation
    - overwrite personal vault files without showing diff first
    - commit personal data to template repo
  must:
    - always show plan before destructive ops
    - preserve personal customizations during pulls
    - use semver for version bumps
    - tag and release on GitHub when pushing template updates
```

### Path conventions to recognize / 인식할 경로 컨벤션

```yaml
template_repo_paths:
  - "~/Documents/GitHub/<repo>/"
  - "~/code/<repo>/"
  - any path NOT inside Dropbox/iCloud/OneDrive

personal_vault_paths:
  - "~/Dropbox/**"
  - "~/Library/Mobile Documents/iCloud~md~obsidian/**"
  - "~/OneDrive/**"
  - any path inside a cloud-sync folder

if_path_unclear: ASK USER which is which before any sync action
```

---

## 9. Real-world analogies / 실세계 비유

| Domain | Template equivalent | Personal-use equivalent |
|---|---|---|
| Software | `create-react-app` starter | Your actual React app |
| Cooking | Cookbook layout / blank recipe template | Your filled cookbook |
| Notion | Template gallery entry | Your Notion workspace |
| Scientific writing | LaTeX paper template | Your actual paper |
| OSS development | "Awesome list" template | Your team's internal docs |

Once you internalize this pattern, you'll start seeing it everywhere — and it's why some software ecosystems (npm, Cargo, Composer) have first-class support for it.

이 패턴이 익숙해지면 어디서든 보임 — npm·Cargo·Composer 같은 생태계가 first-class로 지원하는 이유.

---

## 10. Versioning history of this template / 이 템플릿의 버전 이력

See [GitHub releases](https://github.com/frognation/learning-template/releases) for the full version history.

전체 버전 히스토리는 [GitHub releases](https://github.com/frognation/learning-template/releases) 참고.

| Version | Date | What changed |
|---|---|---|
| v1.0 | Initial release | Multi-hub bilingual template (study, research, mixed types) |
| v1.1 | (added project type, then split out — see below) | |
| v2.0 | Split | hub-project moved out to separate `project-template` repo for cleaner separation of concerns |

For the companion project template, see: https://github.com/frognation/project-template
짝 프로젝트 템플릿: https://github.com/frognation/project-template
