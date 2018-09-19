FROM debian:9.5-slim

WORKDIR /app/curator
RUN apt-get update && apt-get -y install elasticsearch-curator ca-certificates openssl
USER 1001

ENTRYPOINT ["/usr/bin/curator"]
CMD ["--help"]
