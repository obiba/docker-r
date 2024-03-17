#
# R, latex and java Dockerfile
#
# https://github.com/obiba/docker-r
#

FROM eclipse-temurin:21-jre-jammy AS server-released

LABEL OBiBa <dev@obiba.org>

ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

# Install latest R and system dependencies
RUN \
  apt-get update -qq && \
  apt-get install -y --no-install-recommends software-properties-common dirmngr && \
  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
  add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" && \
  apt-get install -y r-base libcurl4-openssl-dev libssl-dev libsasl2-dev libssh-dev libmariadb-dev libmariadb-dev-compat libpq-dev libsodium-dev libgit2-dev libssh2-1-dev libxml2-dev libcairo-dev freeglut3-dev pandoc cargo libmagick++-dev libharfbuzz-dev libfribidi-dev libv8-dev build-essential cmake

# Install additional R packages (see opal-rserver package)
RUN \
  Rscript -e "install.packages(c('opalr', 'BiocManager', 'devtools', 'tidyverse', 'knitr', 'rmarkdown', 'labelled', 'haven', 'sqldf', 'tinytex'), repos=c('https://cloud.r-project.org', 'https://cran.obiba.org'), dependencies=TRUE, lib='/usr/local/lib/R/site-library')" && \
  Rscript -e "install.packages('unixtools', repos = 'http://www.rforge.net/')"
