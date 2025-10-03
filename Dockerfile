FROM ubuntu:22.04@sha256:09506232a8004baa32c47d68f1e5c307d648fdd59f5e7eaa42aaf87914100db3
# COPY /easybreach.bloom /easybreach.bloom
ADD . .
ENTRYPOINT ["/easybreach"]