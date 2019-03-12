 #!/bin/bash -e

 # -e: exit right away on an error
 # $?: get the exit status of the last command, exit status 0 -> success

if [[ -z "$AZURE_CLIENT_ID" ]] && [[ -z "$AZURE_SECRET"  ]] && [[ -z "$AZURE_TENANT" ]] ; then
    echo "Azure Login using sourced ini creds..."
    # source <(grep = ~/.azure/credentials)
    az login --service-principal -u $client_id -p $secret -t $tenant
else
    echo "Azure Login using env vars..."
    az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_SECRET -t $AZURE_TENANT
fi

echo Deploying function...