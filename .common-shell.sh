
alias e=$EDITOR
alias edt=$EDITOR
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
alias dockerloginecr='aws ecr get-login-password | docker login -u AWS --password-stdin $ECRURL'
alias cp='cp --reflink=auto'

function rgfzf() {
    rg -i $1 . | fzf ${@:2}
}

set -o emacs

function bell() {
    terminal-notifier -message "${1:-"Done"}" -title "Done"
}

#export PATH="$PATH:/home/amirul/.local/bin"
#export DOTNET_ROOT=$HOME/dotnet
#export PATH=$PATH:$HOME/dotnet
#export PATH=$PATH:$HOME/go/bin
