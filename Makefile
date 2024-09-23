
SASS = $(APPDATA)\npm\sass.cmd

all: dist/main.js dist/index.html dist/main.css pics

dist/main.js: src/Main.elm src/Shared.elm src/Icons.elm src/Updates.elm src/Views.elm
	elm make src/Main.elm --output=dist/main.js --debug

dist/index.html: artifacts/index.html
	copy artifacts\index.html dist /y

dist/main.css: artifacts/main.scss
	$(SASS) artifacts\main.scss dist\main.css --no-source-map

pics:
	xcopy artifacts\favicon.ico dist /d /y
	xcopy artifacts\*.png dist /d /y
