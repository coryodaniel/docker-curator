FROM debian:9.5-slim

WORKDIR /app/curator

RUN apt-get update && \
  apt-get -y install python-pip && \
  pip install -U elasticsearch-curator==5.5.4

ENTRYPOINT ["/usr/local/bin/curator"]
CMD ["--version"]
