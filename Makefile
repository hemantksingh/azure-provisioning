.PHONY: build run deploy

IMAGE?=hemantksingh/ansible
CONTAINER?=ansible
TARGET_ENV?=dev
APP_VERSION?=f9c11f55cd2943583b891b3e118d8797eb72097a
AZURE_PACKAGE_SOURCE=refinementpackages

build:
	docker build -t $(IMAGE) .

cleanup:
	@docker ps -aq -f name=$(CONTAINER) | grep -q . \
		&& docker rm -f $(CONTAINER) || echo No container to remove

run: build cleanup
	docker run --rm --name $(CONTAINER) \
		-e TARGET_ENV=$(TARGET_ENV) \
		-v ~/.azure:/root/.azure $(IMAGE)

deploy: build cleanup
	docker run --rm --name $(CONTAINER) \
		-e TARGET_ENV=$(TARGET_ENV) \
		-e AZURE_CLIENT_ID=$(AZURE_CLIENT_ID) \
		-e AZURE_SECRET=$(AZURE_SECRET) \
		-e AZURE_SUBSCRIPTION_ID=$(AZURE_SUBSCRIPTION_ID) \
		-e AZURE_TENANT=$(AZURE_TENANT) \
		-e APP_VERSION=$(APP_VERSION) \
		-e AZURE_PACKAGE_SOURCE=$(AZURE_PACKAGE_SOURCE) \
		-e AZURE_STORAGE_ACCESS_KEY=$(AZURE_STORAGE_ACCESS_KEY) \
		-e AZURE_SQLSERVER_USERNAME=$(AZURE_SQLSERVER_USERNAME) \
		-e AZURE_SQLSERVER_PASSWORD=$(AZURE_SQLSERVER_PASSWORD) \
		$(IMAGE)