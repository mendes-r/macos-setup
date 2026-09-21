# Git-aware prompt (vcs_info), bundled by macos-setup.
# Only appended if your .zshrc doesn't already configure a prompt/vcs_info.
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%~ %F{green}${vcs_info_msg_0_}%f> '
