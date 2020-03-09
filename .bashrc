source ~/.git-completion.bash
# added by travis gem
[ -f /Users/Jamie/.travis/travis.sh ] && source /Users/Jamie/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=/usr/local/Cellar/vim/8.2.0250_1/bin/:$PATH
export PATH=/usr/local/Cellar/python/3.7.6_1/bin/:$PATH
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc"
alias sb="source ~/.bashrc"


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GTD commands
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

intouch () {

  pushd ~/.gtd/in >/dev/null
  touch "$@"
  popd >/dev/null
}

inrm () {
  pushd ~/.gtd/in >/dev/null
  rm "$@"
  popd >/dev/null
}

_inrm () {
  IFS=$'\n' tmp=( $(compgen -W "$(ls -1 ~/.gtd/in)" -- "${COMP_WORDS[$COMP_CWORD]}" ) )
  COMPREPLY=()
  for file in "${tmp[@]}"
  do
    COMPREPLY+=( "$(echo "$file" | sed 's/ /\\ /')" )
  done
}
complete -o default -F _inrm inrm

alias inls="ls -1 ~/.gtd/in/"
