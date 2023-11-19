FROM ubuntu:22.04
COPY /easybreach.bloom /easybreach.bloom
RUN ls *binary*
ADD binary_easybreach /easybreach
ADD binary_downloader /easybreach_downloader
ENTRYPOINT ["/easybreach"]