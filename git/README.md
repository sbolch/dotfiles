# Ollama commit messages

The repository's `.gitconfig` points `core.hooksPath` directly to
`~/dotfiles/git/ollama-hooks`. Use that config as your global Git config through
your existing dotfiles setup; no installer or copying is needed. Changes to the
hooks take effect immediately. If you keep this checkout elsewhere, update the
path in `.gitconfig`.

When `ollama` or `python3` is not on PATH, message generation is silently skipped
and existing repository hooks still run. When available, generation uses Ollama
at `127.0.0.1:11434` with the configured model installed (`qwen3.5:4b` by default).

```sh
git commit -m "fix"
git commit --allow-empty-message -m ""
```

The `commit-msg` hook replaces proposed messages without a recognized AI
`Co-authored-by` trailer using the staged diff, root `AGENTS.md`, and `.gitmessage`.
It preserves existing trailers and does not invent AI attribution. Known AI names
include Codex, Claude, Copilot, Cursor, Gemini, ChatGPT, OpenAI, Ollama, Aider,
GPT versions, Qwen, Gemma, and DeepSeek. Recognition is a name match, not identity
verification. Human-only co-author trailers do not skip generation.

On generation failure or a 15-second timeout, the original message remains.
Git requires `--allow-empty-message` to accept an empty fallback. An empty diff
gets an empty-commit summary; `--allow-empty` is still required to commit without
changes. The hook compares the index to HEAD; it does not reconstruct the full
amended commit when using `--amend`.

Small prompts use a 4K context. Larger prompts step through 6K, 8K, 12K, 16K,
24K, and 32K using a conservative UTF-8 byte estimate plus 512 tokens of reserve.
The diff is capped at 18,000 characters, with separate caps on instructions,
file lists, and the proposed message. Generation is capped at 256 tokens; the
model stays warm for 30 minutes when Ollama can keep it resident.

Configuration accepts global or repository-local overrides:

```sh
git config --global ollamaCommit.model qwen3.5:4b
git config --global ollamaCommit.timeout 15
# Optional Python regular expression for recognizing AI co-author identities:
git config --global ollamaCommit.aiPattern '(?i)\b(codex|claude|copilot)\b'
```

Dispatcher hooks preserve executable repository hooks in the common Git
directory's `hooks/` folder, including linked worktrees. The repository
`commit-msg` hook runs after generation and may still reject the commit.
Repository-local `core.hooksPath` settings override the global installation.
`git commit --no-verify` skips message generation.

To disable, remove `core.hooksPath` from your active Git config. Restore any
separately managed hooks configuration as needed.
