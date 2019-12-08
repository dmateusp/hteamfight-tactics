.DEFAULT_GOAL = help

export SHELL = /bin/bash
PROJECT_NAME := hteamfight-tactics

.PHONY: build
build: lint  ## Build the project and binaries
	stack build $(STACK_OPTS) $(PROJECT_NAME)

.PHONY: lint
lint:  ## Lint
	hlint src
	find src -name '*.hs' | xargs stylish-haskell -i

.PHONY: hoogle
hoogle:  ## Start hoogle server
	stack hoogle --server

.PHONY: hoogle-reindex
hoogle-reindex:  ## Reindex hoogle server
	stack hoogle --server --rebuild

.PHONY: clean
clean:  ## Clean
	stack clean

.PHONY: clobber
clobber: clean  ## Clean and remove stack's working directory
	rm -rf .stack-work/*

.PHONY: ghcid-devel
ghcid-devel:  ## Low-feature ghc-based IDE
	ghcid --command "stack ghci $(PROJECT_NAME)"

.PHONY: setup
setup:  ## Install required tools for this project
	stack install hlint stylish-haskell

.PHONY: help
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
