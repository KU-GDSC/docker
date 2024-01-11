FROM python:3.9.7-slim-bullseye
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*
RUN pip install kb-python