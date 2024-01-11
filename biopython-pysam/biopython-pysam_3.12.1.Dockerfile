FROM python:3.12.1-slim-bookworm
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*
RUN pip install biopython tqdm pysam
