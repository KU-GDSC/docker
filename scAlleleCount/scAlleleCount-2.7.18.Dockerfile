FROM python:2.7.18-slim-buster
RUN apt-get update && apt-get install -y procps locales wget libhts-dev build-essential bzip2 libbz2-dev r-base && rm -rf /var/lib/apt/lists/*
RUN pip install cython pandas pysam scipy numpy
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN wget -P /usr/local/bin/ https://raw.githubusercontent.com/barkasn/scAlleleCount/ef1bfd6dfd0ef9ee5ce23e6606dbfb0da3004c6c/scAlleleCount.py && \
    wget -P /usr/local/bin/ https://raw.githubusercontent.com/barkasn/scAlleleCount/ef1bfd6dfd0ef9ee5ce23e6606dbfb0da3004c6c/wrapperFunctions.R && \
    chmod a+x /usr/local/bin/scAlleleCount.py && \
    ln -s /usr/local/bin/scAlleleCount.py /usr/local/bin/scAlleleCount
