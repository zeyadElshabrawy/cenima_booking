import 'package:flutter/material.dart';

class SeatLegend extends StatelessWidget {
  const SeatLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        4,
        16,
        20,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFD9E2EC),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              offset: const Offset(0, 2),
              color: Colors.black.withValues(
                alpha: 0.04,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Seat Status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202B33),
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 18,
              runSpacing: 12,
              children: const [
                _LegendItem(
                  backgroundColor: Colors.white,
                  borderColor: Color(0xFFD9E2EC),
                  icon: Icons.event_seat_rounded,
                  iconColor: Color(0xFF202B33),
                  label: 'Available',
                ),
                _LegendItem(
                  backgroundColor: Color(0xFF486581),
                  borderColor: Color(0xFF486581),
                  icon: Icons.check_rounded,
                  iconColor: Colors.white,
                  label: 'Selected',
                ),
                _LegendItem(
                  backgroundColor: Color(0xFFB44A4A),
                  borderColor: Color(0xFFB44A4A),
                  icon: Icons.lock_rounded,
                  iconColor: Colors.white,
                  label: 'Reserved',
                ),
                _LegendItem(
                  backgroundColor: Color(0xFF9AA5B1),
                  borderColor: Color(0xFF9AA5B1),
                  icon: Icons.block_rounded,
                  iconColor: Colors.white,
                  label: 'Disabled',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;
  final String label;

  const _LegendItem({
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: borderColor,
              width: 1.2,
            ),
          ),
          child: Icon(
            icon,
            size: 14,
            color: iconColor,
          ),
        ),

        const SizedBox(width: 7),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF486581),
          ),
        ),
      ],
    );
  }
}