# Start with an RStudio image
FROM rocker/rstudio:latest

# Install command-line tools
RUN apt-get update
RUN apt-get install -y git htop psmisc openssh-server tmux vim zsh
RUN usermod --shell /usr/bin/zsh rstudio

# Configure the command line
USER rstudio
RUN git clone https://github.com/IvanUkhov/.development.git ~/.development && make -C ~/.development
RUN git clone https://github.com/IvanUkhov/.vim.git ~/.vim --recursive && make -C ~/.vim
RUN ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_ed25519
USER root

# Install R packages
RUN apt-get install -y imagemagick libxml2-dev texlive texlive-latex-extra zlib1g-dev
COPY requirements.txt /tmp/requirements.txt
RUN echo "install.packages(readLines('/tmp/requirements.txt'), \
                           repos = 'http://cran.us.r-project.org')" | R

# Configure RStudio
COPY .rstudio /home/rstudio/.rstudio

WORKDIR /home/rstudio/projects
