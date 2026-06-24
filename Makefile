# Example from
# https://tech.davis-hansson.com/p/make/
# Also consider reference at: http://www.gnu.org/software/make/manual/

## Initial setup
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eux -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

## ------------------------- Main part of the build file
AppName := Fuwari
RealAppName := Fuwari-Secure

# Default - top level rule is what gets ran when you run just `make`
build:
> xcodebuild -scheme ${AppName} -configuration Debug
.PHONY: build

release: dist/${RealAppName}.app
.PHONY: release

install: dist/${RealAppName}.app
> [ -e "/Applications/${RealAppName}.app" ] && trash /Applications/${RealAppName}.app
> cp -a dist/${RealAppName}.app /Applications/${RealAppName}.app
.PHONY: install

dmg: dist/${AppName}.dmg
.PHONY: dmg

## ------------------------- helper

dist:
> mkdir -p dist

artifacts:
> mkdir -p artifacts

artifacts/${AppName}.xcarchive: artifacts $(shell rg --files ${AppName} | sed 's: :\\ :g')
> xcodebuild archive -archivePath $@ -scheme ${AppName} -configuration Release

dist/${RealAppName}.app: dist artifacts/${AppName}.xcarchive
> cp -R artifacts/${AppName}.xcarchive/Products/Applications/${RealAppName}.app dist/${RealAppName}.app
> touch $@

dist/${AppName}.dmg: dist/${RealAppName}.app
> rm -f $@
> create-dmg \
>   --volname "${RealAppName} Installer" \
>   --window-pos 200 120 \
>   --window-size 500 400 \
>   --icon-size 100 \
>   --icon "${RealAppName}.app" 100 100 \
>   --hide-extension "${RealAppName}.app" \
>   --app-drop-link 300 100 \
>   "$@" \
>   "dist/"
