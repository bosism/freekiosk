#!/usr/bin/env bash
# Drives the installed app on a running emulator over ADB and captures screenshots
# into $OUT (default: screenshots/). Used by .github/workflows/android-build.yml.
set -euo pipefail
PKG=com.freekiosk
OUT=${OUT:-screenshots}
mkdir -p "$OUT"

shot() { sleep "${2:-2}"; adb exec-out screencap -p > "$OUT/$1.png"; echo "captured $1"; }

# Tap the centre of the first UI node whose text or content-desc contains $1.
tap_text() {
  local needle=$1 tries=${2:-10}
  for _ in $(seq "$tries"); do
    adb shell uiautomator dump /sdcard/ui.xml >/dev/null 2>&1 || true
    adb pull /sdcard/ui.xml /tmp/ui.xml >/dev/null 2>&1 || true
    local xy
    xy=$(python3 - "$needle" <<'PY' || true
import re, sys
needle = sys.argv[1]
try:
    xml = open('/tmp/ui.xml', encoding='utf-8', errors='ignore').read()
except FileNotFoundError:
    sys.exit(1)
for m in re.finditer(r'<node [^>]*>', xml):
    node = m.group(0)
    text = re.search(r'text="([^"]*)"', node)
    desc = re.search(r'content-desc="([^"]*)"', node)
    if needle in ((text.group(1) if text else '') + ' ' + (desc.group(1) if desc else '')):
        b = re.search(r'bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', node)
        if b:
            x1, y1, x2, y2 = map(int, b.groups())
            print((x1 + x2) // 2, (y1 + y2) // 2)
            sys.exit(0)
sys.exit(1)
PY
)
    if [ -n "$xy" ]; then
      echo "tap '$needle' at $xy"
      adb shell input tap $xy
      return 0
    fi
    sleep 2
  done
  echo "could not find '$needle'"; return 1
}

# 7" 16:10 tablet geometry
adb shell wm size 1920x1200 || true
adb shell wm density 320 || true
adb shell settings put global window_animation_scale 0 || true
adb shell settings put global transition_animation_scale 0 || true
adb shell settings put global animator_duration_scale 0 || true

adb install -r -g "$APK"
adb shell pm grant $PKG android.permission.POST_NOTIFICATIONS 2>/dev/null || true
adb shell appops set $PKG SYSTEM_ALERT_WINDOW allow 2>/dev/null || true

# Launcher / app drawer with the ESP710 icon (best effort)
adb shell input keyevent KEYCODE_HOME; sleep 2
adb shell input swipe 960 1100 960 300 300 || true
shot 00-app-drawer 3
adb shell input keyevent KEYCODE_HOME

adb shell monkey -p $PKG -c android.intent.category.LAUNCHER 1 >/dev/null
sleep 20
shot 01-welcome 3

tap_text "Start Configuration" && shot 02-pin 3

# Default PIN is 1234
tap_text "••••" || true
adb shell input text 1234
sleep 1
tap_text "Validate" && shot 03-settings-general 5

for tab in Dashboard Display Security Advanced; do
  tap_text "$tab" && shot "04-settings-$(echo "$tab" | tr 'A-Z' 'a-z')" 3 || true
done

ls -la "$OUT"
