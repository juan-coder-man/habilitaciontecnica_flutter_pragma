import 'package:flutter_test/flutter_test.dart';
import 'package:habilitaciontecnica_flutter_pragma/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Inicio'), findsOneWidget);
  });
}
