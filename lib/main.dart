
import 'package:cenima_booking/features/cinema_booking/presentation/screens/seat_selection_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CinemaBooking());
}

class CinemaBooking extends StatelessWidget {
  const CinemaBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SeatSelectionScreen(),
    );
  }
}
