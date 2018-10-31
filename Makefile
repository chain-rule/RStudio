name ?= rstudio
root ?= ${PWD}

gc = \033[0;32m
nc = \033[0m

build:
	docker rmi ${name} || true
	docker build --tag ${name} .

link:
	@echo "alias ${name}='make -f \"${PWD}/Makefile\" root=\"\$${PWD}\" start'" >> ~/.bash_profile

start:
	@echo "Address:  ${gc}http://localhost:8787/${nc}"
	@echo "User:     ${gc}rstudio${nc}"
	@echo "Password: ${gc}password${nc}"
	@echo
	@echo 'Press CTRL-C to terminate...'
	@docker run \
		--interactive \
		--tty \
		--rm \
		--name ${name} \
		--env PASSWORD=password \
		--volume "${root}:/home/${name}" \
		--workdir "/home/${name}" \
		--publish 8787:8787 \
		${name} > /dev/null

.PHONY: build link start
