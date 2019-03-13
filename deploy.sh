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

echo "Downloading function artefact (s) '$ARTEFACT' .."

az storage blob download \
    --container-name packages \
    --name $ARTEFACT.$APP_VERSION.zip \
    --file downloadedBlob.zip \
    --account-name $AZURE_PACKAGE_SOURCE \
    --account-key $AZURE_STORAGE_ACCESS_KEY

echo "Deploying function app '$APP_NAME' to resource group '$RESOURCE_GROUP' ..."
az functionapp deployment \
    source config-zip  \
    -g $RESOURCE_GROUP \
    -n $APP_NAME \
    --src downloadedBlob.zip