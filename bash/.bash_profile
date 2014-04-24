# read only once and can be overwritten in bashrc
export GEM_HOME=/Users/philip/.gem
export NODE_PATH="/usr/local/lib/node_modules"
export PATH=$PATH:$GEM_HOME/bin
# prefer distribute over Setuptools
export VIRTUALENV_DISTRIBUTE=1

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

