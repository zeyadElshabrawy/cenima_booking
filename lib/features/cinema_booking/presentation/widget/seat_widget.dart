import 'package:cenima_booking/features/cinema_booking/presentation/models/cinema_seat.dart';
import 'package:cenima_booking/features/cinema_booking/presentation/models/seat_status.dart';
import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final CinemaSeat seat;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.seat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = seat.status == SeatStatus.disabled;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: _getBorderColor(),
            width: 1.2,
          ),
          boxShadow: _getBoxShadow(),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
           
            Text(
              '${seat.id}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _getTextColor(),
              ),
            ),

            if (isDisabled)
              const Positioned(
                right: 2,
                top: 2,
                child: Icon(
                  Icons.block_rounded,
                  size: 8,
                  color: Colors.white70,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (seat.status) {
      case SeatStatus.available:
        return Colors.white;

      case SeatStatus.selected:
        return const Color(0xFF486581);

      case SeatStatus.reserved:
        return const Color(0xFFB44A4A);

      case SeatStatus.disabled:
        return const Color(0xFF9AA5B1);
    }
  }

    Color _getBorderColor() {
    switch (seat.status) {
      case SeatStatus.available:
        return const Color(0xFFD9E2EC);

      case SeatStatus.selected:
        return const Color(0xFF486581);

      case SeatStatus.reserved:
        return const Color(0xFFB44A4A);

      case SeatStatus.disabled:
        return const Color(0xFF9AA5B1);
    }
  }

  Color _getTextColor() {
    switch (seat.status) {
      case SeatStatus.available:
        return const Color(0xFF202B33);

      case SeatStatus.selected:
      case SeatStatus.reserved:
      case SeatStatus.disabled:
        return Colors.white;
    }
  }

  List<BoxShadow> _getBoxShadow() {
    switch (seat.status) {
      case SeatStatus.available:
        return [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 1),
            color: Colors.black.withValues(
              alpha: 0.05,
            ),
          ),
        ];

      case SeatStatus.selected:
        return [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 2),
            color: const Color(0xFF486581).withValues(
              alpha: 0.25,
            ),
          ),
        ];

      case SeatStatus.reserved:
      case SeatStatus.disabled:
        return [];
    }
  }
}
