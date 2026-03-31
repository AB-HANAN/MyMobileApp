import 'package:flutter_test/flutter_test.dart';
import 'package:aide/main.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const AideApp());
    expect(find.byType(AideApp), findsOneWidget);
  });
}
