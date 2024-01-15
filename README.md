# Vault-intro
Dont let me alone. Ask questions, keep interactive.

<img src="https://media.giphy.com/media/H6cmWzp6LGFvqjidB7/giphy.gif" width="400" height="790">

## what is vault  


* secrets management solution - what is a secret?
* Single source of secerts
* Provides Lifecycle Management for Secrets

![Demo](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dvault%26version%3Drefs%252Fheads%252Frelease%252F1.15.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fhow-vault-works.png%26width%3D2077%26height%3D1343&w=3840&q=75)

## How it works

![how it works](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dvault%26version%3Drefs%252Fheads%252Frelease%252F1.15.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fvault-workflow-diagram1.png%26width%3D8300%26height%3D9000&w=3840&q=75)

## Auth methods
* Perform authentication and assign policy to the token
* Humans vs Machines Auth methods
* Token auth method is already enabled
* Types of auth method
    1. Approle
    2. LDAP

## Demo for `vault auth method Approle`  
### Enable Approle"

    vault auth enable approle

### Configure Approle"

    vault write auth/approle/role/my-role \
    token_ttl=1h \
    token_max_ttl=1h \
    token_max_ttl=1h \
    secret_id_ttl=1h \
    secret_id_num_uses=5 \
    token_policies=kv-read-policy


### Fetch the role id from the approle"

    vault read auth/approle/role/my-role/role-id

### Fetch the role id from the approle"

    vault read auth/approle/role/my-role/role-id

### Get a SecretID issued against the approle:

    vault write -f auth/approle/role/my-role/secret-id

### Check that the approle authentication is configured properly:

    vault write auth/approle/login     role_id=<your_role_id>     secret_id=<your_secret_id>


## Secret Engines
* Secrets engines are Vault components which store, generate or encrypt secrets
* KV store, dynamic creds, Encryption as service
* Secret engines are plugins that need to be enabled
* Token auth method is already enabled
* Types of secrets engines
    1. Ldap
    2. Databases
    3. KV engine

## Demo for `vault secrets engine - LDAP`  
### Enable engine"

    vault secrets enable ldap

### Configure Engine"

    vault write ldap/config \
    binddn=cn=admin,dc=learn,dc=example \
    bindpass=2LearnVault \
    url=ldap://20.120.122.167
   


### Vault the account"

    vault write ldap/static-role/learn \
    dn='cn=alice,ou=users,dc=learn,dc=example' \
    username='alice' \
    rotation_period="600s"

### Read the password"

    vault read ldap/static-cred/learn


### Check that the pasword is working:

    vault write auth/approle/login     role_id=<your_role_id>     secret_id=<your_secret_id>


## Vault Policies
* Policies provide a declarative way to grant or forbid access to certain paths and operations in Vault
* Policies are deny by default, so an empty policy grants no permission in the system
* Secret engines are plugins that need to be enabled
* Token auth method is already enabled  

![Pollicyworkflow](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dvault%26version%3Drefs%252Fheads%252Frelease%252F1.15.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fvault-policy-workflow.svg%26width%3D669%26height%3D497&w=1920&q=75)
## labs

## questions

