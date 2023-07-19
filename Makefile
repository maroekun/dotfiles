DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*) dotbin zsh.d vim
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml .vimrc
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all: list
help:
	@echo "make list  #=> Show dot files in this repo"
list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
deploy:
	@echo "---> Run make deploy"
	@echo "---> Create symbol 'dotfiles/.??' files to HOME directory "
	@echo ""
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
init:
	@echo "---> Run initialized"
	@echo "---> !!! NOT IMPLEMENT !!!"
update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
clean:
	@echo "---> Run make clearn"
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)
