#! /bin/sh

helm install vault hashicorp/vault --set "server.dev.enabled=true"
sleep 15
kubectl exec -ti vault-0 -- \
vault secrets enable -path=tenant-kv kv-v2 

kubectl exec -ti vault-0 -- \
vault kv put tenant-kv/rds/fastify username="fastify" password="fastifyPassword" host="rds" database="fastify" port="5432"

kubectl exec -ti vault-0 -- \
vault auth enable -path=tenant-kubernetes kubernetes 

kubectl exec -ti vault-0 -- sh -c '\
vault write auth/tenant-kubernetes/config \
  token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
  kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
  kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt disable_iss_validation=true'

kubectl exec -ti vault-0 -- sh -c '\
vault policy write fastify-app - <<EOF
path "tenant-kv/data/rds/fastify" {
  capabilities = ["read"]
}
EOF'

kubectl exec -ti vault-0 -- \
vault write auth/tenant-kubernetes/role/tenant-role \
    bound_service_account_names=fastify-app \
    bound_service_account_namespaces=fastify-vault \
    policies=fastify-app \
    ttl=24h
