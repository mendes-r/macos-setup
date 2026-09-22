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

## Non-destructive by design (zsh & git only)

- `~/.zshrc` is only ever **appended to**, inside a marked block (`# >>> macos-setup: ... >>>`). Each alias in `files/aliases.zsh` is checked against your existing file first — if you already alias `ll`, `vi`, etc., that one is skipped and your version wins. Same for the prompt: if `vcs_info`, `starship init`, or `PROMPT_SUBST` already appears anywhere in your `.zshrc`, the bundled prompt block is skipped entirely.
- Git aliases and config keys are only set with `git config --global` when `git config --global --get <key>` comes back empty — an existing alias or setting is never redefined.

## tmux & nvim are always replaced

`~/.tmux.conf` and `~/.config/nvim` are **symlinked to the bundled configs on every run**, overwriting whatever was there before. If a real file/directory (not already our symlink) exists at that path, it's first backed up to `<path>.macos-setup.bak.<timestamp>` before being replaced — so nothing is lost, but the bundled config always wins.

## Layout

```
install.sh          orchestrator — runs the steps below in order
lib/                one script per tool, plus lib/common.sh (shared helpers)
files/               the actual bundled configs (nvim, tmux.conf, aliases.zsh, prompt.zsh, git-aliases.conf)
Brewfile             packages installed via `brew bundle`
```

To change what gets installed, edit the files under `files/` (and `Brewfile` for packages) — `install.sh` always reads from there, so your changes take effect on the next run.
