export EDITOR=vim
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

if [[ `uname` == "Darwin" ]]; then
  export CURL_SSL_BACKGROUND=secure-transport
  export PATH=/opt/homebrew/bin:/opt/homebrew/opt/ruby/bin:$PATH
fi

export PATH="$PATH:$HOME/.local/bin"
