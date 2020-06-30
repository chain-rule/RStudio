# The name of the Docker image
name := rstudio
# The directory to be mounted to the container
root ?= ${PWD}

all: start

# Create an alias for starting a new container
alias:
	@echo "alias ${name}='make -C \"${PWD}\" root=\"\$${PWD}\"'"

# Build a new image
build:
	docker build --tag ${name} .

# Start a new container
start:
	@echo 'Address:  http://localhost:8787/'
	@echo
	@echo 'Press Control-C to terminate...'
	@docker run --interactive --tty --rm \
		--name ${name} \
		--publish 8787:8787 \
		--volume "${root}:/home/rstudio/$(shell basename ${root})" \
		--env DISABLE_AUTH=true \
		${name} > /dev/null

# Start a shell in a running container
shell:
	@docker exec --interactive --tty ${name} /bin/bash

.PHONY: all alias build start shell
