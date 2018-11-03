name ?= rstudio
root ?= ${PWD}

gc = \033[0;32m
nc = \033[0m

all: start

build:
	docker rmi ${name} || true
	docker build --tag ${name} .

link:
	echo "alias ${name}='make -f \"${PWD}/Makefile\" root=\"\$${PWD}\"'" >> ~/.bash_profile

shell:
	docker exec \
		--interactive \
		--tty \
		${name} \
		/bin/bash

start:
	@echo "Address:  ${gc}http://localhost:8787/${nc}"
	@echo "User:     ${gc}rstudio${nc}"
	@echo "Password: ${gc}password${nc}"
	@echo
	@echo 'Press CTRL-C to terminate...'
	@docker run \
		--env PASSWORD=password \
		--interactive \
		--name ${name} \
		--publish 8787:8787 \
		--rm \
		--tty \
		--volume "${root}:/home/${name}" \
		--workdir "/home/${name}" \
		${name} > /dev/null

.PHONY: all build link shell start
