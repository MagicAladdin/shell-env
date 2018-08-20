# $Id: ~/.shared_rc.d/pass-teaming.sh wandsas 2018/08/20

info () {
	printf '\n\033[1;36mINFO\033[0m %s\n' "$@" >&2
}

pass-default () {
    export PASSWORD_STORE_DIR="$HOME/.pass-wandsas"
    info "PASSWORD_STORE_DIR=$PASSWORD_STORE_DIR"
}

pass-android () {
    export PASSWORD_STORE_DIR="$HOME/.pass-android"
    info "PASSWORD_STORE_DIR=$PASSWORD_STORE_DIR"
}

pass-aladdin () {
    export PASSWORD_STORE_DIR="$HOME/.pass-aladdin"
    info "PASSWORD_STORE_DIR=$PASSWORD_STORE_DIR"
}

[[ -z "$PASSWORD_STORE_DIR" ]] && pass-default

# vim:fenc=utf-8:ft=sh:
