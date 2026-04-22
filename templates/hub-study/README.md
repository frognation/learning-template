# Study Hub Template / 스터디 허브 템플릿

> Use this template for hubs where you have **organized .md notes** for systematic learning (e.g. Python, Design Systems, React).
> 체계적인 학습을 위해 **정리된 .md 노트**가 있는 허브에 사용 (예: Python, 디자인 시스템, React).

---

## When to use / 언제 쓰나

✅ Use `study` type when:
- You have hand-written .md study notes
- The corpus of external sources is small or zero
- You want LLM to help summarize, generate exercises, find gaps

❌ Don't use `study` if you mainly have raw external materials (PDFs, papers) — use `hub-research/` instead.

---

## Bootstrap / 부트스트랩

Bootstrapped automatically by Claude during ONBOARDING (see root [`ONBOARDING.md`](../../ONBOARDING.md)).

ONBOARDING 단계에서 Claude가 자동으로 부트스트랩 (루트 [`ONBOARDING.md`](../../ONBOARDING.md) 참고).

Manual bootstrap, if needed:

```bash
# from vault root
HUB=python-fundamentals
mkdir -p $HUB/wiki
cp templates/hub-study/CLAUDE.md $HUB/CLAUDE.md
cp templates/hub-study/wiki/index.md $HUB/wiki/index.md
cp templates/hub-study/wiki/log.md $HUB/wiki/log.md
# Then edit $HUB/CLAUDE.md to fill in placeholders
```

---

## Resulting layout / 결과 구조

```
<hub>/
├── CLAUDE.md             ← from this template
├── (your existing .md notes — UNTOUCHED)
└── wiki/                 ← LLM-generated synthesis
    ├── index.md
    ├── log.md
    ├── concepts/         (created on demand)
    ├── cheatsheets/      (created on demand)
    └── exercises/        (created on demand)
```

---

## Files in this template / 이 템플릿에 포함된 파일

- [`CLAUDE.md`](CLAUDE.md) — schema for the hub (workflows, what LLM can/can't do)
- [`wiki/index.md`](wiki/index.md) — empty index scaffold
- [`wiki/log.md`](wiki/log.md) — empty log scaffold

Page-level templates (used inside `wiki/`):
- [`../concept.md`](../concept.md) — for `wiki/concepts/` pages
- [`../entity.md`](../entity.md) — rarely used in study hubs (no external entities)
