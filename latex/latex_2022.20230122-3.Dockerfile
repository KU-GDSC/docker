FROM debian:bookworm-slim
RUN apt-get update && \
    apt-get install -y procps texlive-base texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-science texlive-fonts-extra && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
