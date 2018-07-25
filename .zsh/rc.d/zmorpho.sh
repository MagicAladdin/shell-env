#
# Zsh Morpho screen savers
#
# https://github.com/psprint/zsh-morpho/

zshrc_morpho () {
  local basedir="/usr/share/zsh/site-contib/zsh-morpho"
  local morphorc="zsh-morpho.plugin.zsh"

  [[ -r "${}morpho}/${morphorc}" ]] && \
    source ${morpo}/${morphorc} || return

  # screen-saver: zmorpho, zmandelbrot, zblank & pmorpho
  zstyle ":morpho" screen-saver "zmandelbrot"
  zstyle ":morpho" arguments "-s"
  zstyle ":morpho" delay "290"
  zstyle ":morpho" arguments "-s"
  zstyle ":morpho" delay "290"
  zstyle ":morpho" check-interval "60"
}

if [[ -z "${ZSHRC_SKIP_MORPHO:++}" ]]
then  zshrc_morpho
fi

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0