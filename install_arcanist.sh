#!/bin/bash

confirm() {
  echo "Press RETURN to continue, or ^C to cancel.";
  read -e ignored
}

if [[ "$1" == "" ]]; then
  TARGET="$HOME/.bin"
else
  TARGET=$1
fi

echo "Arcanist will be installed to: $TARGET"
echo
confirm

if [[ -f $TARGET ]]; then
  echo "Installation failed: $TARGET is a file"
  exit 1
elif [[ ! -d $TARGET ]]; then
  echo "Creating directory $TARGET..."
  mkdir -p $TARGET
fi

echo "Installing Arcanist..."
cd $TARGET
if [[ ! -e arcanist ]]; then
  git clone git://github.com/phacility/arcanist.git
else
  (cd arcanist && git pull --rebase)
fi

if [[ ! -e libphutil ]]; then
  git clone git://github.com/phacility/libphutil.git
else
  (cd libphutil && git pull --rebase)
fi

echo "export PATH=\$PATH:$TARGET/arcanist/bin" >> $HOME/.bashrc
source $HOME/.bashrc
echo
echo "Arcanist depends on PHP. Installing PHP from yum..."
echo
sudo yum install php -y
echo "Done"
echo
