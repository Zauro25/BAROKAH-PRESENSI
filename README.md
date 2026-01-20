## Mobile-Based Study Session Attendance App

Flutter mobile app for digital attendance of religious study sessions with role-based dashboards (Pengurus/Santri), Firebase Auth/Firestore backend, and QR-based check-in.

### Features
- Firebase Authentication (email/password) with profile role (pengurus or santri).
- Study session management (create schedule, attach ustadz/teacher, generate QR for attendance).
- Attendance via QR scanner (camera) and history per user.
- Attendance recap per session with CSV export and share.
- Participant and teacher listings for Pengurus.

### Project Setup
1) Install Flutter (3.19+ recommended) and run `flutter doctor`.
2) Add Firebase config:
	- Install FlutterFire CLI: `dart pub global activate flutterfire_cli`.
	- Run `flutterfire configure` in the project folder.
	- Replace the placeholder values in `lib/firebase_options.dart` with the generated file contents (or overwrite the file entirely with the generated one).
3) Fetch dependencies: `flutter pub get`.
4) Run the app: `flutter run` (choose Android/iOS). For web, ensure you add the web Firebase config.

### Platform Notes
- Android: Camera permission is declared in `android/app/src/main/AndroidManifest.xml`.
- iOS: Camera usage description is in `ios/Runner/Info.plist`. Ensure your Firebase iOS bundle ID matches the Xcode target.

### Data Model (Firestore)
- `users/{uid}`: name, email, role (pengurus/santri), phone.
- `sessions/{id}`: title, teacherName, location, scheduledAt, qrCode.
- `attendance/{sessionId_uid}`: sessionId, userId, userName, timestamp, method, status.
- `teachers/{id}`: name, topic, notes.

### Testing Checklist
- Register Pengurus and create a session; display QR.
- Scan QR as Santri; verify record appears in session detail and history.
- Export CSV from session detail or Reports tab and share the file.
- Sign out/in flows for both roles.
