# $Id: ~/.zsh/rc.d/vvv-zsh-morpho.sh wandsas 2018/08/09

# Zsh morpho xscreensaver
# https://github.com/psprint/zsh-morpho/

zshrc_morpho () {
  local basedir="/usr/share/zsh/site-contrib/zsh-morpho"
  local morphorc="zsh-morpho.plugin.zsh"

  [[ -r "${basedir}/${morphorc}" ]] && source ${basedir}/${morphorc} || return

  # screen-saver: zmorpho, zmandelbrot, zblank & pmorpho
  zstyle ":morpho" screen-saver "zmandelbrot"
  zstyle ":morpho" arguments "-s"
  zstyle ":morpho" delay "290"
  zstyle ":morpho" check-interval "60"
}

if [[ -z "${ZSHRC_SKIP_MORPHO:++}" ]]
then  zshrc_morpho
fi

# Free unused memory unless the user explicitly sets ZSHRC_KEEP_FUNCTIONS
if [[ -z "${ZSHRC_KEEP_FUNCTIONS:++}" ]]
then    unfunction zshrc_morpho
fi

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0
