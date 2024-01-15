# Vault-intro


## what is vault  
* secrets management solution - what is a secret?
* Single source of secerts
* Provides Lifecycle Management for Secrets

## Auth methods
1. Ldap
2. Approle

## Demo for `vault auth`  
### Enable Approle"

    vault auth enable approle
    l

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
    l

### Fetch the role id from the approle"

    vault read auth/approle/role/my-role/role-id
    l
### Get a SecretID issued against the approle:

    vault write -f auth/approle/role/my-role/secret-id
    l

### Check that the approle authentication is configured properly:

    vault write auth/approle/login     role_id=<your_role_id>     secret_id=<your_secret_id>

    
## Secret Engines
1. LDAP
2. DB engines  
   * mysql
   * oracle
3. 


## labs

## questions

