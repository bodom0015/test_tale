FROM ndslabs/cloud9-base:latest

# Install some common dependencies
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      curl \
      wget \
      unzip \
      gcc \
      g++ \
      gdb \
      gdbserver \
      build-essential \
      python-pip \
      python3-pip \
      python-software-properties \
      software-properties-common && \
    apt-get -qq clean all && \
    apt-get -qq autoclean && \
    apt-get -qq autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    sudo apt-get -qq install nodejs && \
    apt-get -qq clean all && \
    apt-get -qq autoclean && \
    apt-get -qq autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Install Bower / Grunt / Gulp
RUN npm install -g bower grunt gulp

# NOTE: no tty here, so we pipe to /dev/null
# The "echo" pipes are just there to send a newline in case the process prompts for input
RUN bash -c "echo | echo | vim +PluginInstall +qall &>/dev/null"
