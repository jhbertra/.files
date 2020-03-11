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

inadd () {
  pushd ~/.gtd/in >/dev/null
  touch "$@"
  git add "$@"
  git commit -m "intouch $@"
  popd >/dev/null
}

inrm () {
  pushd ~/.gtd/in >/dev/null
  git rm "$@"
  git commit -m "inrm $@"
  popd >/dev/null
}

invim () {
  pushd ~/.gtd/in >/dev/null
  vim "$@"
  git add "$@"
  git commit -m "invim $@"
  popd >/dev/null
}

inopen () {
  pushd ~/.gtd/in >/dev/null
  open "$@"
  git add "$@"
  git commit -m "inopen $@"
  popd >/dev/null
}

inmv () {
  pushd ~/.gtd/in >/dev/null
  git mv "$@"
  git commit -m "inmv $@"
  popd >/dev/null
}

_inls () {
  IFS=$'\n' tmp=( $(compgen -W "$(ls -1 ~/.gtd/in)" -- "${COMP_WORDS[$COMP_CWORD]}" ) )
  COMPREPLY=()
  for file in "${tmp[@]}"
  do
    COMPREPLY+=( "$(echo "$file" | sed 's/ /\\ /g')" )
  done
}

complete -o default -F _inls inmv
complete -o default -F _inls inopen
complete -o default -F _inls inrm
complete -o default -F _inls invim

alias inls="ls -1 ~/.gtd/in/"
