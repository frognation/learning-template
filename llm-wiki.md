# LLM Wiki — Bilingual / 영·한 병기

> A pattern for building personal knowledge bases using LLMs.
> LLM을 활용해 개인 지식 베이스를 구축하기 위한 패턴.

> This is an idea file, designed to be copy-pasted to your own LLM agent (e.g. OpenAI Codex, Claude Code, OpenCode / Pi). Its goal is to communicate the high-level idea — your agent will build out the specifics in collaboration with you.
> 이 문서는 "아이디어 파일"입니다. 사용자가 자신의 LLM 에이전트(예: OpenAI Codex, Claude Code, OpenCode / Pi)에 그대로 복사·붙여넣기 해서 쓰는 것을 전제로 만들어졌습니다. 이 문서의 목적은 큰 그림을 전달하는 것이고, 구체적인 구현은 에이전트가 사용자와 협업하며 만들어 갑니다.

---

## The core idea / 핵심 아이디어

Most people's experience with LLMs and documents looks like RAG: you upload a collection of files, the LLM retrieves relevant chunks at query time, and generates an answer. This works, but the LLM is rediscovering knowledge from scratch on every question. There's no accumulation. Ask a subtle question that requires synthesizing five documents, and the LLM has to find and piece together the relevant fragments every time. Nothing is built up. NotebookLM, ChatGPT file uploads, and most RAG systems work this way.

대부분의 사람들이 "LLM + 문서"를 다룰 때 떠올리는 모습은 RAG입니다. 파일들을 업로드해 두면, 질의 시점에 LLM이 관련 청크(chunk)를 검색해 와서 답을 만듭니다. 이 방식은 작동은 하지만, **LLM이 매 질문마다 지식을 처음부터 다시 발견해야** 합니다. 누적이 없어요. 5개 문서를 종합해야만 답할 수 있는 미묘한 질문을 던지면, LLM은 매번 관련 단편들을 다시 찾고 다시 짜맞춰야 합니다. 쌓이는 것이 없습니다. NotebookLM, ChatGPT 파일 업로드 등 대부분의 RAG 시스템이 이 방식입니다.

The idea here is different. Instead of just retrieving from raw documents at query time, the LLM **incrementally builds and maintains a persistent wiki** — a structured, interlinked collection of markdown files that sits between you and the raw sources. When you add a new source, the LLM doesn't just index it for later retrieval. It reads it, extracts the key information, and integrates it into the existing wiki — updating entity pages, revising topic summaries, noting where new data contradicts old claims, strengthening or challenging the evolving synthesis. The knowledge is compiled once and then *kept current*, not re-derived on every query.

이 문서가 제안하는 아이디어는 다릅니다. 질의 시점에 원문을 그저 검색하는 대신, **LLM이 점진적으로 위키를 직접 구축하고 유지보수**합니다. 즉, 사용자와 원본 자료 사이에 "구조화되고 상호 링크된 마크다운 파일들의 집합"이 자리잡는 것입니다. 새 자료를 추가하면, LLM은 그것을 단순히 색인만 하는 것이 아니라 **읽고**, 핵심 정보를 **추출**하고, 기존 위키에 **통합**합니다 — 엔티티 페이지를 갱신하고, 토픽 요약을 수정하고, 새 자료가 기존 주장과 충돌하면 표시하고, 진화하는 종합(synthesis)을 강화하거나 도전합니다. 지식은 한 번 컴파일되고 **계속 최신 상태로 유지**됩니다 — 매 질의마다 다시 도출되는 게 아니라요.

This is the key difference: **the wiki is a persistent, compounding artifact.** The cross-references are already there. The contradictions have already been flagged. The synthesis already reflects everything you've read. The wiki keeps getting richer with every source you add and every question you ask.

이게 핵심 차이입니다: **위키는 영속적이고(persistent) 복리처럼 누적되는(compounding) 산출물**입니다. 상호 참조는 이미 만들어져 있고, 모순은 이미 표시되어 있고, 종합은 이미 사용자가 읽은 모든 것을 반영합니다. 사용자가 새 자료를 추가하고 새 질문을 던질 때마다 위키는 더 풍부해집니다.

