#!/usr/bin/env bash
# sync-agent-configs.sh
# Mirror every CLAUDE.md to AGENTS.md and GEMINI.md at the same level.
# Run after editing any CLAUDE.md.
#
# 모든 CLAUDE.md를 같은 레벨의 AGENTS.md·GEMINI.md로 미러링.
# CLAUDE.md 수정 후 실행.
#
# Usage / 사용법:
#   bash scripts/sync-agent-configs.sh                  # sync from CWD / 현재 폴더 기준
#   bash scripts/sync-agent-configs.sh /path/to/vault   # sync from path / 지정 경로

set -euo pipefail

ROOT="${1:-$(pwd)}"
cd "$ROOT"

VARIANTS=(AGENTS.md GEMINI.md)
EXCLUDES=(-not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/.obsidian/*")

sources=0
copies=0

while IFS= read -r -d '' claude; do
  dir="$(dirname "$claude")"
  sources=$((sources + 1))
  for variant in "${VARIANTS[@]}"; do
    target="$dir/$variant"
    # Preserve first-line banner indicating auto-generated mirror
    {
      printf '<!-- AUTO-GENERATED from CLAUDE.md by scripts/sync-agent-configs.sh — do not edit / CLAUDE.md에서 자동 생성. 직접 수정 금지 -->\n'
      cat "$claude"
    } > "$target"
    copies=$((copies + 1))
  done
done < <(find . -name "CLAUDE.md" "${EXCLUDES[@]}" -print0)

echo "✓ Synced $copies mirror(s) from $sources CLAUDE.md source(s) under $ROOT"
echo "  Variants: ${VARIANTS[*]}"
