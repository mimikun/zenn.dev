.DEFAULT_GOAL := help

## Create a patch and copy it to windows
.PHONY : patch
patch : clean diff-patch copy2win-patch

## Create a patch
.PHONY : diff-patch
diff-patch :
	mise tasks run patch:create

## Create a patch branch
.PHONY : patch-branch
patch-branch :
	mise tasks run patch:branch

## Switch to master branch
.PHONY : switch-master
switch-master :
	mise tasks run git:switch-master

## Run clean
.PHONY : clean
clean :
	mise tasks run clean

## Copy patch to Windows
.PHONY : copy2win-patch
copy2win-patch :
	mise tasks run patch:copy2win

## Run lints
.PHONY : lint
lint :
	mise tasks run lint

## Run format
.PHONY : format
format :
	mise tasks run format

## Run tests
.PHONY : test
test : lint

## Run format
.PHONY : fmt
fmt : format

## Delete patch branch
.PHONY : delete-branch
delete-branch :
	mise tasks run git:delete-branch

## Run git cleanfetch
.PHONY : clean-fetch
clean-fetch :
	mise tasks run git:clean-fetch

## Run git pull
.PHONY : pull
pull :
	mise tasks run git:pull

## Run workday morning routine
.PHONY : morning-routine
morning-routine :
	mise tasks run git:morning-routine

## Show help
.PHONY : help
help :
	@make2help $(MAKEFILE_LIST)
