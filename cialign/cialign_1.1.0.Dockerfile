FROM python:3.11.6-slim-bullseye
RUN apt-get update && \
    apt-get install -y procps && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
RUN pip install cialign pandas argP scipy
