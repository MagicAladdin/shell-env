# $Id: ~/.shared_rc.d/pass-teaming.sh wandsas 2018/08/20

pass-info () {
  printf '\033[1;36m>>>\033[0m %s\n' "PASSWORD_STORE_DIR=$PASSWORD_STORE_DIR" >&2
}

pass-wandsas () {
  export PASSWORD_STORE_DIR=$HOME/.pass-wandsas
  sh_load_status $PASSWORD_STORE_DIR
}

pass-android () {
  export PASSWORD_STORE_DIR=$HOME/.pass-android
  sh_load_status $PASSWORD_STORE_DIR
}

passtoggle () {
  if [[ "$PASSWORD_STORE_DIR" == "*wandsas*" ]]
  then    pass-android
  elif [[ "$PASSWORD_STORE_DIR" == "*android*" ]]
  then    pass-wandsas
  fi
}

if [[ -z "$PASSWORD_STORE_DIR" ]]
then pass-wandsas
fi

# vim:fenc=utf-8:ft=sh:ts=2:sts=2:sw=2:et:
