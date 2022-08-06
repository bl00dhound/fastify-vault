install:
	helm repo add hashicorp https://helm.releases.hashicorp.com
	kubectl create namespace fastify-vault
	kubectl config set-context --current --namespace fastify-vault

helm-update:
	cd helm
	helm dep update
	cd ..

docker-build:
	docker build -t fastify:local .

start:
	helm install fastify-vault ./helm

start-vault:
	./scripts/start-vault.sh

stop-vault:
	./scripts/stop-vault.sh

forward-vault:
	kubectl port-forward svc/vault 8200

stop:
	helm uninstall fastify-vault
