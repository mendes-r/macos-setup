# Default aliases bundled by macos-setup.
# The installer only adds the ones you don't already define — see lib/zsh.sh.
alias src='source ~/.zshrc'
alias cp='cp -i'
alias ll='ls -alF'
alias l='ls -CF'
alias la="ls -alh"
alias l.="ls -d .*"
alias dev='cd ~/Developer'
alias vim="nvim"
alias vi="nvim"
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias ports='lsof -i -P -n | grep LISTEN | grep -v grep'
alias t="tree --du -h -L"
alias k="kubectl"
