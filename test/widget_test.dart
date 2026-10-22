import 'dart:ui' show Size;

import 'package:flutter_test/flutter_test.dart';
import 'package:siksha_anudan/main.dart';

void main() {
  testWidgets('app loads the home screen with donor and student options', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
    tester.binding.window.devicePixelRatioTestValue = 2.625;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    addTearDown(tester.binding.window.clearDevicePixelRatioTestValue);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Donor'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
