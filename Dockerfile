FROM ndslabs/cloud9-base:latest

# Install some common dependencies
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends \
      curl \
      wget \
      unzip \
      gcc \
      python-pip \
      python3-pip \
      vim \
      vim-gnome \
      g++ \
      gdb \
      gdbserver \
      build-essential \
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

COPY .vimrc /root/.vimrc

RUN mkdir -p /root/.vim/colors && \
    git clone git://github.com/altercation/vim-colors-solarized.git /tmp/vim-solarized && \
    mv /tmp/vim-solarized/colors/solarized.vim /root/.vim/colors && \
    git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim && \
    rm -rf /root/.vim/bundle/Vundle.vim/.git /tmp/vim-solarized/.git

# NOTE: no tty here, so we pipe to /dev/null
# The "echo" pipes are just there to send a newline in case the process prompts for input
RUN bash -c "echo | echo | vim +PluginInstall +qall &>/dev/null"
