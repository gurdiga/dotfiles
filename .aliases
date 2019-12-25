# vim: filetype=sh

alias gs='git status --short --branch'
alias gsh='git show'
alias gd='git diff'
alias gds='git diff --staged'
alias gdn='git diff --stat'
alias ga='git add --all'
alias grh='git reset --hard'
alias gc='git commit --verbose'
alias gch='git checkout'
alias gl='git log --abbrev-commit'
alias gln='git log --abbrev-commit --stat'
alias glg='git log --graph --decorate --source --all --oneline'
alias gl1='git log --abbrev-commit --format=oneline'
alias grb='git rebase'
alias push='git push'
alias gcp='git cherry-pick'
alias grv='git remote --verbose'
alias v='vimp'
alias m='make'
alias less='less -R'
alias j='jobs -l'
alias l='ls -1hAF --group-directories-first'
alias ll='ls --full-time --time-style="+%Y-%m-%d %H:%M:%S" --group-directories-first -hlAF'
alias files='cut -d: -f1 | uniq | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias encrypt='openssl enc -aes-256-cbc -e'
alias decrypt='openssl aes-256-cbc -d'
alias node='env NODE_NO_READLINE=1 rlwrap node'
alias www="~/src/nginx-server/nginx-server.py"
alias wwws="simplehttp2server"
alias stripcolor='sed -r "s:\x1B\[[0-9;]*[mK]::g"'
alias striptags='sed "s/<[^>]*>//g"'
alias rnd="tr -dc '(-~' < /dev/urandom | head -c${1:-37} | pbcopy"
alias tree="tree -N"
alias calc='bc <<<'
alias be="bundle exec"
alias ports="sudo lsof -PiTCP -sTCP:LISTEN"
alias ip="ifconfig | grep -Po '(?<=inet )\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | grep -v '127.0.0.1'"
alias pbwrap="pbpaste | fold -w 72 -s | pbcopy"
alias rehash="hash -r"
alias bytes="numfmt --to=iec-i --suffix=B --padding=7"
alias k9="kill -9"
alias yt="yarn test"
alias flushdns="sudo killall -HUP mDNSResponder"

# account for typos
alias cd-="cd -"
