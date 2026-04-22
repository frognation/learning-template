# Multi-Agent Usage Guide / 멀티 에이전트 사용 가이드

> Use this vault from Claude Code, Codex CLI, Cursor, Windsurf, or Gemini CLI — with the **same rules** applying to all of them.
> 이 볼트를 Claude Code, Codex CLI, Cursor, Windsurf, Gemini CLI 어디서든 **동일 규칙**으로 사용.

---

## 1. Why this file exists / 이 파일의 이유

Each agent reads its own config filename:

각 에이전트는 서로 다른 파일명을 읽습니다:

| Agent / 에이전트 | Default config / 기본 설정 |
|---|---|
| Claude Code | `CLAUDE.md` |
| Codex CLI | `AGENTS.md` |
| Cursor | `CLAUDE.md` (recent) or `.cursor/rules/*.mdc` |
| Windsurf | `.windsurfrules` |
| Gemini CLI | `GEMINI.md` |

To keep rules consistent, **`CLAUDE.md` is the single source of truth**. All other variants are generated mirrors.

규칙 일관성을 위해 **`CLAUDE.md`가 유일한 원본(single source of truth)**. 나머지는 자동 생성 미러.

> ⚠️ **Never edit `AGENTS.md` or `GEMINI.md` directly** — they get overwritten by the sync script.
> **`AGENTS.md`·`GEMINI.md` 직접 수정 금지** — sync 스크립트가 덮어씀.

---

## 2. Generate mirror files / 미러 파일 생성

Run once after cloning, and again whenever you edit any `CLAUDE.md`:

clone 직후 1회, 그리고 `CLAUDE.md` 수정할 때마다:

```bash
bash scripts/sync-agent-configs.sh
```

This walks all `CLAUDE.md` files at every level (root + each hub) and writes `AGENTS.md` and `GEMINI.md` next to them.

모든 레벨(루트 + 각 허브)의 `CLAUDE.md`를 찾아 같은 위치에 `AGENTS.md`·`GEMINI.md` 생성.

### Optional: auto-sync on commit / 커밋 시 자동 sync (선택)

If you use git in the **template repo** (not in the Dropbox vault), add a pre-commit hook:

**템플릿 리포**에서 git 쓸 때(드롭박스 볼트 아님) pre-commit hook 추가:

```bash
# .git/hooks/pre-commit
#!/usr/bin/env bash
bash scripts/sync-agent-configs.sh > /dev/null
git add '**/AGENTS.md' '**/GEMINI.md'
```

```bash
chmod +x .git/hooks/pre-commit
```

---

## 3. Per-agent startup / 에이전트별 시작

### Claude Code / 클로드 코드

```bash
cd <hub-folder>
claude
```

Auto-reads nearest `CLAUDE.md` + ancestors. / 가장 가까운 `CLAUDE.md`와 상위 파일을 자동 인식.

### Codex CLI / 코덱스 CLI

```bash
cd <hub-folder>
codex
```

Reads `AGENTS.md` (generated from `CLAUDE.md`). / `CLAUDE.md`에서 생성된 `AGENTS.md`를 읽음.

### Cursor / Windsurf

Open the vault (or a specific hub folder) as a workspace. The editor picks up `CLAUDE.md` / `.windsurfrules` automatically.

볼트(또는 특정 허브) 폴더를 워크스페이스로 열기. 에디터가 `CLAUDE.md` / `.windsurfrules` 자동 인식.

For Windsurf, generate `.windsurfrules`:

Windsurf용은 `.windsurfrules` 별도 생성:

```bash
# Add to scripts/sync-agent-configs.sh VARIANTS array if you use Windsurf daily
# Windsurf를 상시 쓰면 VARIANTS 배열에 추가
VARIANTS=(AGENTS.md GEMINI.md .windsurfrules)
```

### Gemini CLI / 제미나이 CLI

```bash
cd <hub-folder>
gemini
```

