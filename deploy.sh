#!/bin/bash

echo Azure login
source <(grep = ~/.azure/credentials)
az login --service-principal -u $client_id -p $secret -t $tenant

echo Deploying function

