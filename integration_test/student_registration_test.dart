import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:integration_test/integration_test.dart';
import 'package:siksha_anudan/main.dart' as app;

class _TestImagePicker extends ImagePickerPlatform {
  _TestImagePicker(this.path);

  final String path;

  @override
  Future<XFile?> getImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    return XFile(path);
  }
}

Future<void> _enter(
  WidgetTester tester,
  String key,
  String value,
) async {
  await tester.ensureVisible(find.byKey(ValueKey(key)));
  await tester.enterText(find.byKey(ValueKey(key)), value);
}

Future<void> _selectCustomDropdown(
  WidgetTester tester,
  String key,
  String option,
) async {
  final dropdown = find.byKey(ValueKey(key));
  final field = find.descendant(
    of: dropdown,
    matching: find.byType(TextField),
  );
  await tester.ensureVisible(field);
  await tester.tap(field);
  await tester.pumpAndSettle();
  await tester.tap(find.text(option).last);
  await tester.pumpAndSettle();
}

Future<void> _tapUpload(WidgetTester tester, String key) async {
  final button = find.byKey(ValueKey(key));
  await tester.ensureVisible(button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('student registration creates emulator records', (tester) async {
    final testEmail =
        'teststudent${DateTime.now().microsecondsSinceEpoch}@example.test';
    final tempDirectory = await Directory.systemTemp.createTemp('student-test');
    final imagePath = '${tempDirectory.path}/registration.png';
    await File(imagePath).writeAsBytes(<int>[
      137,
      80,
      78,
      71,
      13,
      10,
      26,
      10,
      0,
      0,
      0,
      13,
      73,
      72,
      68,
      82,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      1,
      8,
      2,
      0,
      0,
      0,
      144,
      119,
      83,
      222,
      0,
      0,
      0,
      12,
      73,
      68,
      65,
      84,
      8,
      215,
      99,
      248,
      207,
      192,
      240,
      31,
      0,
      5,
      0,
      1,
      255,
      137,
      153,
      61,
      29,
      0,
      0,
      0,
      0,
      73,
      69,
      78,
      68,
      174,
      66,
      96,
      130,
    ]);
    ImagePickerPlatform.instance = _TestImagePicker(imagePath);

    await app.main();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Student'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    await _enter(tester, 'registration-name', 'TestStudent');
    await _enter(tester, 'registration-email', testEmail);
    await _enter(tester, 'registration-phone', '1234567890');
    await _enter(tester, 'registration-address', 'TestRoad123');
    await _enter(tester, 'registration-aadhaar', '000000000000');
    await _enter(tester, 'registration-pan', 'ABCDE1234F');
    await _selectCustomDropdown(tester, 'registration-degree', 'B.A');
    await _selectCustomDropdown(
      tester,
      'registration-family-income',
      'Below 1,00,000',
    );
    await _enter(tester, 'registration-amount', '50000');
    await _enter(tester, 'registration-password', 'DummyPass123');
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    await _enter(tester, 'registration-high-school-name', 'TestSchool');
    await _selectCustomDropdown(
      tester,
      'registration-high-school-board',
      'CBSE Board',
    );
    await _enter(tester, 'registration-high-school-percent', '85');
    await _enter(tester, 'registration-intermediate-name', 'TestCollege');
    await _selectCustomDropdown(
      tester,
      'registration-intermediate-board',
      'CBSE Board',
    );
    await _enter(tester, 'registration-intermediate-percent', '90');
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();

    await _tapUpload(tester, 'registration-upload-photo');
    await _tapUpload(tester, 'registration-upload-bonafide');
    await _tapUpload(tester, 'registration-upload-sop');
    await tester.tap(find.text('NEXT'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('FINISH'));

    DocumentSnapshot<Map<String, dynamic>>? publicDocument;
    DocumentSnapshot<Map<String, dynamic>>? privateDocument;
    for (var attempt = 0; attempt < 60; attempt++) {
      await tester.pump(const Duration(milliseconds: 500));
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        publicDocument = await FirebaseFirestore.instance
            .collection('StudentPublic')
            .doc(currentUser.uid)
            .get();
        privateDocument = await FirebaseFirestore.instance
            .collection('StudentPrivate')
            .doc(currentUser.uid)
            .get();
      }
      if (publicDocument?.exists == true && privateDocument?.exists == true) {
        break;
      }
    }

    final user = FirebaseAuth.instance.currentUser;
    expect(user, isNotNull);
    final uid = user!.uid;
    await tester.pump(const Duration(seconds: 2));
    publicDocument = await FirebaseFirestore.instance
        .collection('StudentPublic')
        .doc(uid)
        .get();
    privateDocument = await FirebaseFirestore.instance
        .collection('StudentPrivate')
        .doc(uid)
        .get();
    final publicRecord = publicDocument;
    final privateRecord = privateDocument;
    expect(publicRecord.exists, isTrue);
    expect(privateRecord.exists, isTrue);
    final photoFiles =
        await FirebaseStorage.instance.ref('studentPhotos/$uid').listAll();
    final documentFiles =
        await FirebaseStorage.instance.ref('studentDocuments/$uid').listAll();

    expect(privateRecord.data()?['email'], testEmail);
    expect(publicRecord.data()?['status'], 'pending');
    expect(photoFiles.items.map((item) => item.name), contains('profile.jpg'));
    expect(
      documentFiles.items.map((item) => item.name),
      containsAll(<String>['signature.jpg', 'identity-document.jpg']),
    );

    binding.reportData = <String, dynamic>{
      'student_registration_emulator_records': true,
      'uid': uid,
    };
    await tempDirectory.delete(recursive: true);
  });
}
