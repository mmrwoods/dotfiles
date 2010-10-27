#!/bin/bash

DIR=$(cd `dirname $0` && pwd)
cd ~
ln -s $DIR .vim
ln -s $DIR/vimrc .vimrc

