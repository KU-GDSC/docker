FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y procps bash wget curl sed perl locales gzip python3 build-essential && rm -rf /var/lib/apt/lists/* && ln -s /usr/bin/python3.11 /usr/local/bin/python
RUN mkdir -p /tmp && cd /tmp && wget https://d3gcli72yxqn2z.cloudfront.net/downloads/connect/latest/bin/ibm-aspera-connect_4.2.12.780_linux_x86_64.tar.gz && tar -xvf ibm-aspera-connect_4.2.12.780_linux_x86_64.tar.gz
RUN useradd --system -s /sbin/nologin fakeuser && mkdir -p /home/fakeuser && chown fakeuser /home/fakeuser && mkdir -p /aspera && chown fakeuser /aspera
USER fakeuser
RUN bash /tmp/ibm-aspera-connect_4.2.12.780_linux_x86_64.sh
USER root
RUN mv /home/fakeuser/.aspera /usr/local/aspera
RUN chmod a+x /usr/local/aspera/connect/bin/*

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y procps locales libc-dev wget gzip bash && rm -rf /var/lib/apt/lists/*
COPY --from=0 /usr/local/aspera /usr/local/aspera
RUN ln -s /usr/local/aspera/connect/bin/* /usr/local/bin/
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
