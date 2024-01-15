

path "ldap/static-cred/learn" {
  capabilities = ["read"]
}
path "kv-v2/*" {
capabilities = ["read"]
}
path "kv-v2/secret1" {
  capabilities = ["read"]
}