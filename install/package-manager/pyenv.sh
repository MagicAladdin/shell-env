#!/bin/bash

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"


git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"


git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=true
pyenv virtualenvwrapper

# vim:fenc=utf-8:ft=sh:
