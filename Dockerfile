#
# R, latex and java Dockerfile
#
# https://github.com/obiba/docker-r
#

FROM openjdk:8-jre-bullseye AS server-released

LABEL OBiBa <dev@obiba.org>

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# GPG setup
RUN \
  gpg --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' && \
  gpg --armor --export '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7' | sudo tee /etc/apt/trusted.gpg.d/cran_debian_key.asc

# Install latest R and system dependencies
RUN \
  echo 'deb http://cran.r-project.org/bin/linux/debian bullseye-cran40/' | tee /etc/apt/sources.list.d/r.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y r-base-core && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y libcurl4-openssl-dev libssl-dev libsasl2-dev libssh-dev libmariadb-dev libmariadb-dev-compat libpq-dev libsodium-dev libgit2-dev libssh2-1-dev libxml2-dev libcairo-dev freeglut3-dev pandoc texlive-latex-base texlive-fonts-recommended texlive-latex-extra cargo libmagick++-dev libharfbuzz-dev libfribidi-dev libv8-dev && \
  DEBIAN_FRONTEND=noninteractive apt-get purge -y texlive*doc

# Install additional R packages (see opal-rserver package)
RUN \
  Rscript -e "install.packages(c('opalr', 'BiocManager', 'devtools', 'tidyverse', 'knitr', 'rmarkdown', 'labelled', 'haven', 'sqldf'), repos=c('https://cloud.r-project.org', 'https://cran.obiba.org'), dependencies=TRUE, lib='/usr/local/lib/R/site-library')" && \
  Rscript -e "install.packages('unixtools', repos = 'http://www.rforge.net/')"
