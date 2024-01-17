# Vault-intro

## VPM

* VPM creates primarily below Vault resources
    1. Ldap auth method
    2. Approle Auth method
    3. Ldap secrets engine
    4. Policies

## What is Vault  


* Secrets management solution - what is a secret?
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

## Demo for `vault auth method -  Approle`  
### *Enable Approle*

    vault auth enable approle

### *Configure Approle*

    vault write auth/approle/role/12345-application \
    token_ttl=14400 \ 
    token_max_ttl=14400 \
    secret_id_ttl=15552000 \
    token_policies=12345-application 

* TTL default to 4 hours
* secret_id ttl default to 180 days
* Application, Automation, Manager (LDAP)

### *Update Approle role ID to a custom value*

    vault write auth/approle/role/12345-application \
    role_id=ZS12345


### *Fetch the role id from the approle*

    vault read auth/approle/role/12345-application/role-id


### *Get a SecretID issued against the approle*

    vault write -f auth/approle/role/12345-application/secret-id

### *Check that the approle authentication is configured properly*

    vault write auth/approle/login     role_id=ZS12345     secret_id=<your_secret_id>


## Demo for `vault auth method -  LDAP`  
### *Enable ldap*

    vault auth enable ldap

### *Configure LDAP*

    vault write auth/ldap/config \
    url="ldap://20.102.13.234" \
    userdn="ou=users,dc=learn,dc=example" \
    userattr="cn" \
    groupdn="ou=groups,dc=learn,dc=example" \
    groupattr="cn" \
    insecure_tls=true \
    starttls=false \
    binddn="cn=admin,dc=learn,dc=example" \
    bindpass="" 

* TTL default to 4 hours
* secret_id ttl default to 180 days
* Humans (LDAP)

### *LDAP group -> policy mapping*

     vault write auth/ldap/groups/dev policies=dev-read
     vault write auth/ldap/groups/vaultadmin policies=vaultadmin

### *login*

    vault login -method=ldap username=alice
### *UsersandGroups*

| User     |  Groups       | Policies
| -------- | -------       | -------
| Alice    | Dev           | ait-manager
| Kalam    | VaultAdmin    | vaultadmin

## Secret Engines
* Secrets engines are Vault components which store, generate or encrypt secrets
* Types of Engines - KV store, dynamic creds, Encryption as service
* Secret engines are plugins that need to be enabled, Community, Custom etc
* Types of secrets engines
    1. Ldap
    2. Databases
    3. KV engine

## Demo for `vault secrets engine - KV`  
### *Enable engine*

    vault secrets enable -path=secrets/kv kv-v2

### *Add Static secrets*

    vault kv put secrets/kv/ait-12345 password=supersecret
    vault kv put secrets/kv/ait-56789 password=supersecret2

### Read Static secrets

    vault kv get secrets/kv/ait-12345
    vault kv get secrets/kv/ait-56789

## Demo for `vault secrets engine - LDAP`  
### Enable engine

    vault secrets enable ldap

### Create password policy

    vault write sys/policies/password/ldap policy=@password_policy.hcl


### Configure Engine

    vault write ldap/config \
    binddn=cn=admin,dc=learn,dc=example \
    password_policy=ldap \
    bindpass= \
    url=ldap://4.157.222.221
   


### Vault the account "serviceaccount1"

    vault write ldap/static-role/12345-serviceaccount1 \
    dn='cn=serviceaccount1,ou=users,dc=learn,dc=example' \
    username='serviceaccount1' \
    rotation_period="600s"


### Vault the account "serviceaccount2"

    vault write ldap/static-role/12345-serviceaccount2 \
    dn='cn=serviceaccount2,ou=users,dc=learn,dc=example' \
    username='alice2' \
    rotation_period="600s"

### Read the password

    vault read ldap/static-cred/12345-serviceaccount1


### Check that the pasword is working

    ldapsearch -b "cn=johnny,dc=learn,dc=example" \
    -D 'cn=serviceaccount1,ou=users,dc=learn,dc=example' -h 4.157.222.221:389 \
    -w 


## Vault Policies
* Policies provide a declarative way to grant or forbid access to certain paths and operations in Vault
* Policies are deny by default, so an empty policy grants no permission in the system

![Pollicyworkflow](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dvault%26version%3Drefs%252Fheads%252Frelease%252F1.15.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fvault-policy-workflow.svg%26width%3D669%26height%3D497&w=1920&q=75)

## Demo for `vault policy`  
### Create Policy

    vault policy write 12345-application 12345-application.hcl

## Getting started with Vault

    vault server -dev


## questions

