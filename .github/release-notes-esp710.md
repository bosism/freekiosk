ESP710-branded build of [FreeKiosk](https://github.com/rushb-fr/freekiosk) for the ESP710 tablet, which runs the ESP710 QGroundControl build as its external app.

## What is in this build

- App name **ESP710**, white wordmark on black, matching launcher icon.
- Black theme with near-black surfaces, light grey text and the amber `#f0b429` accent of the QGC-Stealth skin.
- Everything else is upstream FreeKiosk 2.0.0-beta.3: WebView / media / external-app modes, REST API, MQTT, Device Owner provisioning. Package name is unchanged (`com.freekiosk`), so the upstream [ADB](https://github.com/rushb-fr/freekiosk/blob/main/docs/adb-configuration.md) and provisioning docs apply as-is.
- GitHub-release variant: accessibility service included, signed with the debug keystore.

## Install

```bash
adb install -r __APK__
# optional, lets the accessibility service turn itself on:
adb shell pm grant com.freekiosk android.permission.WRITE_SECURE_SETTINGS
```

Do not use the in-app "Check for updates": it fetches upstream FreeKiosk and would replace this skin.

`__APK__` SHA-256: `__SHA256__`

## Screenshots

| Welcome | PIN |
|---|---|
| ![welcome](https://raw.githubusercontent.com/bosism/freekiosk/__TAG__/docs/screenshots/01-welcome.png) | ![pin](https://raw.githubusercontent.com/bosism/freekiosk/__TAG__/docs/screenshots/02-pin.png) |

| Settings | Display |
|---|---|
| ![settings](https://raw.githubusercontent.com/bosism/freekiosk/__TAG__/docs/screenshots/03-settings-general.png) | ![display](https://raw.githubusercontent.com/bosism/freekiosk/__TAG__/docs/screenshots/04-settings-display.png) |

Built from commit __SHA__ by the `Android APK` workflow.
