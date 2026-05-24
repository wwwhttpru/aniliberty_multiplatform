#!/usr/bin/env bash
# Переименование Flutter-приложения на всех платформах (Android, iOS, macOS, Web, Windows, Linux).
# Использование: ./scripts/rename_app.sh "Новое имя приложения"
# Или: make rename-app APP_NAME="Новое имя приложения"

set -e

APP_NAME="${1:?Укажите имя приложения: $0 \"Имя приложения\"}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Экранирование для подстановки в sed (replacement: \ и &)
escape_sed() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/&/\\&/g'
}

REPL_SED="$(escape_sed "$APP_NAME")"

echo "Переименование приложения в: $APP_NAME"
echo "Корень проекта: $PROJECT_ROOT"
cd "$PROJECT_ROOT"

# --- Android ---
echo "  Android..."
sed -i.bak "s/android:label=\"[^\"]*\"/android:label=\"$REPL_SED\"/" android/app/src/main/AndroidManifest.xml
rm -f android/app/src/main/AndroidManifest.xml.bak

# --- iOS ---
echo "  iOS..."
sed -i.bak "/<key>CFBundleDisplayName<\\/key>/{n;s/<string>.*<\\/string>/<string>$REPL_SED<\\/string>/;}" ios/Runner/Info.plist
sed -i.bak "/<key>CFBundleName<\\/key>/{n;s/<string>.*<\\/string>/<string>$REPL_SED<\\/string>/;}" ios/Runner/Info.plist
rm -f ios/Runner/Info.plist.bak

# --- macOS ---
echo "  macOS..."
sed -i.bak "s/^PRODUCT_NAME = .*/PRODUCT_NAME = $REPL_SED/" macos/Runner/Configs/AppInfo.xcconfig
rm -f macos/Runner/Configs/AppInfo.xcconfig.bak

# --- Web ---
echo "  Web..."
sed -i.bak "s/<title>.*<\\/title>/<title>$REPL_SED<\\/title>/" web/index.html
sed -i.bak "s/name=\"apple-mobile-web-app-title\" content=\"[^\"]*\"/name=\"apple-mobile-web-app-title\" content=\"$REPL_SED\"/" web/index.html
sed -i.bak "s/class=\"splash-logo\" alt=\"[^\"]*\"/class=\"splash-logo\" alt=\"$REPL_SED Logo\"/" web/index.html
rm -f web/index.html.bak
sed -i.bak "s/\"name\":\"[^\"]*\"/\"name\":\"$REPL_SED\"/" web/manifest.json
sed -i.bak "s/\"short_name\":\"[^\"]*\"/\"short_name\":\"$REPL_SED\"/" web/manifest.json
rm -f web/manifest.json.bak

# --- Windows ---
echo "  Windows..."
sed -i.bak "s/Create(L\"[^\"]*\", origin/Create(L\"$REPL_SED\", origin/" windows/runner/main.cpp
rm -f windows/runner/main.cpp.bak
for key in FileDescription InternalName ProductName; do
  sed -i.bak "s/\(VALUE \"$key\", \"\)[^\"]*\(\" \"\\\\0\"\)/\1$REPL_SED\2/" windows/runner/Runner.rc
done
sed -i.bak "s/\(VALUE \"OriginalFilename\", \"\)[^\"]*\.exe\(\" \"\\\\0\"\)/\1$REPL_SED.exe\2/" windows/runner/Runner.rc
rm -f windows/runner/Runner.rc.bak

# --- Linux ---
echo "  Linux..."
for f in linux/my_application.cc linux/runner/my_application.cc; do
  if [ -f "$f" ]; then
    sed -i.bak "s/gtk_header_bar_set_title(header_bar, \"[^\"]*\")/gtk_header_bar_set_title(header_bar, \"$REPL_SED\")/" "$f"
    sed -i.bak "s/gtk_window_set_title(window, \"[^\"]*\")/gtk_window_set_title(window, \"$REPL_SED\")/" "$f"
    rm -f "${f}.bak"
  fi
done

echo "Готово."
