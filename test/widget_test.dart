import 'package:flutter_test/flutter_test.dart';
import 'package:quickbite_app/main.dart';

void main() {
  testWidgets('QuickBiteApp boots and displays initial widgets', (WidgetTester tester) async {
    await tester.pumpWidget(const QuickBiteApp());
    expect(find.text('QuickBite'), findsOneWidget);
    expect(find.text('Campus Food in Minutes'), findsOneWidget);
  });
}
