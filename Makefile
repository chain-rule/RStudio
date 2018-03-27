name ?= rstudio
root ?= ${PWD}

gc = \033[0;32m
nc = \033[0m

all: start

image:
	docker rmi ${name} || true
	docker build -t ${name} .

start:
	@echo "Address:  ${gc}http://localhost:8787/${nc}"
	@echo "User:     ${gc}rstudio${nc}"
	@echo "Password: ${gc}rstudio${nc}"
	@docker run \
		--interactive \
		--tty \
		--rm \
		--name ${name} \
		-v "${root}:/home/rstudio" \
		-w /home/rstudio \
		-p 8787:8787 \
		${name} > /dev/null

.PHONY: all image start