Reads `GEMINI.md`. / `GEMINI.md`를 읽음.

---

## 4. Session scoping — the biggest win / 세션 범위 — 가장 큰 최적화

**Always open your session at the narrowest useful folder.** This is the single biggest token-saving decision.

**가능한 가장 좁은 폴더에서 세션 열기.** 토큰 절약에서 가장 큰 결정.

| Where you `cd` / `cd` 위치 | What the agent sees / 에이전트가 보는 범위 |
|---|---|
| Vault root (`MyVault/`) | Everything — all hubs, all projects / 모든 허브·프로젝트 |
| Hub parent (`Learning/`) | All hubs in this category / 이 카테고리의 모든 허브 |
| Specific hub (`Learning/python-study/`) ⭐ | Just this hub / 이 허브만 |
| Subfolder (`Learning/python-study/wiki/`) | Even narrower / 더 좁게 |

**Rule of thumb / 원칙:** If your task is about ONE hub, start the session IN that hub. Don't waste tokens loading siblings into context.

**원칙:** 한 허브 안의 작업이면 그 허브 안에서 세션 시작. 형제 허브를 컨텍스트에 끌어오지 말 것.

---

## 5. Token optimization / 토큰 최적화

### 5.1 Let the agent use `index.md` first / `index.md` 먼저 활용

The hub's `wiki/index.md` is a curated catalog with one-line summaries. It's the cheapest first read for any query.

허브의 `wiki/index.md`는 한 줄 요약 카탈로그. 어떤 쿼리든 가장 저렴한 첫 읽기.

**Good prompt / 좋은 프롬프트:**
```
"먼저 wiki/index.md 훑어보고 transformer 관련 페이지만 선별해서 읽은 뒤 답해 줘"
```

**Bad prompt / 나쁜 프롬프트:**
```
"transformer 관련 내용 다 찾아서 설명해 줘"   # 에이전트가 폴더 전체 grep할 수 있음
```

### 5.2 Keep `CLAUDE.md` tight / `CLAUDE.md` 짧게 유지

Every agent reads `CLAUDE.md` at session start. If it's 1000 lines, that's 1000 lines × every session.

매 세션 시작마다 `CLAUDE.md` 로딩됨. 1000줄이면 매 세션마다 1000줄.

- Keep `CLAUDE.md` under ~300 lines / `CLAUDE.md`는 300줄 이내
- Long explanations → move to `FOLDER-STRUCTURE.md`, `llm-wiki.md` / 긴 설명은 다른 파일로
- Schemas and rules stay in `CLAUDE.md` / 스키마·규칙만 `CLAUDE.md`에

### 5.3 Tell the agent what NOT to read / 읽지 말 것 명시

Add to your hub's `CLAUDE.md` or per-session:

```
- Don't read `raw/` contents unless ingesting a specific file.
- Don't read PDF/image files during normal queries.
- Don't grep across hubs without explicit request.
```

### 5.4 Use Dataview for structured queries / 구조화 쿼리는 Dataview

Frontmatter queries cost **zero LLM tokens** — they run in Obsidian.

frontmatter 쿼리는 **LLM 토큰 0** — Obsidian 내부에서 실행.

**Use Dataview for / Dataview 용도:**
- "최근 7일 ingest된 자료" → DQL
- "sources > 3 인 concept 페이지" → DQL
- 대시보드·동적 인덱스 / dashboards

**Use LLM for / LLM 용도:**
- Synthesis across pages / 페이지 간 종합
- Qualitative comparison / 정성적 비교
- Gap analysis / 빈 곳 분석

### 5.5 Clear context between hubs / 허브 전환 시 컨텍스트 리셋

In Claude Code: `/clear` or new session.  In Codex: restart. Don't carry one hub's context into another.

Claude Code: `/clear` 또는 새 세션. Codex: 재시작. 허브 간 컨텍스트 이월 X.

