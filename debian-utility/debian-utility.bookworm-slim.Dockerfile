FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y procps bash wget curl sed perl locales python3 && rm -rf /var/lib/apt/lists/* && ln -s /usr/bin/python3.11 /usr/local/bin/python
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
