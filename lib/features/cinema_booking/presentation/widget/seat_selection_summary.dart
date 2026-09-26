import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/seat_selection_cubit.dart';
import '../../cubit/seat_selection_state.dart';

class SeatSelectionSummary extends StatelessWidget {
  const SeatSelectionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        if (state is! SeatSelectionUpdated) {
          return const SizedBox.shrink();
        }
        final hasSelectedSeats = state.selectedSeatsCount > 0;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
            border: Border(top: BorderSide(color: const Color(0xFFD9E2EC))),
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                offset: const Offset(0, -5),
                color: Colors.black.withValues(alpha: 0.07),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9E2EC),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 18),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Booking Summary',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202B33),
                    ),
                  ),
                ),

                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7F8),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFD9E2EC)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SummaryItem(
                          icon: Icons.event_seat_rounded,
                          title: 'Selected Seats',
                          value: '${state.selectedSeatsCount}',
                        ),
                      ),

                      Container(
                        width: 1,
                        height: 42,
                        color: const Color(0xFFD9E2EC),
                      ),

                      Expanded(
                        child: _SummaryItem(
                          icon: Icons.payments_outlined,
                          title: 'Total Price',
                          value: '${state.totalPrice.toStringAsFixed(0)} EGP',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: hasSelectedSeats
                        ? () {
                            context.read<SeatSelectionCubit>().confirmBooking();
                          }
                        : null,
                    icon: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 20,
                    ),
                    label: const Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF486581),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFFE1E6EA),
                      disabledForegroundColor: const Color(0xFF9AA5B1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: hasSelectedSeats
                        ? () {
                            context.read<SeatSelectionCubit>().resetSelection();
                          }
                        : null,
                    icon: const Icon(Icons.refresh_rounded, size: 19),
                    label: const Text(
                      'Reset Selection',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF486581),
                      disabledForegroundColor: const Color(0xFFB0B8BF),
                      side: BorderSide(
                        color: hasSelectedSeats
                            ? const Color(0xFFD9E2EC)
                            : const Color(0xFFE5E9ED),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SummaryItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 2),

        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EEF3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 19, color: const Color(0xFF486581)),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7785),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202B33),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
