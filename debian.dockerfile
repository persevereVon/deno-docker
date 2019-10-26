FROM debian:stable-20190610-slim

ENV DENO_VERSION=0.21.0
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update && \
    apt-get -qq install -y --no-install-recommends curl ca-certificates && \
    curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno_linux_x64.gz --output deno.gz && \
    gunzip deno.gz && \
    chmod 777 deno && \
    mv deno /usr/bin/deno && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd --uid 1993 --user-group deno && \
    mkdir /deno-dir/ && \
    chown deno:deno /deno-dir/
# USER deno
ENV DENO_DIR /deno-dir/


ENTRYPOINT ["deno", "run", "https://deno.land/std/examples/welcome.ts"]