 #!/bin/bash -e

#
# Neel - The Azure CLI Warpper
#
# (c) 2019 @_hemantksingh
#

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

storage_get_accesskey() {
    acc_name=$1; res_group=$2; key_index=${3:-0}

    az storage account keys list \
        --account-name $acc_name \
        --resource-group $res_group \
        --query "[$key_index].value" \
        --output tsv
}

storage_get_constring() {
    acc_name=$1; res_group=$2;

    az storage account show-connection-string \
        -g $res_group -n $acc_name | jq -r '.connectionString'
}

sql_getdb_constring() {
    dbserver=$1; dbname=$2 client=${3:-ado.net}
    
    az sql db show-connection-string \
        -s $dbserver -n $dbname -c $client --output tsv | \
        sed -e "s/<username>/$AZURE_SQLSERVER_USERNAME/g" \
            -e "s/<password>/$AZURE_SQLSERVER_PASSWORD/g"
}

# TODO: Only create if doesn't exist
sb_createnamespace() {
    namespace=$1; res_group=$2; 
    
    az servicebus namespace create \
        --name $namespace \
        --resource-group $res_group
}

sb_getauthrule_constring() {
    namespace=$1; res_group=$2; auth_rule=$3

    az servicebus namespace authorization-rule keys list  \
        --resource-group $res_group \
        --namespace-name $namespace \
        --name $auth_rule \
        | jq -r '.primaryConnectionString'
}