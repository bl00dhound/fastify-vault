install:
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

stop:
	helm uninstall fastify-vault
