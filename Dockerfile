# Start with an RStudio image
FROM rocker/rstudio:latest

# Install the software that R packages require
RUN apt-get update
RUN apt-get install -y imagemagick libxml2-dev texlive texlive-latex-extra zlib1g-dev

# Install the desired R packages
COPY requirements.txt /tmp/requirements.txt
RUN echo "install.packages(readLines('/tmp/requirements.txt'), \
                           repos = 'http://cran.us.r-project.org')" | R

# Set the working directory
WORKDIR /home/rstudio
