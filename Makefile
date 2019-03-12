.PHONY: build package push test

IMAGE?=hemantksingh/ansible
CONTAINER?=ansible
TARGET_ENV?=dev

build:
	docker build -t $(IMAGE) .

run: build
	docker rm -f $(CONTAINER) 2>/dev/null
	docker run -it --name $(CONTAINER) \
		-e TARGET_ENV=$(TARGET_ENV) \
		-v ~/.azure:/root/.azure $(IMAGE)

deploy: build
	docker rm -f $(CONTAINER) 2>/dev/null
	docker run -it --name $(CONTAINER) \
		-e TARGET_ENV=$(TARGET_ENV) \
		-e AZURE_CLIENT_ID=$(AZURE_CLIENT_ID) \
		-e AZURE_SECRET=$(AZURE_SECRET) \
		-e AZURE_SUBSCRIPTION_ID=$(AZURE_SUBSCRIPTION_ID) \
		-e AZURE_TENANT=$(AZURE_TENANT) \
		$(IMAGE)