You never (or rarely) write the wiki yourself — the LLM writes and maintains all of it. You're in charge of sourcing, exploration, and asking the right questions. The LLM does all the grunt work — the summarizing, cross-referencing, filing, and bookkeeping that makes a knowledge base actually useful over time. In practice, I have the LLM agent open on one side and Obsidian open on the other. The LLM makes edits based on our conversation, and I browse the results in real time — following links, checking the graph view, reading the updated pages. **Obsidian is the IDE; the LLM is the programmer; the wiki is the codebase.**

위키는 (거의) 사용자가 직접 쓰지 않습니다 — LLM이 모두 쓰고 유지합니다. 사용자의 역할은 **자료 큐레이션, 탐색, 좋은 질문 던지기**입니다. LLM은 요약, 상호 참조, 정리, 부기(bookkeeping) 같은 — 지식 베이스를 시간이 지나도 진짜 쓸모 있게 만드는 — 잡일을 모두 합니다. 실제로는 한쪽 화면에 LLM 에이전트, 다른 한쪽에 옵시디언을 띄워 둡니다. 대화 내용에 따라 LLM이 편집을 하면, 사용자는 실시간으로 결과를 둘러봅니다 — 링크를 따라가고, 그래프 뷰를 확인하고, 갱신된 페이지를 읽습니다. **옵시디언은 IDE, LLM은 프로그래머, 위키는 코드베이스**라고 보면 됩니다.

### Where it applies / 어디에 적용되나

This can apply to a lot of different contexts. A few examples:

이 패턴은 다양한 맥락에 적용 가능합니다. 몇 가지 예시:

- **Personal / 개인용**: tracking your own goals, health, psychology, self-improvement — filing journal entries, articles, podcast notes, and building up a structured picture of yourself over time.
  자신의 목표·건강·심리·자기계발을 추적 — 일기, 기사, 팟캐스트 노트를 정리하고, 자기 자신에 대한 구조화된 그림을 시간에 걸쳐 쌓아갑니다.
- **Research / 연구**: going deep on a topic over weeks or months — reading papers, articles, reports, and incrementally building a comprehensive wiki with an evolving thesis.
  한 주제를 몇 주~몇 달에 걸쳐 깊게 파기 — 논문·기사·보고서를 읽으며 진화하는 가설을 가진 종합적인 위키를 점진적으로 구축.
