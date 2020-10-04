
alias e=$EDITOR
alias edtzsh="edt ~/.zshrc && source ~/.zshrc"
alias edtcommon="edt ~/.common-shell.sh && source ~/.zshrc"
alias edttmux="edt ~/.tmux.conf"
alias gs="git status"
alias gd="git diff"
alias gdh="git diff HEAD~"
alias gca="git commit all"
alias gcaa="git commit --amend all"
alias tls="tmux ls"
alias ta="tmux a -t"
alias tn="tmux new -s"
alias ffzf="find -f . | fzf"

function rgfzf() {
    rg -i $1 . | fzf ${@:2}
}
