# Shiksha Anudan

Shiksha Anudan is a Flutter application that connects students who need
financial assistance with donors who want to support education.

The project currently contains the student and donor mobile application. The
administrator application is maintained separately in
[shiksha_Admin_app](https://github.com/shivasharma9896/shiksha_Admin_app).

## Current project status

**Status: functional college-project prototype**

The application works for local development and demonstration. Student
registration has been verified against local Firebase emulators, including
Firebase Authentication, Cloud Firestore, and Firebase Storage.

The application is **not approved for production release yet**. The main
remaining work is:

- Configure and verify production Firebase Storage.
- Complete live image and document upload testing.
- Finish student, donor, administrator, login, password-reset, and failure-path
  testing.
- Migrate the administrator application to the current student data structure.
- Add trusted payment verification before enabling real donations.
- Complete release, security, privacy, monitoring, and backup checks.

## Main features

### Student features

- Create a student account.
- Submit personal, education, and financial-aid details.
- Upload registration documents.
- View application and funding progress.
- View and update permitted profile information.
- Sign in and request a password reset.

### Donor features

- Create a donor account.
- Sign in to the donor area.
- Search for eligible students.
- View approved student information.
- Review donation history.

### Administrator features

Administrator functionality is provided by the separate
[shiksha_Admin_app](https://github.com/shivasharma9896/shiksha_Admin_app).
It is intended to support student review, approval, blocking, donor
management, and transaction monitoring.

The administrator app currently expects legacy `Student/{uid}` documents,
while this application creates `StudentPublic/{uid}` and
`StudentPrivate/{uid}`. These applications must use the same schema before the
complete administrator workflow can be tested.

## Technology

- Flutter
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Material Design

## Firebase data structure

The current security model separates public and private information:

| Collection | Purpose |
|---|---|
| `StudentPublic/{uid}` | Education information, funding request, status, and approved-profile data |
| `StudentPrivate/{uid}` | Contact details, Aadhaar number, date of birth, and private document paths |
| `Donor/{uid}` | Donor profile information |
| `transaction/{id}` | Donation records created by a trusted backend or administrator process |

Student and donor identity documents are intended to be stored under:

```text
studentDocuments/{uid}/...
donorDocuments/{uid}/...
```

The mobile client must not create or modify payment records or raised-total
values. A payment provider callback alone is not sufficient proof of payment.

## Local setup

### Requirements

1. Install Flutter.
2. Install Node.js and npm.
3. Install the Firebase CLI.
4. Configure an Android emulator or physical Android device.
5. Add the Firebase configuration files for the intended Firebase project.

### Run the application

```bash
flutter pub get
flutter run
```

Do not use test flags when connecting to a production Firebase project.

## Local Firebase emulator testing

The repository includes local rules tests and an Android integration test. The
emulators prevent test data from reaching the production Firebase project.

### Run Firebase rules tests

From the repository root:

```bash
cd firebase-tests
npm ci
npm test
```

The rules test suite uses local emulators on these ports:

| Service | Port |
|---|---:|
| Firebase Authentication | 9099 |
| Cloud Firestore | 8080 |
| Firebase Storage | 9199 |

### Run the student registration integration test

Start the Firebase emulators first, then run:

```bash
flutter test integration_test/student_registration_test.dart \
  -d <android-device> \
  --dart-define=USE_FIREBASE_EMULATORS=true \
  --dart-define=USE_TEST_DATA=true
```

The test uses synthetic values and deterministic test files. It verifies:

- Student account creation.
- Authentication state.
- `StudentPublic/{uid}` creation.
- `StudentPrivate/{uid}` creation.
- Profile-photo upload.
- Signature upload.
- Identity-document upload.

`USE_FIREBASE_EMULATORS=true` routes Firebase services to local emulators.
`USE_TEST_DATA=true` enables deterministic test values. Never use
`USE_TEST_DATA=true` with a production Firebase project.

## Testing status

### Completed locally

- Home-screen widget regression test.
- Student registration validation and navigation.
- Student registration with local Auth, Firestore, and Storage emulators.
- Firebase Auth, Firestore, and Storage rules tests.
- Login error handling improvements.
- Password-reset success and invalid-email error handling.
- Loading-state cleanup.
- Protection against empty-profile crashes.

### Still required

- Donor registration end-to-end testing after production Storage is configured.
- Emulator-backed student login testing.
- Emulator-backed donor login testing.
- Live password-reset email delivery testing.
- Complete administrator login and workflow testing.
- Complete approve/block testing using the shared student schema.
- Release-build testing without emulator or test-data flags.
- Device compatibility, accessibility, privacy, and security testing.

### User testing report

The current testing result is:

**Local integration verified. Live Firebase partially verified. Production
release not yet approved.**

One live test created a temporary Firebase Authentication account. Review and
remove that test account before using the production project with real users.

## Security and deployment requirements

Before deploying rules or using real user data:

1. Back up Firestore and Storage.
2. Confirm the selected Firebase project.
3. Deploy and review Firestore and Storage rules.
4. Migrate legacy `Student/{uid}` records to `StudentPublic/{uid}` and
   `StudentPrivate/{uid}`.
5. Move identity documents to the current document paths.
6. Remove old document objects and revoke previously issued download tokens
   where required.
7. Confirm that private fields are not present in `StudentPublic`.
8. Test student, donor, and administrator access in a staging project.
9. Configure billing alerts and monitor Storage usage.

Administrator access must be controlled by a trusted Firebase Admin SDK
process using the `admin: true` custom claim. The mobile application must never
set its own administrator claim.

Rules can be deployed only after reviewing the data migration:

```bash
firebase deploy --only firestore:rules,storage
```

## Future development plan

The recommended order for completing the project is:

1. Configure the production Firebase Storage bucket and verify uploads safely.
2. Complete student and donor login, password-reset, and invalid-input tests.
3. Update the administrator application to use `StudentPublic` and
   `StudentPrivate`.
4. Add and verify trusted administrator authorization.
5. Test pending, approve, and block workflows end to end.
6. Build a trusted payment-verification backend.
7. Re-enable donations only after server-side payment verification is working.
8. Add release builds, crash reporting, analytics, backups, billing alerts, and
   monitoring.
9. Complete device, accessibility, privacy, and security testing.
10. Publish only after staging verification and a rollback plan are documented.

## Suggested architecture improvements

- Move Firebase operations out of page widgets into services or repositories.
- Create shared authentication and validation components.
- Replace loosely typed lists and maps with typed models.
- Use a consistent naming convention for files and classes.
- Add automated tests for every major user role and failure path.
- Keep payment verification and administrator operations on trusted backend
  services.
