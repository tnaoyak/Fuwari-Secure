AppName := Fuwari
RealAppName := Fuwari-Secure

# Default - top level rule is what gets ran when you run just `make`
build:
	xcodebuild -scheme $(AppName) -configuration Debug CODE_SIGN_IDENTITY="-" EXPANDED_CODE_SIGN_IDENTITY_NAME="-" EXPANDED_CODE_SIGN_IDENTITY="-"
.PHONY: build

release: dist/$(RealAppName).app
.PHONY: release

install: dist/$(RealAppName).app
	[ -e "/Applications/$(RealAppName).app" ] && trash /Applications/$(RealAppName).app
	cp -a dist/$(RealAppName).app /Applications/$(RealAppName).app
.PHONY: install

dmg: dist/$(AppName).dmg
.PHONY: dmg

## ------------------------- helper

dist:
	mkdir -p dist

artifacts:
	mkdir -p artifacts

artifacts/$(AppName).xcarchive: artifacts
	xcodebuild archive -archivePath $@ -scheme $(AppName) -configuration Release CODE_SIGN_IDENTITY="-" EXPANDED_CODE_SIGN_IDENTITY_NAME="-" EXPANDED_CODE_SIGN_IDENTITY="-"

dist/$(RealAppName).app: dist artifacts/$(AppName).xcarchive
	cp -R artifacts/$(AppName).xcarchive/Products/Applications/$(RealAppName).app dist/$(RealAppName).app
	touch $@

dist/$(AppName).dmg: dist/$(RealAppName).app
	rm -f $@
	create-dmg \
	  --volname "$(RealAppName) Installer" \
	  --window-pos 200 120 \
	  --window-size 500 400 \
	  --icon-size 100 \
	  --icon "$(RealAppName).app" 100 100 \
	  --hide-extension "$(RealAppName).app" \
	  --app-drop-link 300 100 \
	  "$@" \
	  "dist/"
