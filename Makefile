package = lazy-foo

stack = stack

docker = docker

tmsPid = $(shell pgrep ExaTMS)

# e.g.   make format path=app/Main.hs
format:
	ormolu --mode inplace $(path)

# e.g.   make lint path=app/Main.hs
lint:
	$(stack) exec hlint $(path)

clean:
	$(stack) clean

purge:
	$(stack) purge

build:
	$(stack) build --fast --ghc-options -j4

run: build
	$(stack) exec -- $(package) +RTS -maxN6 -RTS

stop:
	kill $(tmsPid)

ghci:
	$(stack) ghci $(package):lib --ghci-options='-j4 +RTS -A128m'

test:
	$(stack) build --test --fast --ghc-options -j4

test-ghci:
	$(stack) ghci $(package):test:$(package)-tests --ghci-options='-j4 +RTS -A128m'

ghcid:
	$(stack) exec ghcid -- -c "stack ghci $(package):lib --test --ghci-options='-fobject-code -fno-warn-unused-do-bind -j4 +RTS -A128m' --main-is $(package):$(package)"

reset-db:
	$(docker)/rm
	$(docker)/setup

dev-deps:
	# install ormolu in its own workspace with stack install
	$(stack) install ghcid hlint

.PHONY : format lint clean build run stop ghci test test-ghci ghcid reset-db dev-deps