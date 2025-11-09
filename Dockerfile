#
# R, latex and java Dockerfile
#
# https://github.com/obiba/docker-r
#

FROM eclipse-temurin:25-jre-noble AS server-released

LABEL OBiBa=<dev@obiba.org>

ENV LANG=C.UTF-8
ENV LANGUAGE=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install latest R and system dependencies
RUN \
  apt update -qq && \
  apt install -y software-properties-common dirmngr && \
  wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc && \
  add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" && \
  apt install -y r-base libcurl4-openssl-dev libssl-dev libsasl2-dev libssh-dev libmariadb-dev libmariadb-dev-compat libpq-dev libsodium-dev libgit2-dev libssh2-1-dev libxml2-dev libcairo-dev freeglut3-dev pandoc cargo libmagick++-dev libharfbuzz-dev libfribidi-dev libv8-dev build-essential cmake && \
  apt clean && \
  # Install additional R packages
  Rscript -e "install.packages(c('opalr', 'BiocManager', 'devtools', 'tidyverse', 'knitr', 'rmarkdown', 'labelled', 'haven', 'sqldf', 'tinytex'), repos=c('https://cloud.r-project.org'), dependencies=TRUE, lib='/usr/local/lib/R/site-library')" && \
  Rscript -e "install.packages('unixtools', repos = 'http://www.rforge.net/')"
