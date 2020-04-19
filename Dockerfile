# Start with an RStudio image
FROM rocker/rstudio:latest

# Install R packages
RUN apt-get update
RUN apt-get install -y imagemagick libxml2-dev texlive texlive-latex-extra zlib1g-dev
COPY requirements.txt /tmp/requirements.txt
RUN echo "install.packages(readLines('/tmp/requirements.txt'), \
                           repos = 'http://cran.us.r-project.org')" | R

# Configure RStudio
COPY .rstudio /home/rstudio/.rstudio