- **Reading a book / 책 읽기**: filing each chapter as you go, building out pages for characters, themes, plot threads, and how they connect. By the end you have a rich companion wiki. Think of fan wikis like [Tolkien Gateway](https://tolkiengateway.net/wiki/Main_Page) — thousands of interlinked pages built by volunteers over years.
  챕터 단위로 정리해 가며, 등장인물·테마·플롯 페이지와 연결을 만듭니다. 다 읽고 나면 풍성한 동반 위키가 남습니다. [톨킨 게이트웨이](https://tolkiengateway.net/wiki/Main_Page) 같은 팬 위키 — 수년에 걸쳐 만든 수천 개의 상호 링크 페이지 — 를 떠올려 보세요. 상호 참조와 유지보수는 LLM이 다 합니다.
- **Business/team / 비즈니스·팀**: an internal wiki maintained by LLMs, fed by Slack threads, meeting transcripts, project documents, customer calls. The wiki stays current because the LLM does the maintenance that no one on the team wants to do.
  슬랙 스레드·회의록·프로젝트 문서·고객 통화로 채워지는 LLM 유지 사내 위키. 팀원 누구도 하기 싫어하는 유지보수를 LLM이 하므로 위키가 항상 최신 상태.
- **Other / 기타**: competitive analysis, due diligence, trip planning, course notes, hobby deep-dives — anything where you're accumulating knowledge over time and want it organized rather than scattered.
  경쟁사 분석, 실사, 여행 계획, 강의 노트, 취미 심층 탐구 — 지식이 쌓이고 정리되어야 하는 모든 작업.

---

## Architecture / 아키텍처

There are three layers:

세 가지 레이어로 구성됩니다:

### Raw sources / 원본 자료

Your curated collection of source documents. Articles, papers, images, data files. These are **immutable** — the LLM reads from them but never modifies them. This is your source of truth.

사용자가 큐레이션한 원본 문서 모음. 기사·논문·이미지·데이터 파일. **불변(immutable)**입니다 — LLM은 읽기만 하고 수정하지 않습니다. 진실의 원천(source of truth).

### The wiki / 위키

A directory of LLM-generated markdown files. Summaries, entity pages, concept pages, comparisons, an overview, a synthesis. The LLM **owns this layer entirely**. It creates pages, updates them when new sources arrive, maintains cross-references, and keeps everything consistent. You read it; the LLM writes it.

LLM이 생성한 마크다운 파일들의 디렉토리. 요약·엔티티·개념 페이지·비교·개요·종합. 이 레이어는 **LLM이 전적으로 소유**합니다. 페이지를 만들고, 새 자료가 들어오면 갱신하고, 상호 참조를 유지하고, 일관성을 지킵니다. 사용자는 읽고, LLM은 씁니다.

### The schema / 스키마

A document (e.g. `CLAUDE.md` for Claude Code or `AGENTS.md` for Codex) that tells the LLM how the wiki is structured, what the conventions are, and what workflows to follow when ingesting sources, answering questions, or maintaining the wiki. This is the **key configuration file** — it's what makes the LLM a disciplined wiki maintainer rather than a generic chatbot. You and the LLM co-evolve this over time as you figure out what works for your domain.

위키가 어떻게 구성되어 있는지, 컨벤션은 뭔지, 자료를 흡수하거나 질문에 답하거나 위키를 유지보수할 때 어떤 워크플로우를 따라야 하는지를 LLM에게 알려주는 문서 (Claude Code의 `CLAUDE.md`, Codex의 `AGENTS.md`). 이게 **핵심 설정 파일**입니다 — LLM을 일반적인 챗봇이 아니라 규율 있는 위키 관리자로 만들어 주는 파일입니다. 사용자와 LLM은 도메인에 맞춰 무엇이 잘 작동하는지 알아가며 이 파일을 같이 진화시켜 갑니다.

---

## Operations / 운영

### Ingest / 흡수

You drop a new source into the raw collection and tell the LLM to process it. An example flow: the LLM reads the source, discusses key takeaways with you, writes a summary page in the wiki, updates the index, updates relevant entity and concept pages across the wiki, and appends an entry to the log. A single source might touch 10–15 wiki pages. Personally I prefer to ingest sources one at a time and stay involved — I read the summaries, check the updates, and guide the LLM on what to emphasize. But you could also batch-ingest many sources at once with less supervision. It's up to you to develop the workflow that fits your style and document it in the schema for future sessions.

원본 자료 모음에 새 파일을 떨어뜨리고 LLM에게 처리하라고 시킵니다. 예시 흐름: LLM이 자료를 읽고, 핵심 시사점을 사용자와 논의하고, 위키에 요약 페이지를 쓰고, 인덱스를 갱신하고, 위키 전체에서 관련 엔티티/개념 페이지를 갱신하고, 로그에 항목을 추가합니다. 자료 하나가 위키 페이지 10~15개를 건드릴 수 있습니다. (원저자는) 자료를 한 번에 하나씩 흡수하면서 적극적으로 관여하는 걸 선호합니다 — 요약을 읽고, 갱신 사항을 확인하고, 무엇을 강조할지 LLM에게 가이드합니다. 하지만 감독을 줄이고 여러 자료를 한꺼번에 일괄 흡수할 수도 있습니다. 자기 스타일에 맞는 워크플로우를 만들어서 스키마에 문서화하면 다음 세션에서도 재사용 가능합니다.

### Query / 질의

You ask questions against the wiki. The LLM searches for relevant pages, reads them, and synthesizes an answer with citations. Answers can take different forms depending on the question — a markdown page, a comparison table, a slide deck (Marp), a chart (matplotlib), a canvas. The important insight: **good answers can be filed back into the wiki as new pages.** A comparison you asked for, an analysis, a connection you discovered — these are valuable and shouldn't disappear into chat history. This way your explorations compound in the knowledge base just like ingested sources do.

위키에 대고 질문합니다. LLM이 관련 페이지를 검색해서 읽고, 인용과 함께 답을 종합합니다. 답은 질문에 따라 다양한 형태가 될 수 있습니다 — 마크다운 페이지, 비교 표, 슬라이드 덱(Marp), 차트(matplotlib), 캔버스. 중요한 통찰: **좋은 답은 새 페이지로 위키에 다시 정리해 넣을 수 있습니다.** 사용자가 요청한 비교, 분석, 새로 발견한 연결 — 이것들은 가치가 있고 채팅 기록 속으로 사라지면 안 됩니다. 이렇게 해야 사용자의 탐색도 흡수된 자료처럼 지식 베이스에 복리로 쌓입니다.

### Lint / 점검

Periodically, ask the LLM to health-check the wiki. Look for: contradictions between pages, stale claims that newer sources have superseded, orphan pages with no inbound links, important concepts mentioned but lacking their own page, missing cross-references, data gaps that could be filled with a web search. The LLM is good at suggesting new questions to investigate and new sources to look for. This keeps the wiki healthy as it grows.

주기적으로 LLM에게 위키 헬스체크를 시킵니다. 확인할 항목: 페이지 간 모순, 새 자료에 의해 폐기된 낡은 주장, 들어오는 링크가 없는 고아 페이지, 자기 페이지가 없는 채로 언급만 되는 중요 개념, 빠진 상호 참조, 웹 검색으로 채울 수 있는 데이터 공백. LLM은 새로 조사할 질문이나 새로 찾을 자료를 제안하는 것도 잘합니다. 이 작업이 위키가 커져도 건강하게 유지되도록 해줍니다.

---

## Indexing and logging / 인덱스와 로그

Two special files help the LLM (and you) navigate the wiki as it grows. They serve different purposes.

위키가 커질 때 LLM과 사용자가 위키를 탐색하는 데 도움을 주는 두 개의 특수 파일이 있습니다. 둘은 목적이 다릅니다.

### `index.md` — content-oriented / 콘텐츠 지향

A catalog of everything in the wiki — each page listed with a link, a one-line summary, and optionally metadata like date or source count. Organized by category (entities, concepts, sources, etc.). The LLM updates it on every ingest. When answering a query, the LLM reads the index first to find relevant pages, then drills into them. This works surprisingly well at moderate scale (~100 sources, ~hundreds of pages) and avoids the need for embedding-based RAG infrastructure.

위키에 있는 모든 것의 카탈로그입니다 — 각 페이지를 링크와 한 줄 요약, 그리고 선택적으로 날짜·자료 수 같은 메타데이터와 함께 나열합니다. 카테고리(엔티티·개념·자료 등)별로 정리합니다. LLM이 매 ingest마다 갱신합니다. 질의에 답할 때 LLM은 인덱스를 먼저 읽고 관련 페이지를 찾은 다음 그 페이지로 들어갑니다. 이 방식은 중간 규모(자료 ~100개, 페이지 수백 개)까지는 놀랍도록 잘 작동하며, 임베딩 기반 RAG 인프라 없이도 충분합니다.

### `log.md` — chronological / 시간순

An append-only record of what happened and when — ingests, queries, lint passes. A useful tip: if each entry starts with a consistent prefix (e.g. `## [2026-04-02] ingest | Article Title`), the log becomes parseable with simple unix tools — `grep "^## \[" log.md | tail -5` gives you the last 5 entries. The log gives you a timeline of the wiki's evolution and helps the LLM understand what's been done recently.

무엇을 언제 했는지에 대한 추가 전용(append-only) 기록입니다 — ingest, query, lint pass. 유용한 팁: 각 항목을 일관된 접두어(예: `## [2026-04-02] ingest | Article Title`)로 시작하면, 로그를 단순한 유닉스 도구로 파싱할 수 있습니다 — `grep "^## \[" log.md | tail -5`로 최근 5개 항목을 확인할 수 있습니다. 로그는 위키의 진화 타임라인을 제공하고, 최근에 무엇이 되었는지 LLM이 파악하는 걸 돕습니다.

---

## Optional: CLI tools / 선택 사항: CLI 도구

At some point you may want to build small tools that help the LLM operate on the wiki more efficiently. A search engine over the wiki pages is the most obvious one — at small scale the index file is enough, but as the wiki grows you want proper search. [qmd](https://github.com/tobi/qmd) is a good option: a local search engine for markdown files with hybrid BM25/vector search and LLM re-ranking, all on-device. It has both a CLI (so the LLM can shell out to it) and an MCP server (so the LLM can use it as a native tool). You could also build something simpler yourself — the LLM can help you vibe-code a naive search script as the need arises.

위키가 커지면 LLM이 더 효율적으로 작업할 수 있도록 작은 도구들을 만들고 싶어질 수 있습니다. 가장 명백한 건 **위키 페이지 검색 엔진**입니다 — 작은 규모에서는 인덱스 파일로 충분하지만, 위키가 커지면 제대로 된 검색이 필요합니다. [qmd](https://github.com/tobi/qmd)가 좋은 옵션입니다: 마크다운 파일에 대한 로컬 검색 엔진으로, BM25/벡터 하이브리드 검색과 LLM 재랭킹을 모두 디바이스에서 처리합니다. CLI(LLM이 셸로 호출 가능)와 MCP 서버(LLM이 네이티브 도구처럼 사용 가능)를 모두 제공합니다. 더 간단한 걸 직접 만들어도 됩니다 — 필요해질 때 LLM이 바이브 코딩으로 단순한 검색 스크립트를 같이 짜줄 수 있습니다.

---

## Tips and tricks / 팁과 트릭

- **Obsidian Web Clipper** is a browser extension that converts web articles to markdown. Very useful for quickly getting sources into your raw collection.
  **Obsidian Web Clipper**는 웹 기사를 마크다운으로 변환해 주는 브라우저 확장입니다. 자료를 빠르게 원본 모음에 넣을 때 매우 유용합니다.

- **Download images locally.** In Obsidian Settings → Files and Links, set "Attachment folder path" to a fixed directory (e.g. `raw/assets/`). Then in Settings → Hotkeys, search for "Download" to find "Download attachments for current file" and bind it to a hotkey (e.g. Ctrl+Shift+D). After clipping an article, hit the hotkey and all images get downloaded to local disk. This is optional but useful — it lets the LLM view and reference images directly instead of relying on URLs that may break. Note that LLMs can't natively read markdown with inline images in one pass — the workaround is to have the LLM read the text first, then view some or all of the referenced images separately to gain additional context. It's a bit clunky but works well enough.
  **이미지 로컬 다운로드.** 옵시디언 설정 → 파일 및 링크에서 "첨부 파일 폴더 경로"를 고정 디렉토리(예: `raw/assets/`)로 설정합니다. 그 다음 설정 → 단축키에서 "Download"를 검색해 "Download attachments for current file"를 단축키(예: Ctrl+Shift+D)에 바인딩합니다. 기사를 클리핑한 뒤 단축키를 누르면 모든 이미지가 로컬 디스크로 저장됩니다. 선택 사항이지만 유용합니다 — 깨질 수 있는 URL 대신 LLM이 이미지를 직접 보고 참조할 수 있게 됩니다. 단, LLM은 인라인 이미지가 있는 마크다운을 한 번에 네이티브로 읽지 못합니다 — 우회법은 텍스트를 먼저 읽고, 참조된 이미지를 따로 보게 해서 추가 컨텍스트를 얻는 것입니다. 약간 투박하지만 충분히 잘 작동합니다.

- **Obsidian's graph view** is the best way to see the shape of your wiki — what's connected to what, which pages are hubs, which are orphans.
  **옵시디언 그래프 뷰**는 위키의 모양을 보는 가장 좋은 방법입니다 — 무엇이 무엇과 연결되어 있는지, 어떤 페이지가 허브인지, 어떤 게 고아인지.

- **Marp** is a markdown-based slide deck format. Obsidian has a plugin for it. Useful for generating presentations directly from wiki content.
  **Marp**는 마크다운 기반 슬라이드 덱 포맷입니다. 옵시디언에 플러그인이 있습니다. 위키 콘텐츠로부터 직접 프레젠테이션을 생성할 때 유용합니다.

- **Dataview** is an Obsidian plugin that runs queries over page frontmatter. If your LLM adds YAML frontmatter to wiki pages (tags, dates, source counts), Dataview can generate dynamic tables and lists.
  **Dataview**는 페이지 frontmatter에 대한 쿼리를 실행하는 옵시디언 플러그인입니다. LLM이 위키 페이지에 YAML frontmatter(태그·날짜·자료 수)를 넣어 주면, Dataview가 동적인 표와 리스트를 만들 수 있습니다.

- **Git.** The wiki is just a git repo of markdown files. You get version history, branching, and collaboration for free.
  **Git.** 위키는 결국 마크다운 파일들의 git 저장소일 뿐입니다. 버전 관리·브랜치·협업이 공짜로 따라옵니다.

---

## Why this works / 왜 이게 잘 작동하는가

The tedious part of maintaining a knowledge base is not the reading or the thinking — it's the **bookkeeping**. Updating cross-references, keeping summaries current, noting when new data contradicts old claims, maintaining consistency across dozens of pages. Humans abandon wikis because the maintenance burden grows faster than the value. LLMs don't get bored, don't forget to update a cross-reference, and can touch 15 files in one pass. The wiki stays maintained because the cost of maintenance is near zero.

지식 베이스 유지의 지겨운 부분은 읽기나 사고가 아니라 **부기(bookkeeping)**입니다. 상호 참조 갱신, 요약 최신화, 새 데이터가 기존 주장과 모순될 때 표시, 수십 개 페이지에 걸쳐 일관성 유지. 인간은 위키를 포기합니다 — 유지보수 부담이 가치 증가보다 빠르게 늘기 때문입니다. LLM은 지치지 않고, 상호 참조 갱신을 잊지 않고, 한 번에 15개 파일을 만질 수 있습니다. 유지보수 비용이 거의 0이기 때문에 위키는 유지됩니다.

The human's job is to curate sources, direct the analysis, ask good questions, and think about what it all means. The LLM's job is everything else.

인간의 일은 자료 큐레이션, 분석 방향 잡기, 좋은 질문 던지기, 그게 다 무엇을 의미하는지 생각하기. LLM의 일은 그 외의 모든 것.

The idea is related in spirit to Vannevar Bush's **Memex (1945)** — a personal, curated knowledge store with associative trails between documents. Bush's vision was closer to this than to what the web became: private, actively curated, with the connections between documents as valuable as the documents themselves. The part he couldn't solve was who does the maintenance. The LLM handles that.

이 아이디어는 정신적으로 **바네바 부시(Vannevar Bush)의 메멕스(Memex, 1945)**와 닮아 있습니다 — 문서들 사이에 연상적 흔적(associative trail)을 가진 개인용·큐레이션된 지식 저장소. 부시의 비전은 웹이 결국 된 모습보다 이쪽에 더 가까웠습니다: 사적이고, 능동적으로 큐레이션되며, 문서 자체만큼이나 문서들 사이의 연결이 가치 있는 것. 그가 풀지 못한 부분은 "유지보수를 누가 하느냐"였습니다. LLM이 그것을 합니다.

---

## Note / 참고

This document is intentionally abstract. It describes the idea, not a specific implementation. The exact directory structure, the schema conventions, the page formats, the tooling — all of that will depend on your domain, your preferences, and your LLM of choice. Everything mentioned above is **optional and modular** — pick what's useful, ignore what isn't. For example: your sources might be text-only, so you don't need image handling at all. Your wiki might be small enough that the index file is all you need, no search engine required. You might not care about slide decks and just want markdown pages. You might want a completely different set of output formats. The right way to use this is to share it with your LLM agent and work together to instantiate a version that fits your needs. The document's only job is to communicate the pattern. Your LLM can figure out the rest.

이 문서는 의도적으로 추상적입니다. 구체적 구현이 아니라 아이디어를 기술합니다. 정확한 디렉토리 구조·스키마 컨벤션·페이지 포맷·도구 — 이 모든 건 도메인·선호·사용하는 LLM에 따라 달라집니다. 위에서 언급된 모든 것은 **선택적이고 모듈식**입니다 — 쓸모 있는 건 가져가고, 아닌 건 무시하세요. 예를 들어 자료가 텍스트뿐이면 이미지 처리는 필요 없습니다. 위키가 작으면 인덱스 파일만으로 충분하고 검색 엔진이 필요 없을 수도 있습니다. 슬라이드 덱은 신경 안 쓰고 마크다운 페이지만 원할 수도 있습니다. 완전히 다른 출력 형태를 원할 수도 있습니다. 올바른 사용법은 이 문서를 본인의 LLM 에이전트에게 공유하고, 함께 본인 필요에 맞춘 버전을 만들어 가는 것입니다. 이 문서의 유일한 역할은 패턴을 전달하는 것이고, 나머지는 LLM이 알아서 해결해 줍니다.
