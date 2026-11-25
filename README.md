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
Deploy this repository to Vercel with the included `vercel.json`. Build command: `flutter build web --release`; output directory: `build/web`. Ensure the Vercel build environment has Flutter stable installed (or use a custom build image/build pipeline that installs Flutter before invoking the command). Vercel does not include Flutter in its standard runtime by default.

## Build Android APK
```sh
flutter build apk --release
```
APK: `build/app/outputs/flutter-apk/app-release.apk`.

GitHub Actions validates/analyzes the project, builds web and APK, and uploads the APK as a workflow artifact. To publish a downloadable release, create and push a version tag, for example `git tag v1.0.0 && git push origin v1.0.0`. Then use the GitHub release asset link in Settings to make it available in-app.

## Important operational notes
- Data is stored locally on the device/browser profile. Clearing browser data or uninstalling the app can remove local records. No cloud synchronization or multi-device replication is included.
- The role selector is an operational UI control, not secure authentication or server-side authorization. Deploy with authenticated accounts and audited server-side permissions before using for regulated financial records.
- Reservoir level is an estimate: starting baseline + recorded refills − recorded dispensing. Configure baseline/capacity against physical tank measurements.
