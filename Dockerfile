FROM ubuntu:16.04

LABEL maintainer="Kalibrate Technologies"

## Install pre-requisite packages
RUN apt-get update && apt-get install -y libssl-dev libffi-dev python-dev python-pip

## Install Ansible and Azure SDKs via pip
RUN pip install ansible[azure]

# Install Azure cli
RUN apt-get install apt-transport-https lsb-release software-properties-common dirmngr -y
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list'
RUN apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
RUN  apt-get update && apt-get -y install azure-cli jq

RUN mkdir -p ~/.azure

WORKDIR /app
COPY . /app

RUN chmod +x *.sh

ENTRYPOINT ["ansible-playbook"]