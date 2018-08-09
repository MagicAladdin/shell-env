# $Id: ~/.profile.d/sdkman.sh wandsas 2018/07/23
#
# SDKman
#

export SDKMAN_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sdkman"

[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source $SDKMAN_DIR/bin/sdkman-init.sh

# vim:fenc=utf-8:ft=sh:
