FROM rocker/tidyverse:4.4.1
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    procps \
    locales \
    libbz2-dev \
    liblzma-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove

RUN R -e "options(repos = \
                  list(CRAN = 'http://archive.linux.duke.edu/cran/')); \
    install.packages(c('BiocManager','remotes', 'devtools')); \
    BiocManager::install(c('TSSr','Rsamtools','GenomicRanges','GenomicFeatures','Gviz','rtracklayer','DESeq2','BSgenome','BSgenomeForge'));"

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8    
