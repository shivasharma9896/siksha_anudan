import 'package:flutter_test/flutter_test.dart';
import 'package:siksha_anudan/main.dart';

void main() {
  testWidgets('app loads the home screen with donor and student options', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Donor'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
  });
}
