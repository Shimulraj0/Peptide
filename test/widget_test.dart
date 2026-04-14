import 'package:flutter_test/flutter_test.dart';
import 'package:peptide/main.dart';

void main() {
  testWidgets('App starts and shows splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PeptideTrackerApp());

    // Verify that the app title or some splash element exists
    expect(find.text('Peptide'), findsWidgets);
  });
}
