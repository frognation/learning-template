# Research Hub Template / 리서치 허브 템플릿

> Use this template for hubs where you have **a corpus of external sources** (PDFs, papers, articles, web clips) that you want LLM to ingest, summarize, and weave into a wiki.
> 외부 자료(PDF, 논문, 기사, 웹클립) **더미**가 있고, LLM이 그것을 흡수·요약·위키화할 허브에 사용.

This template applies the full LLM Wiki methodology described in [`../../llm-wiki.md`](../../llm-wiki.md).

이 템플릿은 [`../../llm-wiki.md`](../../llm-wiki.md)의 전체 LLM Wiki 방법론을 적용합니다.

---

## When to use / 언제 쓰나

✅ Use `research` type when:
- You have a pile of source materials (or plan to accumulate them)
- Sources are NOT user-authored — they're external (web, books, papers, transcripts)
- You want LLM to compile them into a structured, cross-linked wiki

❌ Don't use `research` if you mainly write your own notes — use `hub-study/` instead.

---

## Bootstrap / 부트스트랩

Bootstrapped automatically by Claude during ONBOARDING (see root [`ONBOARDING.md`](../../ONBOARDING.md)).

ONBOARDING 단계에서 Claude가 자동으로 부트스트랩 (루트 [`ONBOARDING.md`](../../ONBOARDING.md) 참고).

Manual bootstrap, if needed:

```bash
# from vault root
HUB=llm-research
mkdir -p $HUB/{raw,wiki/{sources,entities,concepts}}
cp templates/hub-research/CLAUDE.md $HUB/CLAUDE.md
cp templates/hub-research/wiki/index.md $HUB/wiki/index.md
cp templates/hub-research/wiki/log.md $HUB/wiki/log.md
# Then drop sources into $HUB/raw/ and tell Claude to ingest
```

---

## Resulting layout / 결과 구조

```
<hub>/
├── CLAUDE.md             ← from this template
├── raw/                  ← immutable source documents (PDFs, clips, etc.)
│   └── assets/           ← downloaded images
└── wiki/                 ← LLM-owned synthesis
    ├── index.md
    ├── log.md
    ├── sources/          ← per-source summary pages
    ├── entities/         ← people, orgs, products
    └── concepts/         ← ideas, theories, patterns
```

---

## Files in this template / 이 템플릿에 포함된 파일

- [`CLAUDE.md`](CLAUDE.md) — schema for the hub (ingest/query/lint workflows)
- [`wiki/index.md`](wiki/index.md) — empty index scaffold
- [`wiki/log.md`](wiki/log.md) — empty log scaffold

Page-level templates (used inside `wiki/`):
- [`../source.md`](../source.md) — for `wiki/sources/` pages
- [`../entity.md`](../entity.md) — for `wiki/entities/` pages
- [`../concept.md`](../concept.md) — for `wiki/concepts/` pages
