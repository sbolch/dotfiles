---
name: commit-workflow
description: Draft, suggest, create, or amend Git commits using the user's emoji message conventions, repository instructions, staged scope, verified co-author or email-free assistance attribution, and effective Git hooks/signing settings. A message request alone does not authorize a commit; this skill does not authorize pushing, rebasing, or branch cleanup.
---

# Project-aware commits

Use the actual repository and requested changes as evidence. Repository-specific instructions and explicit user directions take precedence over these global defaults.

## Establish scope and conventions

- Locate the repository/worktree and read applicable `AGENTS.md` instructions. Read its `.gitmessage` when present, the effective `commit.template` if configured, and a small sample of relevant recent subjects. Do not assume every repository uses the same language or format.
- Inspect effective repository Git settings rather than assuming global values win: `git config --show-origin --get <key>` for `core.hooksPath`, `commit.template`, `commit.gpgSign`, `gpg.format`, and relevant `ollamaCommit.*` settings. Keep identity and signing configuration intact; never read private key contents.
- Check `git status --short`, staged names/stat, then the staged diff using `--cached --no-ext-diff --no-textconv`, scoped to user-listed paths when supplied. Do not substitute unstaged changes for missing staged changes or claim unrelated work belongs to the requested commit. Read enough of large or binary changes to substantiate the message; flag a coverage gap instead of inventing it.
- For an amend, inspect the existing commit message and changes as well as the index. Describe the full resulting commit, including retained original changes, not only the latest staged delta.

## Draft the message

Default to English, an emoji, a space, and a concise imperative subject describing the main change and its purpose. Match a contrary explicit project convention when applicable.

Choose the main type rather than listing every file: ✨ feature, 🐛 fix, 📝 documentation, ♻️ refactor, 🔧 configuration, ✅ tests, ⚡ performance, 🚀 delivery, or 🔒 security. Use a short body only when the rationale, behavior, migration, or tradeoff needs explanation. Do not invent test results or claim a runtime outcome from lint/build checks alone. Avoid imposing Conventional Commit prefixes or arbitrary length limits absent a repository requirement.

For a message-only request, return one ready-to-use suggestion with necessary trailers and no extra narration unless a scope ambiguity prevents an accurate suggestion. Do not stage or commit. If the index is empty, state that rather than describing unstaged work as staged. When the user explicitly asks for unstaged changes, inspect that requested scope and label it accurately.

## Attribute actual contributions

Preserve applicable human co-author trailers. Add one `Co-authored-by` trailer per AI agent that actually contributed to the committed changes when its attribution email is verified or documented. Use:

`Co-authored-by: Agent name (model/version) <email>`

Repository instructions or matching Git-history trailers may document an agent's email; do not invent an email or infer a GitHub account relationship from it. Current model/version must come from reliable current runtime information, not prior commits. Omit the parentheses when that detail is unavailable. When a contributing agent's email cannot be established, use an email-free assistance trailer instead:

`Assisted-by: Agent name (model/version)`

If the model/version is unavailable, use `Assisted-by: Agent name`. Do not omit a known contributing agent solely because its email is unavailable, and never fabricate an email to produce a co-author trailer. Use one attribution trailer per agent: `Co-authored-by` with an established email, otherwise `Assisted-by`. Preserve applicable existing assistance trailers when amending. Drafting a message alone does not establish authorship of the code. Separate the trailer block with a blank line and avoid duplicates.

## Create only when requested

If the user requested a commit, stage only the intended paths or hunks that are not already staged; preserve unrelated staged/unstaged work and partial staging. If existing unrelated staged changes prevent the requested boundary, resolve that boundary with the user rather than silently committing them or changing their index selections. Do not run broad `git add .` as a shortcut. Run relevant required checks before committing and describe their actual scope.

Inspect the effective hooks before predicting the final message. On this workstation the global hooks are tracked under `~/dotfiles/git/ollama-hooks`; the current `commit-msg` dispatcher can call local Ollama and then a repository-local hook. Its generator may rewrite a supplied message. The inspected implementation recognizes AI `Co-authored-by` trailers for its skip rule; do not assume it recognizes `Assisted-by` as equivalent. It preserves parsed trailers when generating a new message, so verify the resulting subject and attribution after an authorized commit. Inspect the current implementation/configuration rather than assuming a proposed subject will survive unchanged. Do not add false attribution, disable generation, skip hooks, or turn off signing to force a message through.

Use a properly quoted message file with real newlines for multiline bodies/trailers (`git commit -F <file>`), respecting the user's commit scope. Do not expose secrets in command arguments. A commit failure is not permission to bypass checks, signing, or hooks; inspect its cause.

After an authorized commit/amend, verify the resulting commit message, changed paths, and working-tree/index state. Check signatures if signing is required, distinguishing successful verification from unavailable verification tooling. Report the actual commit ID and any hook-produced message change. Do not automatically amend, retry a successful commit, push, rebase, merge, or delete branches merely to tidy the result.
