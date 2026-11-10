A collection of config files I use.

## Shared agent skills

`agents/skills/` contains the global `context-focus`, `context-checkpoint`, and
`commit-workflow` skills. The last includes `Co-authored-by` for established
agent emails and `Assisted-by` when no attribution email is available.

Use one shared source through `~/.agents/skills/<name>`. For a fresh setup:

```sh
mkdir -p ~/.agents/skills
for skill in context-focus context-checkpoint commit-workflow; do
  ln -s "$HOME/dotfiles/agents/skills/$skill" "$HOME/.agents/skills/$skill"
done
```

Preserve any existing skill directories before linking them; the commands above
do not replace existing entries. Adjust the checkout path if it is not
`~/dotfiles`. OpenCode can read `~/.agents/skills` directly (including Air through
OpenCode ACP). Codex and OpenClaw compatibility links can point from
`~/.codex/skills/<name>` and `~/.openclaw/skills/<name>` to the matching
`~/.agents/skills/<name>`. Skill UI metadata stays in each `agents/openai.yaml`.
