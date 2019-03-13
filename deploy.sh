 #!/bin/bash -e
set -e

./azlogin.sh

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