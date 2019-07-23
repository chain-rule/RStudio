# The name of the Docker image
name := rstudio
# The directory to be mounted to the container
root ?= ${PWD}

this := $(shell dirname $(realpath $(lastword ${MAKEFILE_LIST})))

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
	@echo "Address:  http://localhost:8787/"
	@echo "User:     rstudio"
	@echo "Password: rstud10"
	@echo
	@echo 'Press Control-C to terminate...'
	@docker run --interactive --tty --rm \
		--name ${name} \
		--publish 8787:8787 \
		--volume "${root}:/home/rstudio" \
		--env PASSWORD=rstud10 \
		${name}

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
