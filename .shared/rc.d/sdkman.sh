# $Id: ~/.profile.d/sdkman.sh wandsas 2018/07/23
#
# SDKman
#

[[ -d "$HOME/.sdkman" ]] || return

export SDKMAN_DIR="$HOME/sdkman"

[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source $SDKMAN_DIR/bin/sdkman-init.sh

# vim:fenc=utf-8:ft=sh:
