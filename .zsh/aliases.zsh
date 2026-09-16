# On OS X, use mdfind -name instead of locate
if [[ `uname` == "Darwin" ]]; then
  alias locate="/usr/bin/mdfind -name $@ 2> >(grep --invert-match ' \[UserQueryParser\] ' >&2)"
  alias ldd='otool -L'
fi

# brew install bat difftastic eza zoxide
[[ ! `command -v bat` ]] || alias cat="bat -pp"  # it's bat in brew and batcat on linux
[[ ! `command -v batcat` ]] || alias cat="batcat -pp"
[[ ! `command -v difft` ]] || alias diff="difft"
[[ ! `command -v eza` ]] || alias l="eza --all --header --links --time-style long-iso --long --sort=modified --git"
[[ ! `command -v zoxide` ]] || alias cd="z"

# I type ls -lart all the time out of habit
[[ ! `command -v eza` ]] || unalias ls
if command -v eza &>/dev/null; then
  ls() {
    if [[ "$*" == "-lart" ]]; then
      command eza -la --sort=newest
    else
      command eza "$@"
    fi
  }
fi

alias calc='python3 -i -c "from math import *"'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

unalias du 2>/dev/null

h() {
  history 0 | grep -i $1
}

sc() {
  openssl s_client -connect $1:443 -servername $1 "${@:2}"
}

headers() {
  if [[ `command -v bat` ]]
  then
    curl -s -o /dev/null -D - "$@" | tail -n +2 | sort --ignore-case | bat -pp -l http --color=always | grep -v '^\s*$'
  else
    curl -s -o /dev/null -D - "$@" | grep -v '^\s*$' | tail -n +2 | sort --ignore-case
  fi
}

# pretty sudo prompt
read -r -d '' SUDOPROMPT << EOM
🌺🌳🌸🌷🌷🌸🌻🌷🌷🌸🌸🌸🌸🌷🌼🌷🌳🌺🌼🌺🌸🌻🌼🌼🌳🌳🌼🌺🌻🌷🐛🌷🌼🌻🌳🌸🌷🌷🌻🌸
🌸🦉🌻🌸🌳🌷🌸🌷🌸🌳🌸🌻🌳🐌🌻🌷🌷🌼🌻🌺🌺🌻🌼🌻🌻🌼🌺🌻🌳🌼🌳🌺🌳🌷🌻🌼🌷🌼🌻🌸
🌳🌸🌻🌺🌻🌳🌺🌺🌻🌺🌸🌻🌷🌷🌼🌻🌺🌼🌻🌻🌷🌳🌻🌸🌳🌷🌻🌳🌳🌳🌳🌼🌳🌳🌺🌷🌳🌺🌳🌺
🦉🌸🌻🌺🌺🌳🌸🌸🌼🌻🌺🌼🌷🌸🌳🌼🌺🌸🌺🌷🌻🌷🌺🌺🌳🌷🌷🐰🌸🌻🌳🌸🌼🌷🌼🌳🌷🐹🌼🌺
🌷🌳🌻🌸🌸🌼🐰🌷🌺🌷🌺🌻🌷🌸🌺🌻🌳🌻🌷🌻🌻🌺🌸🌸🌺🌻🌸🌻🌳🌳🌻🐦🌻🌼🌼🌻🌻🌺🌳🐰
🌼🐦🌻🌳🌸🌸🌳🌷🌺🌼🌳🌷🌸🌻🌼🌻🐛🌻🌼🌷🌺🌼🌺🌸🌺🦔🌷🌸🌷🌻🌻🌺🌼🌷🐌🌸🌷🌼🌸🐹
🌸🌳🌻🌼🌻🌳🌸🌷🌺🌷🌷🌼🌻🌷🌻🌺🌼🌼🌳🌸🌻🌻🌸🌼🌼🌸🌳🌺🌻🌻🌳🌺🌷🐰🌻🌼🐹🌷🌷🌳
🌼🌷🌻🌸🌼🌳🌻🌻🌳🌷🌼🌻🌺🌺🌺🌺🌺🌳🌻🌼🌷🌸🌸🌻🌺🌻🌳🌸🌷🌺🌺🌼🌸🌺🌻🌻🌷🌸🌻🌷
🌼🌳🌷🌳🌸🌺🌻🌳                                              🌺🌸🌻🐢🌺🌳🌻🌺🌼
🌷🌷🌺🌳🌼🌸🌻🌸     please enter ur password, cutie pie      🌷🌺🌼🌷🌻🌺🌼🌷🌺
🌺🌺🌻🌼🌻🌻🌷🌻                                              🌼🌷🌸🌷🌺🌷🌸🌳🌸
🌳🌼🌼🌼🌻🌺🌺🌺🌼🌺🌼🌻🌺🦉🌺🌸🌸🌳🌳🌳🌷🌸🌺🌷🌼🌼🌺🐛🌷🌸🌸🌺🌻🌸🌺🌺🌷🌷🌻🌺
🌳🌳🌷🌷🐢🌳🌼🌺🌼🌻🌺🌼🌷🌻🌸🌻🌺🌷🌳🌺🌻🌺🌼🌷🌷🌳🌺🌸🌸🌻🌷🌷🌳🌳🌻🌸🌻🌼🌼🌷
🌼🌸🌳🌻🌻🌳🌼🌻🌸🌻🌸🌷🌺🌷🌳🌻🌼🐌🌼🌳🌺🌷🌷🌼🌷🌷🦔🌻🌷🌸🌼🌷🌼🌻🌷🌷🌺🌻🌷🌷
🌸🌻🌷🌷🦉🌻🌻🌼🌺🌻🌳🌻🌸🌷🌷🌻🌳🌻🌺🌺🌼🌷🌳🌼🌷🌸🌼🌻🌻🌷🌺🌷🌻🌷🌷🌼🌻🌷🌺🌺
🌳🌺🌷🌼🌻🌺🌸🌺🌳🌻🌸🐣🌻🌼🌻🌷🌸🌼🌺🌳🌳🌸🌷🌸🌻🌸🌷🌻🌸🌳🌻🌺🌳🌺🌷🌺🌼🌳🌳🌷
🌳🌷🌷🐹🌺🌸🌼🌺🌺🌼🌺🌸🌸🌳🌳🌳🌼🌻🌳🌻🌷🌷🌼🌼🌳🌺🌷🌻🌳🌸🌻🌺🌸🌸🌸🌷🌻🌻🌸🌼
🌼🌳🌸🐦🌺🌺🌷🌼🌻🌺🌼🌷🌻🌸🌷🌸🌸🌸🌸🌼🌺🌻🌺🐢🌳🌼🌻🌺🌺🌺🐹🌳🌸🌸🌼🌳🌻🌻🌺🌻
🌷🌼🌸🌼🌳🌺🌺🦔🌻🌼🌻🌸🌼🌺🌺🌻🌼🌷🌼🌳🌺🌺🌷🌻🌷🐌🌸🌷🌷🌳🌺🌺🌷🌸🌳🌻🌳🌻🌸🌸

🥰 ps i love u 🥰 : 
EOM

alias prettyplease="sudo -p '$SUDOPROMPT'"

mansplain() {
  user=`echo $USER | tr "[:lower:]" "[:upper:]"`

  # ugh, macos vs linux
  if command -v gzcat
  then
    _cat() { gzcat $@; }
  else
    _cat() { zcat $@; }
  fi

  # set pager if not set
  if [ -z ${PAGER+x} ]; then PAGER=less; fi

  _cat --force `man -w $1` | sed -E -e "s/\.SH \"?NAME\"?/.SH \"WELL ACTUALLY, $user, LET ME EXPLAIN...\"/" | groff -man -Tutf8 | $PAGER
}


git-log-json() {
  IFS='' read -r -d '' FORMAT << 'EOF'
  {
  ^^^^author^^^^: { ^^^^name^^^^: ^^^^%aN^^^^,
    ^^^^email^^^^: ^^^^%aE^^^^,
    ^^^^date^^^^: ^^^^%aD^^^^,
    ^^^^dateISO8601^^^^: ^^^^%aI^^^^},
  ^^^^body^^^^: ^^^^%b^^^^,
  ^^^^commitHash^^^^: ^^^^%H^^^^,
  ^^^^commitHashAbbreviated^^^^: ^^^^%h^^^^,
  ^^^^committer^^^^: {
    ^^^^name^^^^: ^^^^%cN^^^^,
    ^^^^email^^^^: ^^^^%cE^^^^,
    ^^^^date^^^^: ^^^^%cD^^^^,
    ^^^^dateISO8601^^^^: ^^^^%cI^^^^},
  ^^^^encoding^^^^: ^^^^%e^^^^,
  ^^^^notes^^^^: ^^^^%N^^^^,
  ^^^^parent^^^^: ^^^^%P^^^^,
  ^^^^parentAbbreviated^^^^: ^^^^%p^^^^,
  ^^^^refs^^^^: ^^^^%D^^^^,
  ^^^^signature^^^^: {
    ^^^^key^^^^: ^^^^%GK^^^^,
  ^^^^signer^^^^: ^^^^%GS^^^^,
  ^^^^verificationFlag^^^^: ^^^^%G?^^^^},
  ^^^^subject^^^^: ^^^^%s^^^^,
  ^^^^subjectSanitized^^^^: ^^^^%f^^^^,
  ^^^^tree^^^^: ^^^^%T^^^^,
  ^^^^treeAbbreviated^^^^: ^^^^%t^^^^
  },
EOF
  FORMAT=$(echo $FORMAT|tr -d '\r\n ')

  git log --pretty=format:$FORMAT $1 | \
  sed -e ':a' -e 'N' -e '$!ba' -e s'/\^^^^},\n{\^^^^/^^^^},{\^^^^/g' \
      -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\^^^^/"/g' -e '$ s/,$//' | \
  sed -e ':a' -e 'N' -e '$!ba' -e 's/\r//g' -e 's/\n/\\n/g' -e 's/\t/\\t/g' | \
  awk 'BEGIN { ORS=""; printf("[") } { print($0) } END { printf("]\n") }'
}
