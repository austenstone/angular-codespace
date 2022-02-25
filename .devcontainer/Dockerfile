FROM ubuntu:latest

WORKDIR /home/

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
  curl \
  git \
  zsh

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

COPY . .

RUN bash ./setup.sh
