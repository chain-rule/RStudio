name ?= rstudio
root ?= ${PWD}

gc = \033[0;32m
nc = \033[0m

alias:
	@echo "alias ${name}='make -f \"${PWD}/Makefile\" root=\"\$${PWD}\" start'" >> ~/.bash_profile

image:
	docker rmi ${name} || true
	docker build --tag ${name} .

start:
	@echo "Address:  ${gc}http://localhost:8787/${nc}"
	@echo "User:     ${gc}rstudio${nc}"
	@echo "Password: ${gc}rstudio${nc}"
	@echo
	@echo 'Press CTRL-C to terminate...'
	@docker run \
		--interactive \
		--tty \
		--rm \
		--name ${name} \
		--volume "${root}:/home/${name}" \
		--workdir "/home/${name}" \
		--publish 8787:8787 \
		${name} > /dev/null

.PHONY: alias image start