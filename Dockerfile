# Start with an RStudio image
FROM rocker/rstudio:latest

# Install command-line tools
RUN apt-get update
RUN apt-get install -y build-essential curl git htop psmisc openssh-server tmux vim zsh

RUN echo 'deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main' | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk

# Configure the command line
RUN usermod --shell /usr/bin/zsh rstudio
USER rstudio
RUN git clone https://github.com/IvanUkhov/.development.git ~/.development && make -C ~/.development
RUN git clone https://github.com/IvanUkhov/.vim.git ~/.vim --recursive && make -C ~/.vim
RUN ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519
USER root

# Install R packages
RUN apt-get install -y imagemagick libv8-dev libxml2-dev texlive texlive-latex-extra zlib1g-dev
COPY requirements.txt /tmp/requirements.txt
RUN echo "install.packages(readLines('/tmp/requirements.txt'), \
                           repos = 'http://cran.us.r-project.org')" | R

# Configure RStudio
COPY .rstudio /home/rstudio/.rstudio

WORKDIR /home/rstudio/projects
