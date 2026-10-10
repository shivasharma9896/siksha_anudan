# Shiksha Anudan

Shiksha Anudan is a Flutter mobile app built to connect students seeking financial aid with donors who want to support education.

## Project overview

- Donor login and registration
- Student login and registration
- Student profile and scholarship need details
- Donor search and filtering for students
- Donation history and transaction tracking
- Student progress tracking dashboard

## Tech stack

- Flutter
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Material Design UI

## Local setup

1. Install Flutter SDK and ensure it is available in your PATH.
2. Clone the project and open it in your preferred IDE.
3. Run:

```bash
flutter pub get
flutter run
```

## Firebase setup

1. Create a Firebase project.
2. Add Android and iOS apps to the Firebase project.
3. Download and place the generated Firebase config files in the appropriate native project directories.
4. Enable Email/Password authentication.
5. Run the local Firestore and Storage rule tests:

```bash
cd firebase-tests
npm ci
npm test
```

The emulator test suite uses synthetic accounts and records. It runs only against local emulators, configured on ports 9099 (Authentication), 8080 (Firestore), and 9199 (Storage). It tests student and donor account creation, private document uploads, profile reads, donor visibility of approved profiles, and denied client-side donation writes. Deploy separately with `firebase deploy --only firestore:rules,storage` only after reviewing and completing the migration steps below.

After completing those steps and verifying the Firebase project selection, deploy from the repository root with:

```bash
firebase deploy --only firestore:rules,storage
```

## Security rules and data migration

The rules require the following document layout:

- `Donor/{uid}` contains a donor's private profile and is readable only by that donor or an admin.
- `StudentPublic/{uid}` contains approved-profile and education information shown to donors.
- `StudentPrivate/{uid}` contains student contact details, Aadhaar number, and private document paths; only that student or an admin can read it.
- `transaction/{id}` is read-only to clients. Only a trusted server/admin can create donation records or update raised totals.

Before deploying to a Firebase project with existing users:

1. Back up Firestore and Storage.
2. Migrate each legacy `Student/{uid}` record into `StudentPublic/{uid}` and `StudentPrivate/{uid}`. Keep new profiles pending until an administrator reviews them.
3. Move student and donor identity documents into `studentDocuments/{uid}/...` and `donorDocuments/{uid}/...`. Revoke existing Firebase download tokens for identity documents and remove old `StudentDocs`/`DonorDocs` objects; rules cannot revoke a download URL token that has already been issued.
4. Verify that no identity numbers, document download URLs, contact details, or other private fields remain in `StudentPublic`.
5. Deploy the rules, then test student, donor, and admin access using Firebase Emulator Suite or a non-production Firebase project.

Administrator access depends on a trusted Firebase Admin SDK process setting the boolean custom claim `admin: true`. Never allow the mobile app to set this claim. The current app has no admin-management screen.

Donations are temporarily disabled in the client. Razorpay's client success callback is not authoritative, and Firestore rules cannot verify a payment. A dedicated trusted payment-verification backend must be added before enabling donations or allowing transaction/raised-total writes.

## Production readiness notes

This project is currently a strong prototype and needs the following before release:

- centralized app architecture and state management
- stricter validation and error handling
- automated widget and integration tests
- production Firebase rules and access control
- release configuration for Android and iOS
- improved code cleanup and security review

## Suggested next steps

- refactor repeated login flows into shared widgets/services
- move Firebase logic out of UI classes
- add tests for the core donation flow
- add a trusted payment-verification backend before re-enabling donations
