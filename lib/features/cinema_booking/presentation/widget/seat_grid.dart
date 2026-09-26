import 'package:cenima_booking/features/cinema_booking/cubit/seat_selection_cubit.dart';
import 'package:cenima_booking/features/cinema_booking/cubit/seat_selection_state.dart';
import 'package:cenima_booking/features/cinema_booking/presentation/models/seat_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'seat_widget.dart';

class SeatGrid extends StatelessWidget {
  const SeatGrid({super.key});

  static const List<String> rowLabels = ['A', 'B', 'C', 'D', 'E', 'F'];

  static const int columnCount = 10;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
      builder: (context, state) {
        if (state is! SeatSelectionUpdated) {
          return const SizedBox.shrink();
        }

        final seats = state.seats;

        return LayoutBuilder(
          builder: (context, constraints) {
            const double horizontalPadding = 16;
            const double labelWidth = 24;
            const double spacing = 6;

            final availableWidth =
                constraints.maxWidth - (horizontalPadding * 2) - labelWidth;

            final seatSize =
                (availableWidth - (spacing * (columnCount - 1))) / columnCount;

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: labelWidth),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(columnCount, (index) {
                            return SizedBox(
                              width: seatSize,
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  ...List.generate(rowLabels.length, (rowIndex) {
                    final rowSeats =
                        seats.where((seat) => seat.row == rowIndex + 1).toList()
                          ..sort((a, b) => a.column.compareTo(b.column));

                    return Padding(
                      padding: const EdgeInsets.only(bottom: spacing),
                      child: Row(
                        children: [
                          // Row Letter
                          SizedBox(
                            width: labelWidth,
                            child: Center(
                              child: Text(
                                rowLabels[rowIndex],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: spacing),

                          // Seats
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: rowSeats.map((seat) {
                                return SizedBox(
                                  width: seatSize,
                                  height: seatSize,
                                  child: SeatWidget(
                                    seat: seat,
                                    onTap: () {
                                      final cubit = context
                                          .read<SeatSelectionCubit>();

                                      switch (seat.status) {
                                        case SeatStatus.available:
                                          cubit.selectSeat(seat);
                                          break;

                                        case SeatStatus.selected:
                                          cubit.unselectSeat(seat);
                                          break;

                                        case SeatStatus.reserved:
                                          cubit.cancelBooking(seat);
                                          break;

                                        case SeatStatus.disabled:
                                          break;
                                      }
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
