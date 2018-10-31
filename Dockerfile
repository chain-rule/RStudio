FROM rocker/rstudio:latest

COPY setup.sh /tmp/setup.sh
RUN source /tmp/setup.sh

COPY setup.R /tmp/setup.R
RUN R < /tmp/setup.R
