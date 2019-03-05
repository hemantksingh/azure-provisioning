.PHONY: build package push test

IMAGE?=hemantksingh/ansible
CONTAINER?=ansible

build:
	docker build -t $(IMAGE) .

run: build
	docker rm -f $(CONTAINER) 2>/dev/null
	docker run -it --name $(CONTAINER) -v ~/.azure:/root/.azure $(IMAGE)