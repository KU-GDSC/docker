FROM python:3.12.1-slim-bookworm
RUN apt-get update && apt-get install -y procps locales && rm -rf /var/lib/apt/lists/*
RUN pip install biopython tqdm pandas seaborn matplotlib scipy pylint

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