### 5.6 `/compact` periodically / 주기적 `/compact`

In Claude Code, long sessions: `/compact` to summarize and reset conversation history while keeping salient facts.

Claude Code 장시간 세션: `/compact`로 대화 요약·리셋 (중요 사실은 유지).

### 5.7 Skip patterns for agent-aware tools / 에이전트용 skip 패턴

If your agent supports an ignore file (Codex `.codexignore`, Cursor `.cursorignore`), exclude heavy folders:

Codex `.codexignore`, Cursor `.cursorignore` 지원 시 대용량 폴더 제외:

```
raw/
**/*.pdf
**/*.psd
**/*.ai
**/*.fig
node_modules/
.obsidian/
_archive/
```

### 5.8 Scoped reads / 범위 지정 읽기

When you know exactly which section matters, tell the agent:

필요한 섹션을 알면 명시:

```
"wiki/index.md의 ## Concepts 섹션만 읽고"
"transformer.md의 ## Key ideas 부분만"
```

### 5.9 Batch similar operations / 유사 작업 배치

Instead of 5 separate "ingest X" prompts, one "ingest these 5 files" prompt. The agent can parallelize reads and share context.

"X ingest" 5번 따로 말고 "이 5개 ingest" 한 번에. 읽기 병렬화·컨텍스트 공유 가능.

### 5.10 Reuse sessions for related work / 연관 작업은 같은 세션

Same hub, same topic → keep the session. Cached context = cheaper subsequent reads.

같은 허브·같은 주제 → 세션 유지. 캐시된 컨텍스트 = 후속 읽기 저렴.

---

## 6. Cross-agent consistency checks / 에이전트 간 일관성 확인

Every so often, verify all variants match:

주기적으로 미러가 동기 상태인지 확인:

```bash
# If any diff appears, someone edited a mirror directly — re-sync
for f in $(find . -name "CLAUDE.md" -not -path "*/.git/*"); do
  dir=$(dirname "$f")
  diff <(tail -n +2 "$dir/AGENTS.md" 2>/dev/null) "$f" > /dev/null || echo "MISMATCH: $dir"
done
```

If any mismatch → run `bash scripts/sync-agent-configs.sh` again.

---

## 7. Quick reference / 빠른 참조

```bash
# Generate mirrors after CLAUDE.md edit / CLAUDE.md 수정 후
bash scripts/sync-agent-configs.sh

# Open session in specific hub / 특정 허브에서 세션
cd <vault>/<hub>
claude      # or: codex / gemini

# Claude Code: compact long session / 장시간 세션 압축
/compact

# Claude Code: clear between hubs / 허브 전환 시
/clear
```

---

## 8. When rules diverge across agents / 에이전트별 규칙이 달라야 할 때

Rare, but sometimes you want Codex to behave differently from Claude Code. Three approaches:

드물지만 Codex와 Claude Code 동작을 다르게 하고 싶을 때:

1. **Agent-specific section in CLAUDE.md** — use conditional headings: `### For Codex only / 코덱스 전용`. The mirror still carries it; Claude Code just ignores irrelevant sections.
   **CLAUDE.md에 에이전트별 섹션** — 조건부 제목 사용. 미러에도 그대로 들어가고, Claude Code는 무관 섹션 무시.

2. **Stop mirroring and edit separately** — remove `AGENTS.md` from the sync script's `VARIANTS` array, then maintain it manually.
   **미러링 중단·수동 관리** — sync 스크립트의 `VARIANTS`에서 제거.

3. **Per-agent override file** — e.g., `.codex/overrides.md` read only by Codex; keep `CLAUDE.md` as the shared base.
   **에이전트별 오버라이드 파일** — 예: `.codex/overrides.md`.

Default: single source of truth in `CLAUDE.md`, mirror to all. Diverge only when necessary.

기본: `CLAUDE.md` 원본 + 전체 미러. 필요할 때만 분기.
