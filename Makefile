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