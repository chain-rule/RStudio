name ?= rstudio

all: start

image:
	docker rmi ${name} || true
	docker build -t ${name} .

start:
	docker run \
		--interactive \
		--tty \
		--rm \
		--name ${name} \
		-v "$${PWD}:/home/rstudio" \
		-w /home/rstudio \
		-p 8787:8787 \
		${name}

.PHONY: all image start
