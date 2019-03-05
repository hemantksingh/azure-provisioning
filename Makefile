.PHONY: build package push test

IMAGE?=hemantksingh/ansible
CONTAINER?=ansible

build:
	docker build -t $(IMAGE) .

run:
	#docker rm $(docker ps -q -f name=$(CONTAINER) 2>/dev/null) 2>/dev/null
	docker run -it --name $(CONTAINER) -v ~/.azure:/root/.azure $(IMAGE)