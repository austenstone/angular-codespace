FROM ubuntu:latest

WORKDIR /home/

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
  curl \
  git \
  zsh

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Node
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Homebrew
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
RUN brew install gh

COPY . .
