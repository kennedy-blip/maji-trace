# MajiTrace

Offline-first water kiosk, borehole refill and fault ledger built with Flutter and Dart for Android and the web.

## Features
- Dispensing ledger with customer, quantity, tariff, paid amount, payment mode and outstanding balance.
- Refill batches and estimated reservoir level with low-level warning.
- Urgent/routine fault reporting and admin resolution.
- Admin/staff role switch, three themes and local Hive persistence.
- CSV ledger export (copied to clipboard).
- Responsive bottom navigation and frosted glass UI.

## Requirements
Flutter stable (Dart 3.3+), Android SDK for APK builds.

## Run locally
```sh
flutter pub get
flutter run -d chrome
# or
flutter run
```

## Build web for Vercel
```sh
flutter pub get
flutter build web --release
```
Deploy this repository to Vercel with the included `vercel.json`. The configured build script installs Flutter stable, generates the web platform scaffold, runs `flutter pub get`, and builds the static site into `build/web`. Vercel's build environment must permit cloning the Flutter SDK; first builds can take longer because the SDK is downloaded.

## Build Android APK
```sh
flutter build apk --release
```
APK: `build/app/outputs/flutter-apk/app-release.apk`.

GitHub Actions generates the Android/web platform scaffolding, formats and analyzes Dart, runs tests, builds web and APK, uploads the APK artifact, and updates the rolling `latest` GitHub Release. The Settings download action opens `https://github.com/kennedy-blip/maji-trace/releases/latest/download/app-release.apk`. The link becomes available after the first successful Actions build.

## Important operational notes
- Data is stored locally on the device/browser profile. Clearing browser data or uninstalling the app can remove local records. No cloud synchronization or multi-device replication is included.
- The role selector is an operational UI control, not secure authentication or server-side authorization. Deploy with authenticated accounts and audited server-side permissions before using for regulated financial records.
- Reservoir level is an estimate: starting baseline + recorded refills − recorded dispensing. Configure baseline/capacity against physical tank measurements.
