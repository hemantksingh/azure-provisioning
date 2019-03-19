 #!/bin/bash -e

 # -e: exit right away on an error
 # $?: get the exit status of the last command, exit status 0 -> success

az_login() {
    if [[ -z "$AZURE_CLIENT_ID" ]] && [[ -z "$AZURE_SECRET"  ]] && [[ -z "$AZURE_TENANT" ]] ; then
        echo "Azure Login using sourced ini creds..."
        # source <(grep = ~/.azure/credentials)
        az login --service-principal -u $client_id -p $secret -t $tenant
    else
        echo "Azure Login using env vars..."
        az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_SECRET -t $AZURE_TENANT
    fi  
}

servicebus_createnamespace() {
    namespace=$1; res_group=$2; 
    
    az servicebus namespace create \
        --name $namespace \
        --resource-group $res_group
}

servicebus_authrule() {
    res_group=$1; namespace=$2; auth_rule=$3

    az servicebus namespace authorization-rule keys list  \
        --resource-group $res_group \
        --namespace-name $namespace \
        --name $auth_rule \
        | jq -r '.primaryConnectionString'
}