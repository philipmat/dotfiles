# read only once and can be overwritten in bashrc
export GEM_HOME=/Users/philip/.gem
export NODE_PATH="/usr/local/lib/node_modules"
export PATH=$PATH:$GEM_HOME/bin
# prefer distribute over Setuptools
export VIRTUALENV_DISTRIBUTE=1

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi


# starts or connects to the ssh-agent
# http://stackoverflow.com/questions/18880024/start-ssh-agent-on-login/18915067#18915067
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
