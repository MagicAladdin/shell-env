# $Id: ~/.shared_rc.d/pass-teaming.sh wandsas 2018/08/20

pass-default () {
    export PASSWORD_STORE_DIR="$HOME/.pass-wandsas"
}

pass-android () {
    export PASSWORD_STORE_DIR="$HOME/.pass-android"
}

pass-aladdin () {
    export PASSWORD_STORE_DIR="$HOME/.pass-aladdin"
}

[[ -z "$PASSWORD_STORE_DIR" ]] && pass-default

# vim:fenc=utf-8:ft=sh:
