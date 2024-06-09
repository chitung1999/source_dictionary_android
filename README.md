# Dictionary App
## Overview
The Dictionary application helps look up, take notes and review learned 
words.
### Functions:
- Take notes on learned words.
- Look up the dictionary using API request.
- Play a game to review learned words.
- Voice chat with AI.

### Supported platforms:
- Windows
- Linux

### Framework/Programming
- Flutter
- Dart

## Release
### Change app name
- Android: ../adroid/app/src/main/AndroidManifest.xml
```bash
android:label="MY_APP_NAME"
```
- iOS: ../ios/Runner/Info.plist
```bash
<key>CFBundleDisplayName</key>
<string>Dictionary</string>
```
### Change app icon
Add package to pubspec.yaml
```bash
dev_dependencies:
  flutter_launcher_icons: ^0.13.1 <- version package
  ...

flutter_icons:
  android: true
  ios: true
  image_path: ".png" <- icon path
```
### Build release
1. For Android
Run command:
```bash
flutter build apk --split-per-abi
```
Go to ..\build\app\outputs\flutter-apk
- app-armeabi-v7a-release.apk (android 32 bit)
- app-arm64-v8a-release.apk (android 64 bit)
- app-x86_64-release.apk (emulator)

2. For iOS