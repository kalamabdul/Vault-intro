
# Vault-intro

## Install Vault on macOS

    brew tap hashicorp/tap
    brew install hashicorp/tap/vault

## Run vault in Dev mode

     vault server -dev -dev-root-token-id root



## Demo for `vault auth method -  Approle`  
#### *Enable Approle*

    vault auth enable approle


#### *Configure Approle with policy*

    vault write auth/approle/role/app1 \
    token_ttl=14400  token_max_ttl=14400  secret_id_ttl=15552000 \
    token_policies=app1 role_id=app1



* TTL default to 4 hours
* secret_id ttl default to 180 days


#### *Fetch the role id from the approle*

    vault read auth/approle/role/app1/role-id


#### *Get a SecretID issued against the approle*

    vault write -f auth/approle/role/app1/secret-id

#### *Check that the approle authentication is configured properly*

    vault write auth/approle/login     role_id=app1     secret_id=


## Secret Engines
* Secrets engines are Vault components which store, generate or encrypt secrets
* Types of Engines - KV store, dynamic creds, Encryption as service
* Secret engines are plugins that need to be enabled, Community, Custom etc
* Types of secrets engines
    1. Ldap
    2. Databases
    3. KV engine

## Demo for `vault secrets engine - KV`  
#### *Enable engine*

    vault secrets enable -path=secrets/kv kv-v2

#### *Add Static secrets*

     vault kv put -mount=secrets/kv/ app1/db password=supersecret
     

#### Read Static secrets

    vault kv get -mount="secrets/kv" "app1/db"

## Vault Policies
* Policies provide a declarative way to grant or forbid access to certain paths and operations in Vault
* Policies are deny by default, so an empty policy grants no permission in the system

![Pollicyworkflow](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dvault%26version%3Drefs%252Fheads%252Frelease%252F1.15.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fvault-policy-workflow.svg%26width%3D669%26height%3D497&w=1920&q=75)

## Demo for `vault policy`  
#### Create Policy

    vault policy write app1 app1.hcl

