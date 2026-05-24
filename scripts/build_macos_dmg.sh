#!/usr/bin/env bash
# Сборка macOS-приложения (release, obfuscate, без codesign) и упаковка в DMG.
# Использование: ./scripts/build_macos_dmg.sh [VERSION]
#   VERSION — опционально, например 1.0.0 (по умолчанию берётся из pubspec.yaml).

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"

# Версия из аргумента или из pubspec
VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: *//; s/+.*//')
fi

echo "=== Сборка macOS (без codesign, с obfuscate) ==="
echo "Версия: $VERSION"
echo ""

# Зависимости
flutter pub get

# Codegen (как в release workflow)
if grep -q "build_runner" pubspec.yaml 2>/dev/null; then
  echo "Запуск build_runner..."
  flutter pub run build_runner build -d
fi

# Сборка без подписи: отключаем codesign и команду разработчика
export CODE_SIGN_IDENTITY="-"
export CODE_SIGN_STYLE="Manual"
export DEVELOPMENT_TEAM=""

echo "Сборка release с obfuscate..."
flutter build macos --release \
  --target lib/main.dart \
  --obfuscate \
  --split-debug-info=build/symbols/macos

# Путь к .app (имя может быть из AppInfo.xcconfig — PRODUCT_NAME или дефолтное)
RELEASE_DIR="build/macos/Build/Products/Release"
APP_PATH=$(find "$RELEASE_DIR" -maxdepth 1 -name "*.app" -type d | head -n 1)
if [ -z "$APP_PATH" ] || [ ! -d "$APP_PATH" ]; then
  echo "Ошибка: не найден .app в $RELEASE_DIR" >&2
  exit 1
fi

APP_NAME=$(basename "$APP_PATH" .app)
DMG_NAME="${APP_NAME}-${VERSION}-macos.dmg"
DMG_PATH="build/$DMG_NAME"

echo ""
echo "=== Упаковка в DMG ==="
echo "Приложение: $APP_PATH"
echo "DMG: $DMG_PATH"

# create-dmg должен быть установлен: brew install create-dmg
if ! command -v create-dmg &>/dev/null; then
  echo "Ошибка: create-dmg не найден. Установите: brew install create-dmg" >&2
  exit 1
fi

# Временная папка для содержимого DMG (create-dmg сам добавит ссылку на Applications)
DMG_TMP="build/dmg_tmp"
rm -rf "$DMG_TMP"
mkdir -p "$DMG_TMP"
cp -R "$APP_PATH" "$DMG_TMP/"

# Создаём DMG через create-dmg (--app-drop-link добавляет ссылку на /Applications)
create-dmg \
  --volname "$APP_NAME" \
  --window-size 600 400 \
  --app-drop-link 400 200 \
  --no-internet-enable \
  "$DMG_PATH" \
  "$DMG_TMP"

rm -rf "$DMG_TMP"

echo ""
echo "Готово."
echo "  DMG: $DMG_PATH"
echo "  Символы (split-debug-info): build/symbols/macos/"
