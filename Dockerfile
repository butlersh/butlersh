FROM ubuntu:24.04

RUN apt-get update && apt-get install -y curl git wget

RUN curl -fsSL https://git.io/shellspec > installer.sh

RUN bash installer.sh -y --bin /usr/local/bin
