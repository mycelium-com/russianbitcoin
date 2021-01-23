FROM alpine:3

ENV RELEASE_URL=https://github.com/nationalbitcoin/russianbitcoin/releases/download/v1.0.3.0/russianbitcoin-1.0.3-x86_64-linux-gnu.tar.gz

RUN apk add --no-cache wget tar \
  && wget --quiet -O- $RELEASE_URL | tar -xzv \
  && cd russianbitcoin-*/usr/bin \
  && mv russianbitcoin-cli russianbitcoin-tx russianbitcoind /usr/local/bin/

FROM ubuntu:20.04
COPY --from=0 /usr/local/bin/* /usr/local/bin/
VOLUME /root/.bitcoin
CMD ["/usr/local/bin/russianbitcoind", "-printtoconsole"]
