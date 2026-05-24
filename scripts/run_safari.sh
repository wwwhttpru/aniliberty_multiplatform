#!/usr/bin/env bash
# Запуск Flutter web в web-server с автоматическим открытием Safari и обновлением при hot restart.
# Использование: ./scripts/run_safari.sh [аргументы для flutter run]
# Или: make run-safari
# Или: make run-safari ARGS="--release"

set -e

echo "Starting Flutter web server and watching for hot restarts..."
PORT=""
flutter run -d web-server "$@" | while read -r line; do
	echo "$line"
	if [ -z "$PORT" ]; then
		if [[ "$line" =~ is\ being\ served\ at\ http://localhost:([0-9]+) ]]; then
			PORT="${BASH_REMATCH[1]}"
			echo "----------------------------------------------------"
			echo "Detected Flutter on port: $PORT. Watching for restarts."
			echo "----------------------------------------------------"
			open -a Safari "http://localhost:$PORT"
		fi
	fi
	if [ -n "$PORT" ] && [[ "$line" == *"Restarted application in"* ]]; then
		echo "Hot restart detected. Refreshing Safari..."
		osascript -e "tell application \"Safari\" to repeat with t in tabs of windows \
		if URL of t is \"http://localhost:$PORT/\" then \
			set URL of t to (URL of t) \
		end if \
		end repeat"
	fi
done
