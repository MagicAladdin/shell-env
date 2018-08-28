# $Id: ~/.shared_rc.d/pass-teaming.sh wandsas 2018/08/20

_info () {
  printf '\033[1;36m%s\033[0m %s\n' "$@" >&2
}

pass-store-info () {
  _info PASSWORD_STORE_DIR $PASSWORD_STORE_DIR
}

pass-store-wandsas () {
  export PASSWORD_STORE_DIR=$HOME/.pass-wandsas
  pass-store-info
}

pass-store-android () {
  export PASSWORD_STORE_DIR=$HOME/.pass-android
  pass-store-info
}

passtoggle () {
  if [[ -z "$PASSWORD_STORE_DIR" ]]
  then    pass-store-wandsas
  elif [[ "$PASSWORD_STORE_DIR" == "*wandsas*" ]]
  then    pass-store-android
  elif [[ "$PASSWORD_STORE_DIR" == "*android*" ]]
  then    pass-store-wandsas
  else    die "Unknown password-store-dir $PASSWORD_STORE_DIR"
  fi
}


# vim:fenc=utf-8:ft=sh:ts=2:sts=2:sw=2:et:
