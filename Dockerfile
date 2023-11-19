FROM ubuntu:22.04
COPY /easybreach.bloom /easybreach.bloom
ADD binary_easybreach /easybreach
ADD binary_easybreach_haveibeenpwned_downloader /easybreach_haveibeenpwned_downloader
ENTRYPOINT ["/easybreach"]