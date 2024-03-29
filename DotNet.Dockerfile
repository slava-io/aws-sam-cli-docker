FROM python:3.8-slim

# RUN apk update && apk add python3-dev && apk add build-essential
RUN apt-get update -y  \
    && apt-get install zip -y \ 
    && apt-get install git -y \
    && apt-get install curl -y \
    && apt-get install libicu-dev -y \
    && rm -rf /var/lib/apt/lists/*
RUN pip install aws-sam-cli

ARG DOTNET_INSTALL_URL="https://dot.net/v1/dotnet-install.sh"
ARG DOTNET_CHANNEL="6.0"

WORKDIR /dotnet-script
RUN curl -Lsfo ./dotnet-install.sh $DOTNET_INSTALL_URL
RUN chmod +x ./dotnet-install.sh
RUN ./dotnet-install.sh --channel $DOTNET_CHANNEL
ENV PATH="/root/.dotnet:/root/.dotnet/tools:${PATH}"
ENV DOTNET_ROOT="/root/.dotnet"
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

WORKDIR /sam
