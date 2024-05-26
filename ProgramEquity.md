# ProgramEquity Vault Lab


* In this Lab we will create primarily below Vault resources
    1. JWT auth method
    2. ROle for Github Actions
    2. Policy for GitHub Actions
    4. Static secrets engine

## What is JWT Auth


* The OIDC method allows authentication via a configured OIDC provider using the user's web browser. This method may be initiated from the Vault UI or the command line. Alternatively, a JWT can be provided directly. The JWT is cryptographically verified using locally-provided keys, or, if configured, an OIDC Discovery service can be used to fetch the appropriate keys. The choice of method is configured per role.


## Configure JWT Auth


#### *Enable JWT Auth*
   ## Enable the JWT auth method, and use write to apply the configuration to your Vault. For oidc_discovery_url and         bound_issuer parameters, use https://token.actions.githubusercontent.com. These parameters allow the Vault server to verify  the received JSON Web Tokens (JWT) during the authentication process.



    vault auth enable jwt

#### *Configure Auth method*

    vault write auth/jwt/config \
    bound_issuer="https://token.actions.githubusercontent.com" \
    oidc_discovery_url="https://token.actions.githubusercontent.com"

#### *Configure roles to group different policies together. If the authentication is successful, these policies are attached to the resulting Vault access token.*

    vault write auth/jwt/role/demo -<<EOF
    {
     "role_type": "jwt",
     "user_claim": "workflow",
     "bound_claims": {
     "repository": "kalamabdul/Vault-intro"
    },
    "policies": ["app-policy"],
    "ttl": "10m"
    }
    EOF



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

     vault kv put -mount=secrets/kv/ ait-12345/db password=supersecret
     vault kv put -mount=secrets/kv/ ait-56789/db password=supersecret

#### Read Static secrets

    vault kv get -mount=secrets/kv/ ait-12345/db
    vault kv get -mount=secrets/kv/ ait-56789/db


## Vault Policies
* Policies provide a declarative way to grant or forbid access to certain paths and operations in Vault
* Policies are deny by default, so an empty policy grants no permission in the system

![Pollicyworkflow](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dvault%26version%3Drefs%252Fheads%252Frelease%252F1.15.x%26asset%3Dwebsite%252Fpublic%252Fimg%252Fvault-policy-workflow.svg%26width%3D669%26height%3D497&w=1920&q=75)

## Demo for `vault policy`  
#### Create Policy

    #### *Configure a policy that only grants access to the specific paths your workflows will use to retrieve secrets*

    tee app-policy.hcl <<EOF
    path "secret/*"
    {  
    capabilities = ["read"]
    }
    EOF

