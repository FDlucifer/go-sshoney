.PHONY: all clean
.DEFAULT_GOAL := all

PORT ?= 2222
DEBUG ?= false

deps:
	go get ./...

test:
	go test

all: deps test build

build:
	go build

clean:
	rm -f sshoney

run:
	DEBUG="$(DEBUG)" PORT="$(PORT)" go run cmd/sshoney/main.go $(filter-out $@, $(MAKECMDGOALS))

gen_ssh_key:
	@ssh-keygen -N '' -f host.key

show_iptables_rule:
	@echo "=========================================================================================="
	@echo "WARNING: Please, please be very careful when adding this rule you don't lock yourself out!"
	@echo "=========================================================================================="
	@echo
	@echo "sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 22 -j REDIRECT --to-port $(PORT)"
