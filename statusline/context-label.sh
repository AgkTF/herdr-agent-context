# herdr-agent-context: publish this session's context use to Herdr as a terminal label.
# Paste into your Claude Code status-line script, after `input=$(cat)`.
# It sets usage.ctx=<used>/<size> on this terminal, only when the value changes.
# The agents-context mod reads the label. Remove this block to undo.
if [ -n "$HC_TERMINAL_ID" ] && command -v hc >/dev/null 2>&1; then
  ctx_used=$(printf '%s' "$input" | jq -r '.context_window.total_input_tokens // empty')
  ctx_size=$(printf '%s' "$input" | jq -r '.context_window.context_window_size // empty')
  if [ -n "$ctx_used" ] && [ -n "$ctx_size" ]; then
    ctx_v="$ctx_used/$ctx_size"
    ctx_f="${XDG_RUNTIME_DIR:-/tmp}/herdr-agent-context.$HC_TERMINAL_ID"
    if [ "$(cat "$ctx_f" 2>/dev/null)" != "$ctx_v" ]; then
      printf '%s' "$ctx_v" > "$ctx_f"
      (hc label "$HC_TERMINAL_ID" "usage.ctx=$ctx_v" >/dev/null 2>&1 &)
    fi
  fi
fi
# end herdr-agent-context
