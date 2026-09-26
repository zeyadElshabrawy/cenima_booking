import 'package:cenima_booking/features/cinema_booking/presentation/models/cinema_seat.dart';

sealed class SeatSelectionState {
  const SeatSelectionState();
}

final class SeatSelectionInitial extends SeatSelectionState {
  const SeatSelectionInitial();
}

final class SeatSelectionUpdated extends SeatSelectionState {
  final List<CinemaSeat> seats;
  final int selectedSeatsCount;
  final double totalPrice;

  const SeatSelectionUpdated({
    required this.seats,
    required this.selectedSeatsCount,
    required this.totalPrice,
  });
}

final class SeatSelectionError extends SeatSelectionState {
  final String message;

  const SeatSelectionError(this.message);
}