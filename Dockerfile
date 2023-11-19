FROM ubuntu:22.04
COPY /easybreach.bloom /easybreach.bloom
RUN ls *binary*
ADD . .
ENTRYPOINT ["/easybreach"]