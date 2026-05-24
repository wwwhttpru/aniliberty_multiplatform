.PHONY: clean get codegen build-web run-web run-safari rename-app build-macos-dmg

clean:
	@echo "Cleaning the project"
	@flutter clean

get:
	@echo "Getting dependencies"
	@flutter pub get

codegen: get
	@echo "Running codegeneration"
	@flutter pub run build_runner build -d

build-web: get
	@echo "Build web"
	@flutter build web --wasm

run-web:get
	@echo "Run web"
	@flutter run -d chrome --wasm -t lib/main_web.dart --web-header=Cross-Origin-Opener-Policy=same-origin --web-header=Cross-Origin-Embedder-Policy=require-corp

# Запуск Flutter web в web-server, открытие Safari и автообновление при hot restart.
# Доп. аргументы: make run-safari ARGS="--release"
run-safari:
	@./scripts/run_safari.sh $(ARGS)

# Переименование приложения на всех платформах (Android, iOS, macOS, Web, Windows, Linux).
# Использование: make rename-app APP_NAME="Новое имя приложения"
rename-app:
	@if [ -z "$(APP_NAME)" ]; then \
		echo "Укажите имя: make rename-app APP_NAME=\"Имя приложения\""; \
		exit 1; \
	fi
	@./scripts/rename_app.sh "$(APP_NAME)"

# Сборка macOS .app (release, obfuscate, без codesign) и упаковка в DMG.
# Использование: make build-macos-dmg  или  make build-macos-dmg VERSION=1.0.0
build-macos-dmg:
	@./scripts/build_macos_dmg.sh $(VERSION)
