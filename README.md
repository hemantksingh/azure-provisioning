## Requirements

* Docker
* make

## Azure Authentication

Ansible looks for a credentials file in `{home_dir}/.azure/credentials` or environment variables.

Using File

  ````ini
  [default]
  subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  secret=xxxxxxxxxxxxxxxxx
  tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
  ````

Using Environment Variables

    AZURE_CLIENT_ID=xxxx
    AZURE_SECRET=xxxx
    AZURE_SUBSCRIPTION_ID=xxxxx
    AZURE_TENANT=xxxx

## Start provisioning

```
make run
```

## Useful links

* http://docs.ansible.com/ansible/latest/guide_azure.html
* https://docs.microsoft.com/en-us/azure/ansible/ansible-create-configure-azure-web-apps

Ansible best practice

* http://hakunin.com/six-ansible-practices
* https://www.amon.cx/blog/one-year-with-ansible/