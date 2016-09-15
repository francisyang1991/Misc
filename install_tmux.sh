#!/bin/bash

ROOT=`pwd`
sudo yum install gcc kernel-devel make ncurses-devel

curl -OL https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xvzf libevent-2.0.21-stable.tar.gz
cd $ROOT/libevent-2.0.21-stable
./configure --prefix=/usr/local
make
sudo make install

curl -OL http://downloads.sourceforge.net/tmux/tmux-2.0.tar.gz
tar xvzf tmux-2.0.tar.gz
cd $ROOT/tmux-1.9a
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make
sudo make install

tmux -V
if [ $? == 0 ]; then
  echo "done"
else
  echo "failed"
