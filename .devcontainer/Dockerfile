FROM ubuntu:latest

WORKDIR /home/

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
  curl \
  git \
  zsh

# oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Homebrew
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
RUN brew install \
  gh \
  || echo "Probably a warning... THIS IS FINE!"

# Node
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Chrome
RUN curl -LO https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb
RUN rm google-chrome-stable_current_amd64.deb

COPY . .
