# this file starts with _ so that it's sourced first
export EDITOR=vim
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

if [[ `uname` == "Darwin" ]]; then
  export CURL_SSL_BACKEND=secure-transport
fi
