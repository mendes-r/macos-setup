# macos-setup

Bootstraps a macOS machine with:

- **Homebrew** (installed if missing) + packages from `Brewfile` (neovim, tmux, git, fzf, bat, tree)
- **Neovim** — a LazyVim-based config (`files/nvim`), symlinked to `~/.config/nvim`
- **tmux** — a config (`files/tmux.conf`) with vi-style copy mode, mouse support, and a minimal status bar, symlinked to `~/.tmux.conf`
- **zsh** — a curated alias set and a git-aware prompt (branch name shown via `vcs_info`), merged into `~/.zshrc`
- **git** — a set of common aliases (`s`, `co`, `cob`, `cm`, `hist`, ...) and sane defaults (`core.editor=nvim`, `pull.rebase=false`), applied via `git config --global`

## Usage

```sh
./install.sh
```

Re-run it any time — every step is idempotent.

## Non-destructive by design

Nothing here ever overwrites or deletes an existing setting:

- `~/.tmux.conf` and `~/.config/nvim` are only **symlinked** if they don't already exist. If you already have one, it's left untouched and a note is printed pointing at the bundled version in `files/` in case you want to merge manually.
- `~/.zshrc` is only ever **appended to**, inside a marked block (`# >>> macos-setup: ... >>>`). Each alias in `files/aliases.zsh` is checked against your existing file first — if you already alias `ll`, `vi`, etc., that one is skipped and your version wins. Same for the prompt: if `vcs_info`, `starship init`, or `PROMPT_SUBST` already appears anywhere in your `.zshrc`, the bundled prompt block is skipped entirely.
- Git aliases and config keys are only set with `git config --global` when `git config --global --get <key>` comes back empty — an existing alias or setting is never redefined.

## Layout

```
install.sh          orchestrator — runs the steps below in order
lib/                one script per tool, plus lib/common.sh (shared helpers)
files/               the actual bundled configs (nvim, tmux.conf, aliases.zsh, prompt.zsh, git-aliases.conf)
Brewfile             packages installed via `brew bundle`
```

To change what gets installed, edit the files under `files/` (and `Brewfile` for packages) — `install.sh` always reads from there, so your changes take effect on the next run.
