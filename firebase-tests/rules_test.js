const {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} = require("@firebase/rules-unit-testing");
const {
  collection,
  connectFirestoreEmulator,
  doc,
  getDoc,
  getDocs,
  getFirestore,
  query,
  setDoc,
  updateDoc,
  where,
} = require("firebase/firestore");
const {
  connectStorageEmulator,
  getBytes,
  getStorage,
  ref,
  uploadBytes,
} = require("firebase/storage");
const {
  connectAuthEmulator,
  createUserWithEmailAndPassword,
  getAuth,
} = require("firebase/auth");
const { deleteApp, initializeApp } = require("firebase/app");
const assert = require("node:assert/strict");
const fs = require("node:fs");
const path = require("node:path");

async function main() {
  const projectId = "demo-shiksha-anudan";
  const env = await initializeTestEnvironment({
    projectId,
    firestore: {
      host: "127.0.0.1",
      port: 8080,
      rules: fs.readFileSync(path.join(__dirname, "../firestore.rules"), "utf8"),
    },
    storage: {
      host: "127.0.0.1",
      port: 9199,
      rules: fs.readFileSync(path.join(__dirname, "../storage.rules"), "utf8"),
    },
  });

  try {
    await env.withSecurityRulesDisabled(async (context) => {
      const db = context.firestore();
      await setDoc(doc(db, "Donor/donor1"), {
        uid: "donor1",
        email: "donor@example.test",
        name: "Donor",
      });
      await setDoc(doc(db, "StudentPublic/student1"), {
        uid: "student1",
        name: "Student",
        status: "approved",
        amountReq: 1000,
        amountRec: 0,
        photourl: "https://example.test/photo.jpg",
      });
      await setDoc(doc(db, "StudentPublic/student2"), {
        uid: "student2",
        name: "Pending Student",
        status: "pending",
        amountReq: 2000,
        amountRec: 0,
      });
      await setDoc(doc(db, "StudentPrivate/student1"), {
        uid: "student1",
        email: "student@example.test",
        aadharC: "synthetic",
        signurl: "studentDocuments/student1/signature.jpg",
      });
      await setDoc(doc(db, "transaction/pay1"), {
        DonorEmail: "donor@example.test",
        StudentEmail: "student@example.test",
        DonatedAmount: "100",
      });
    });

    const student = env.authenticatedContext("student1", {
      email: "student@example.test",
    });
    const newStudent = env.authenticatedContext("student3", {
      email: "student3@example.test",
    });
    const donor = env.authenticatedContext("donor1", {
      email: "donor@example.test",
    });
    const outsider = env.authenticatedContext("outsider", {
      email: "outsider@example.test",
    });
    const studentDb = student.firestore();
    const donorDb = donor.firestore();

    await assertSucceeds(getDoc(doc(studentDb, "StudentPrivate/student1")));
    await assertFails(getDoc(doc(donorDb, "StudentPrivate/student1")));
    await assertFails(getDoc(doc(outsider.firestore(), "StudentPrivate/student1")));
    await assertSucceeds(
      setDoc(doc(newStudent.firestore(), "StudentPublic/student3"), {
        uid: "student3",
        name: "New Student",
        status: "pending",
        amountReq: 1500,
        amountRec: 0,
      }),
    );
    await assertFails(
      setDoc(doc(newStudent.firestore(), "StudentPublic/student4"), {
        uid: "student3",
        name: "Impersonated Student",
        status: "pending",
        amountReq: 1500,
        amountRec: 0,
      }),
    );
    await assertSucceeds(
      updateDoc(doc(studentDb, "StudentPrivate/student1"), {
        phonenum: "0000000000",
      }),
    );
    await assertFails(
      updateDoc(doc(studentDb, "StudentPrivate/student1"), {
        aadharC: "changed",
      }),
    );

    const approved = await assertSucceeds(
      getDocs(
        query(
          collection(donorDb, "StudentPublic"),
          where("status", "==", "approved"),
        ),
      ),
    );
    assert.equal(approved.size, 1, "donors should see approved students only");
    await assertFails(
      updateDoc(doc(studentDb, "StudentPublic/student1"), { amountRec: 999999 }),
    );
    await assertFails(
      updateDoc(doc(studentDb, "StudentPublic/student1"), {
        status: "approved",
      }),
    );
    await assertFails(
      setDoc(doc(donorDb, "transaction/fake"), {
        DonorEmail: "donor@example.test",
        DonatedAmount: "999",
      }),
    );
    await assertFails(
      updateDoc(doc(donorDb, "StudentPublic/student1"), { amountRec: 999999 }),
    );
    await assertSucceeds(getDoc(doc(donorDb, "transaction/pay1")));
    await assertFails(getDoc(doc(outsider.firestore(), "transaction/pay1")));

    const studentStorage = student.storage();
    const donorStorage = donor.storage();
    await assertSucceeds(
      uploadBytes(
        ref(studentStorage, "studentDocuments/student1/signature.jpg"),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertSucceeds(
      getBytes(ref(studentStorage, "studentDocuments/student1/signature.jpg")),
    );
    await assertFails(
      getBytes(ref(donorStorage, "studentDocuments/student1/signature.jpg")),
    );
    await assertFails(
      uploadBytes(
        ref(donorStorage, "studentDocuments/student1/forged.jpg"),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertSucceeds(
      uploadBytes(
        ref(studentStorage, "studentPhotos/student1/profile.jpg"),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      ),
    );
    await assertSucceeds(
      getBytes(ref(donorStorage, "studentPhotos/student1/profile.jpg")),
    );

    const app = initializeApp(
      {
        apiKey: "fake-api-key",
        appId: "1:1234567890:web:emulator-test",
        projectId,
        authDomain: `${projectId}.firebaseapp.com`,
        storageBucket: `${projectId}.appspot.com`,
      },
      "registration-flow-test",
    );
    try {
      const auth = getAuth(app);
      connectAuthEmulator(auth, "http://127.0.0.1:9099");
      const appDb = getFirestore(app);
      connectFirestoreEmulator(appDb, "127.0.0.1", 8080);
      const appStorage = getStorage(app);
      connectStorageEmulator(appStorage, "127.0.0.1", 9199);

      const studentCredential = await createUserWithEmailAndPassword(
        auth,
        "fresh-student@example.test",
        "TestPassword123!",
      );
      const freshStudentUid = studentCredential.user.uid;
      await uploadBytes(
        ref(appStorage, `studentPhotos/${freshStudentUid}/profile.jpg`),
        new Uint8Array([1, 2, 3]),
        { contentType: "image/jpeg" },
      );
      await uploadBytes(
        ref(appStorage, `studentDocuments/${freshStudentUid}/identity.jpg`),
        new Uint8Array([4, 5, 6]),
        { contentType: "image/jpeg" },
      );
      await setDoc(doc(appDb, `StudentPublic/${freshStudentUid}`), {
        uid: freshStudentUid,
        name: "Fresh Student",
        highschoolcollegename: "Example School",
        highschoolboard: "State Board",
        highschoolpercent: "90",
        intermediatecollegename: "Example College",
        intermediateboard: "State Board",
        intermediatepercent: "88",
        photourl: "https://example.test/profile.jpg",
        amountReq: 15000,
        appFor: "B.Sc",
        amountRec: 0,
        status: "pending",
        income: "Below 1,00,000",
      });
      await setDoc(doc(appDb, `StudentPrivate/${freshStudentUid}`), {
        uid: freshStudentUid,
        email: "fresh-student@example.test",
        phonenum: "0000000000",
        address: "Test address",
        aadharC: "synthetic-only",
        signurl: `studentDocuments/${freshStudentUid}/signature.jpg`,
        aadharurl: `studentDocuments/${freshStudentUid}/identity.jpg`,
        dob: "01/01/2000",
      });
      assert.equal(
        (await getDoc(doc(appDb, `StudentPrivate/${freshStudentUid}`))).exists(),
        true,
        "new student should read their own private profile",
      );
      assert.equal(
        (await getDoc(doc(appDb, `StudentPublic/${freshStudentUid}`))).data()
          .status,
        "pending",
        "new student should start pending approval",
      );

      await auth.signOut();
      const donorCredential = await createUserWithEmailAndPassword(
        auth,
        "fresh-donor@example.test",
        "TestPassword123!",
      );
      const freshDonorUid = donorCredential.user.uid;
      await uploadBytes(
        ref(appStorage, `donorDocuments/${freshDonorUid}/identity.jpg`),
        new Uint8Array([7, 8, 9]),
        { contentType: "image/jpeg" },
      );
      await setDoc(doc(appDb, `Donor/${freshDonorUid}`), {
        uid: freshDonorUid,
        email: "fresh-donor@example.test",
        name: "Fresh Donor",
        phonenum: "0000000001",
        address: "Donor test address",
        aadharC: "synthetic-only",
        pancard: "synthetic-only",
        photourl: "https://example.test/donor.jpg",
        signurl: `donorDocuments/${freshDonorUid}/signature.jpg`,
        aadharurl: `donorDocuments/${freshDonorUid}/identity.jpg`,
        dob: "01/01/1980",
      });
      assert.equal(
        (await getDoc(doc(appDb, `Donor/${freshDonorUid}`))).exists(),
        true,
        "new donor should read their own profile",
      );
      await assertFails(
        getDoc(doc(appDb, `StudentPrivate/${freshStudentUid}`)),
      );
      const visibleStudents = await getDocs(
        query(
          collection(appDb, "StudentPublic"),
          where("status", "==", "approved"),
        ),
      );
      assert.equal(
        visibleStudents.docs.some((item) => item.id === freshStudentUid),
        false,
        "donors must not see pending student profiles",
      );
    } finally {
      await deleteApp(app);
    }

    console.log(
      "Firebase emulator tests passed: rules authorization, fresh student and donor signup, private uploads/profile reads, approval filtering, and payment-write denial.",
    );
  } finally {
    await env.cleanup();
  }
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
