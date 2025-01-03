FROM python:3.9.18-bookworm as builder
RUN apt-get update && \
    apt-get install --no-install-recommends -y procps locales git g++ build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip install biopython==1.79 numpy>=1.22.2 matplotlib>=3.3.4 matplotlib-venn>=0.11.6 pandas>=1.2.1 pysam>=0.16.0.1 
RUN git clone https://github.com/ncsa/NEAT/ /tmp/NEAT
WORKDIR /tmp/NEAT
RUN git checkout 3.3 
RUN pip install .

FROM python:3.9.18-bookworm
RUN apt-get update && \
    apt-get install --no-install-recommends -y procps locales && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
