# $Id: ~/.profile.d/sdkman.sh wandsas 2018/07/23

export SDKMAN_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sdkman"

[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source $SDKMAN_DIR/bin/sdkman-init.sh
