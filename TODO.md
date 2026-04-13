# Flutter API Connection Fix - TODO

## Status: In Progress

### Step 1: [✅ DONE] Add INTERNET permission to AndroidManifest.xml
- Edit `android/app/src/main/AndroidManifest.xml`

### Step 2: [✅ DONE] Update pubspec.yaml with connectivity_plus
- Add dependency ✓
- Run `flutter pub get` ✓

### Step 3: [✅ DONE] Create app_config.dart
- New file `lib/config/app_config.dart` ✓

### Step 4: [✅ DONE] Update api_service.dart
- Add timeout ✓, connectivity ✓, config baseUrl ✓, better errors ✓

### Step 5: [✅ DONE] Update register_screen.dart & login_screen.dart
- Add connectivity checks ✓
- Fix API baseUrl prefix ✓
- Fix duplicate /api in service URL ✓

### Step 6: [IN PROGRESS] Test & Verify
- `flutter pub get`
- `flutter run` (emulator/windows)
- Start backend at localhost:8000
- Test register/login ✓ (Fixing 302 redirect issue)

**Next Action:** Start Step 1
