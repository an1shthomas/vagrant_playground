#!/bin/bash

echo "configuring vimrc"
cat <<EOF>/home/vagrant/.vimrc
" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
EOF
