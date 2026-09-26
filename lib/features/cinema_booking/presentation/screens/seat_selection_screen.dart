import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/seat_selection_cubit.dart';
import '../../cubit/seat_selection_state.dart';
import '../../data/cinema_seats_data.dart';
import '../widget/cinema_header.dart';
import '../widget/cinema_screen_widget.dart';
import '../widget/seat_grid.dart';
import '../widget/seat_legend.dart';
import '../widget/seat_selection_summary.dart';

class SeatSelectionScreen extends StatelessWidget {
  const SeatSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SeatSelectionCubit()
        ..initializeSeats(
          CinemaSeatsData.generateSeats(),
        ),
      child: const _SeatSelectionView(),
    );
  }
}

class _SeatSelectionView extends StatelessWidget {
  const _SeatSelectionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      body: SafeArea(
        child: BlocListener<SeatSelectionCubit, SeatSelectionState>(
          listener: (context, state) {
            if (state is SeatSelectionError) {
              _showErrorMessage(
                context,
                state.message,
              );
            }
          },
          child: BlocBuilder<SeatSelectionCubit, SeatSelectionState>(
            builder: (context, state) {
              if (state is SeatSelectionInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SeatSelectionUpdated) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const CinemaHeader(),

                      const SizedBox(height: 8),

                      const CinemaScreenWidget(),

                      const SizedBox(height: 8),

                      const SeatGrid(),

                      const SizedBox(height: 4),

                      const SeatLegend(),

                      const SizedBox(height: 8),

                      const SeatSelectionSummary(),

                      const SizedBox(height: 16),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  static void _showErrorMessage(
    BuildContext context,
    String message,
  ) {
    final messenger = ScaffoldMessenger.of(context);

    // Remove any previous message first.
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          20,
        ),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(
          seconds: 3,
        ),
        content: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFB44A4A),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                offset: const Offset(0, 6),
                color: Colors.black.withValues(
                  alpha: 0.15,
                ),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.15,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Action not allowed',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              GestureDetector(
                onTap: () {
                  messenger.hideCurrentSnackBar();
                },
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white70,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
