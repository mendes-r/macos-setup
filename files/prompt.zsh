# Git-aware prompt (vcs_info), bundled by macos-setup.
# Only appended if your .zshrc doesn't already configure a prompt/vcs_info.
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{yellow}●%f'
zstyle ':vcs_info:*' stagedstr ' %F{green}+%f'
zstyle ':vcs_info:git:*' formats ' %%b%F{white}on%f%%B %F{magenta} %b%f%c%u'
zstyle ':vcs_info:git:*' actionformats ' %%b%F{white}on%f%%B %F{magenta} %b%f %F{red}(%a)%f%c%u'

setopt PROMPT_SUBST
[[ -n $SSH_CONNECTION ]] && prompt_host='%F{yellow}%m%f '
PROMPT='%B${prompt_host}%F{117}%3~%f${vcs_info_msg_0_} %(?.%F{green}.%F{red})❯%f%b '
RPROMPT='%(?..%F{red}✘ %?%f )%F{242}%*%f'
