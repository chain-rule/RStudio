# The name of the Docker image
name := rstudio
# The directory to be mounted to the container
root ?= ${PWD}

this := $(shell dirname $(realpath $(lastword ${MAKEFILE_LIST})))

gc = \033[0;32m
nc = \033[0m

all: start

# Create an alias for starting a new container
alias:
	echo "alias ${name}='make -C \"${PWD}\" root=\"\$${PWD}\"'" >> ~/.$(if ${ZSH_NAME},bash,zsh)rc

# Build a new image
build:
	docker rmi ${name} || true
	docker build --tag ${name} .

# Start a new container
start: ${root}/.rstudio
	@echo "Address:  ${gc}http://localhost:8787/${nc}"
	@echo "User:     ${gc}rstudio${nc}"
	@echo "Password: ${gc}password${nc}"
	@echo
	@echo 'Press Control-C to terminate...'
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

# Start a shell in a running container
shell:
	@docker exec --interactive --tty ${name} /bin/bash

${root}/.rstudio:
	@cp -R "${this}/.rstudio" "$@"
	@make -C "$@" > /dev/null

ifdef profile
profile:
	cp -a .profile/${profile}/. .rstudio/
endif

.PHONY: all alias build start shell profile
