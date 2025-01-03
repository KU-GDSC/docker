FROM python:3.9.18-bookworm as builder
RUN apt-get update && \
    apt-get install --no-install-recommends -y procps locales ncbi-blast+ git g++ build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip install numpy==1.23.5 scipy==1.12.0 pybind11 h5py==3.8.0 leidenalg python-igraph texttable sam-algorithm jupyterlab holoviews==1.16 bokeh==3.1.1 holoviews-samap colorlover notebook ipywidgets plotly ipyevents selenium
RUN git clone https://github.com/atarashansky/SAMap /tmp/SAMap
WORKDIR /tmp/SAMap
RUN git checkout 99c70f0dd49043708e434292efcff6a5b4ba5064
RUN pip install .

FROM python:3.9.18-bookworm
RUN apt-get update && \
    apt-get install --no-install-recommends -y procps locales ncbi-blast+ libcurl4-gnutls-dev libxml2-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/share/jupyter /usr/local/share/jupyter
COPY --from=builder /usr/local/bin /usr/local/bin
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
