#!/bin/bash

DIR=$(cd `dirname $0` && pwd)
cd ~
ln -s $DIR .vim
ln -s $DIR/vimrc .vimrc
ln -s $DIR/gvimrc .gvimrc

cd $DIR/ruby/command-t
ruby extconf.rb
make
cd ~
