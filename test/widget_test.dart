import 'package:flutter_test/flutter_test.dart';
import 'package:cenima_booking/main.dart';

void main() {
  testWidgets('Cinema Booking app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const CinemaBooking());

    expect(find.byType(CinemaBooking), findsOneWidget);
  });
}
