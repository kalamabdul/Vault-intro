# Vault-intro


## what is vault  
* secrets management solution - what is a secret?
* Single source of secerts
* Provides Lifecycle Management for Secrets

![Demo](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dvault%26version%3Drefs%252Fheads%252Frelease%252F1.15.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fhow-vault-works.png%26width%3D2077%26height%3D1343&w=3840&q=75)

## Auth methods
* Perform authentication and assign policy to the token
* Humans vs Machines Auth methods
* Token auth method is already enabled
* Types of auth method
    1. Ldap
    2. Approle

## Demo for `vault auth`  
### Enable Approle"

    vault auth enable approle

### Configure approle"

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
* Perform authentication and assign policy to the token
* Humans vs Machines Auth methods
* Token auth method is already enabled
* Types of auth method
    1. Ldap
    2. Approle


## labs

## questions

