# herdr-agent-context

A Herdr app mod. Each row in the agents list shows the context size of that agent's
Claude Code session, also for nested `hc` crewmates. See [RECIPE.md](RECIPE.md) for the full
description, and [preview.png](preview.png).

## Install

1. Link the mod into Herdr:

   ```sh
   ln -s "$PWD/mods/agents-context" ~/.config/herdr-app/mods/agents-context
   herdr-app check ~/.config/herdr-app/mods/agents-context
   ```

   Herdr loads a symlinked mod folder. Herdr writes `gpui-kit.d.ts` and `jsconfig.json` into
   the folder. Git ignores them.

2. Make a layout that uses the mod:

   ```sh
   herdr-app do layout.clone '{"name":"main","as":"main-context"}'
   ```

   In `~/.config/herdr-app/layouts/main-context.json`, change the `agents` block to
   `"content": { "mod": "agents-context" }`. Then run
   `herdr-app do layout.switch '{"name":"main-context"}'`.

3. Paste `statusline/context-label.sh` into your Claude Code status-line script, after
   `input=$(cat)`. It needs `jq` and `hc`. If you have no status-line script, make one that
   starts with `input=$(cat)`, and add it to `~/.claude/settings.json`:

   ```json
   { "statusLine": { "type": "command", "command": "bash ~/.claude/statusline-command.sh" } }
   ```

## After a Herdr update

Clones never update. When Herdr ships a new `agents` mod, clone it again and apply the
`CONTEXT` changes from [RECIPE.md](RECIPE.md).

## Remove

Switch to another layout (`ctrl-shift-l`). Delete the symlink, the layout file, and the status-line
block. Live terminals keep their last label. To remove it: `hc label <terminal> usage.ctx=`.

## License

Apache License 2.0, see [LICENSE](LICENSE). `mods/agents-context/main.js` is changed from the
`agents` mod that ships with the Herdr app (version 0.1.13). The changes are marked `CONTEXT`.
