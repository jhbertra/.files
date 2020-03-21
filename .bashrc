source ~/.git-completion.bash
source ~/.hledger-completion.bash
# added by travis gem
[ -f /Users/Jamie/.travis/travis.sh ] && source /Users/Jamie/.travis/travis.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=/usr/local/Cellar/vim/8.2.0250_1/bin/:$PATH
export PATH=/usr/local/Cellar/python/3.7.6_1/bin/:$PATH
alias vimrc="vim ~/.vimrc"
alias bashrc="vim ~/.bashrc"
alias sb="source ~/.bashrc"
export LEDGER_FILE=~/finances/default.journal

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GTD commands
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

inadd () {
  pushd ~/.gtd/in >/dev/null
  touch "$@"
  git add "$@"
  git commit -m "in: add: $@"
  popd >/dev/null
}

inrm () {
  pushd ~/.gtd/in >/dev/null
  git rm "$@"
  git commit -m "in: rm: $@"
  popd >/dev/null
}

invim () {
  pushd ~/.gtd/in >/dev/null
  vim "$@"
  git add "$@"
  git commit -m "in: vim: $@"
  popd >/dev/null
}

inopen () {
  pushd ~/.gtd/in >/dev/null
  open "$@"
  git add "$@"
  git commit -m "in: open: $@"
  popd >/dev/null
}

inmv () {
  pushd ~/.gtd/in >/dev/null
  git mv "$@"
  git commit -m "in: mv: $1 -> $2"
  popd >/dev/null
}

input () {
  cp "$1" ~/.gtd/in
  pushd ~/.gtd/in >/dev/null
  git add .
  git commit -m "in: put: $1"
  popd >/dev/null
}

inget () {
  cp ~/.gtd/in/$1 .
}

alias inhead="ls -t .gtd/in | head -n 1"

inac () {
  item=$(inhead)
  pushd ~/.gtd >/dev/null
  bumpVersion
  newFile="${1:-$item}"
  newPath="next-actions/$nextVersion-$newFile.md"
  touch "$newPath"
  echo "---" >> "$newPath"
  echo "orig: $item" >> "$newPath"
  echo "---" >> "$newPath"
  echo "" >> "$newPath"
  echo "# $newFile" >> "$newPath"
  vim "$newPath"
  git add "$newPath"
  git rm "in/$item"
  git commit -m "in: ac: $newFile"
  popd >/dev/null
}

inpr () {
  item=$(inhead)
  pushd ~/.gtd >/dev/null
  bumpVersion
  newFile="${1:-$item}"
  newPath="projects/$nextVersion-$newFile.md"
  touch "$newPath"
  echo "---" >> "$newPath"
  echo "orig: $item" >> "$newPath"
  echo "---" >> "$newPath"
  echo "" >> "$newPath"
  echo "# $newFile" >> "$newPath"
  echo "" >> "$newPath"
  echo "## Next Actions" >> "$newPath"
  echo "" >> "$newPath"
  vim "$newPath"
  git add "$newPath"
  git rm "in/$item"
  git commit -m "in: pr: $newFile"
  popd >/dev/null
}

insm () {
  item=$(inhead)
  pushd ~/.gtd >/dev/null
  bumpVersion
  newFile="${1:-$item}"
  newpath="someday-maybe/$nextVersion-$newfile.md"
  touch "$newpath"
  echo "---" >> "$newpath"
  echo "orig: $item" >> "$newpath"
  echo "---" >> "$newpath"
  echo "" >> "$newpath"
  echo "# $newfile" >> "$newpath"
  vim "$newpath"
  git add "$newpath"
  git rm "in/$item"
  git commit -m "in: sm: $newfile"
  popd >/dev/null
}

infile () {
  item=$(inhead)
  dir=$1
  pushd ~/.gtd/reference >/dev/null
  [ ! -d $dir ] && mkdir $dir
  git mv "../in/$item" $dir
  git commit -m "in: file: $item $1"
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

bumpVersion () {
  pushd ~/.gtd >/dev/null
  nextVersion=$(cat version)
  echo $(( nextVersion + 1 )) > version
  git add version
  popd >/dev/null
}

complete -o default -F _inls inget
complete -o default -F _inls inmv
complete -o default -F _inls inopen
complete -o default -F _inls inrm
complete -o default -F _inls invim

acadd () {
  pushd ~/.gtd/next-actions >/dev/null
  echo "# $1" >> "$1.md"
  vim "$1.md"
  git add "$1.md"
  git commit -m "next-actions: add $1"
  popd >/dev/null
}

pradd () {
  pushd ~/.gtd/projects >/dev/null
  echo "# $1" >> "$1.md"
  echo "" >> "$1.md"
  echo "## Next Actions" >> "$1.md"
  echo "" >> "$1.md"
  vim "$1.md"
  git add "$1.md"
  git commit -m "projects: add $1"
  popd >/dev/null
}

alias inls="ls -1tr ~/.gtd/in/"
alias prls="ls -1tr ~/.gtd/projects/"
alias acls="ls -1tr ~/.gtd/next-actions/"
alias smls="ls -1tr ~/.gtd/someday-maybe/"
