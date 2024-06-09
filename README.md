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
For Android
1. Run command:
```bash
flutter build apk --split-per-abi
```
2. Go to ..\build\app\outputs\flutter-apk
- app-armeabi-v7a-release.apk (android 32 bit)
- app-arm64-v8a-release.apk (android 64 bit)
- app-x86_64-release.apk (emulator)

For iOS
1. Install AltStoreServer on MacOS and AltStore on iPhone/iPad
2. Push source code to github
3. Github: Repo -> Actions -> Dart -> Configure
```bash
name: iOS-ipa-build

on:
  workflow_dispatch:

jobs:
  build-ios:
    name: 🎉 iOS Build
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3

      - uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          architecture: x64
      - run: flutter pub get
      

      - run: pod repo update
        working-directory: ios

      - run: flutter build ios --release --no-codesign

      - run: mkdir Payload
        working-directory: build/ios/iphoneos

      - run: mv Runner.app/ Payload
        working-directory: build/ios/iphoneos

      - name: Zip output
        run: zip -qq -r -9 ${{ github.event.repository.name }}.ipa Payload
        working-directory: build/ios/iphoneos

      - name: Upload binaries to release
        uses: svenstaro/upload-release-action@v2
        with:
          repo_token: ${{ secrets.GITHUB_TOKEN }}
          file: build/ios/iphoneos/${{ github.event.repository.name }}.ipa
          tag: ${{ github.run_number }}
          overwrite: true
```
4. Github: Repo -> Setting -> Actions -> General -> Workflow permissions -> Read and write permissions
5. Github: Repo -> Code -> Releases -> Download file .ipa and copy to iphone
6. Connect iphone with AltStore(MacOS)
6. In Iphone: AltStore -> My Apps -> add this file .ipa
