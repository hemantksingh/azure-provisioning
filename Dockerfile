FROM ubuntu:16.04

LABEL maintainer="Hemant Kumar <me@hemantkumar.net>" 

## Install pre-requisite packages
RUN apt-get update && apt-get install -y libssl-dev libffi-dev python-dev python-pip

## Install Ansible and Azure SDKs via pip
RUN pip install ansible[azure]

RUN mkdir ~/.azure

WORKDIR /app
COPY callback_plugins/*.py /app/callback_plugins/
COPY playbook.yml /app
COPY ansible.cfg /app
COPY deploy.sh /app

ENTRYPOINT ["ansible-playbook", "playbook.yml"]