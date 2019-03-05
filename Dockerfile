FROM ubuntu:16.04

LABEL maintainer="Hemant Kumar <me@hemantkumar.net>" 

## Install pre-requisite packages
RUN apt-get update && apt-get install -y libssl-dev libffi-dev python-dev python-pip

## Install Ansible and Azure SDKs via pip
RUN pip install ansible[azure]

RUN mkdir ~/.azure

WORKDIR /app
COPY . /app

ENTRYPOINT ["ansible-playbook", "playbook.yml"]