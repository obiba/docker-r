#
# R, latex and java Dockerfile
#
# https://github.com/obiba/docker-r
#

FROM openjdk:8-jre-stretch AS server-released

LABEL OBiBa <dev@obiba.org>

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# Install latest R and system dependencies
RUN \
  echo 'deb http://cran.r-project.org/bin/linux/debian stretch-cran35/' | tee /etc/apt/sources.list.d/r.list && \
  apt-key adv --no-tty --keyserver keys.gnupg.net --recv-key E19F5F87128899B192B1A2C2AD5F960A256A04AF && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y r-base libcurl4-openssl-dev libssl-dev libxml2-dev libcairo-dev freeglut3-dev pandoc texlive-latex-base texlive-fonts-recommended texlive-latex-extra cargo libmagick++-dev && \
  DEBIAN_FRONTEND=noninteractive apt-get purge -y texlive*doc

# Install additional R packages (see opal-rserver package)
RUN Rscript -e "install.packages(c('opal', 'opalr', 'tidyverse', 'knitr', 'rmarkdown'), repos=c('https://cloud.r-project.org', 'https://cran.obiba.org'), dependencies=TRUE, lib='/usr/local/lib/R/site-library')"
