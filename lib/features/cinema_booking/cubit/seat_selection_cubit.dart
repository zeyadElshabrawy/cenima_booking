import 'package:cenima_booking/features/cinema_booking/presentation/logic/seat_selection_validator.dart';
import 'package:cenima_booking/features/cinema_booking/presentation/models/cinema_seat.dart';
import 'package:cenima_booking/features/cinema_booking/presentation/models/seat_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'seat_selection_state.dart';

class SeatSelectionCubit extends Cubit<SeatSelectionState> {
  SeatSelectionCubit() : super(const SeatSelectionInitial());

  List<CinemaSeat> seats = [];

  void initializeSeats(List<CinemaSeat> initialSeats) {
    seats = List.from(initialSeats);

    _emitUpdatedState();
  }

  void selectSeat(CinemaSeat seat) {
    final error = SeatSelectionValidator.validateSelection(
      seats: seats,
      seat: seat,
    );

    if (error != null) {
      emit(SeatSelectionError(error));
      _emitUpdatedState();
      return;
    }

    seats = seats.map((currentSeat) {
      if (currentSeat.id == seat.id) {
        return currentSeat.copyWith(
          status: SeatStatus.selected,
        );
      }

      return currentSeat;
    }).toList();

    _emitUpdatedState();
  }

  void unselectSeat(CinemaSeat seat) {
    final error = SeatSelectionValidator.validateUnselection(
      seats: seats,
      seat: seat,
    );

    if (error != null) {
      emit(SeatSelectionError(error));
      _emitUpdatedState();
      return;
    }

    seats = seats.map((currentSeat) {
      if (currentSeat.id == seat.id) {
        return currentSeat.copyWith(
          status: SeatStatus.available,
        );
      }

      return currentSeat;
    }).toList();

    _emitUpdatedState();
  }

  void confirmBooking() {
    final hasSelectedSeats = seats.any(
      (seat) => seat.status == SeatStatus.selected,
    );

    if (!hasSelectedSeats) {
      emit(
        const SeatSelectionError(
          'Please select at least one seat before confirming the booking.',
        ),
      );

      _emitUpdatedState();
      return;
    }

    seats = seats.map((seat) {
      if (seat.status == SeatStatus.selected) {
        return seat.copyWith(
          status: SeatStatus.reserved,
        );
      }

      return seat;
    }).toList();

    _emitUpdatedState();
  }

  void cancelBooking(CinemaSeat seat) {
    final error = SeatSelectionValidator.validateBookingCancellation(
      seats: seats,
      seat: seat,
    );

    if (error != null) {
      emit(SeatSelectionError(error));
      _emitUpdatedState();
      return;
    }

    seats = seats.map((currentSeat) {
      if (currentSeat.id == seat.id) {
        return currentSeat.copyWith(
          status: SeatStatus.available,
        );
      }

      return currentSeat;
    }).toList();

    _emitUpdatedState();
  }

  void resetSelection() {
    seats = seats.map((seat) {
      if (seat.status == SeatStatus.selected) {
        return seat.copyWith(
          status: SeatStatus.available,
        );
      }

      return seat;
    }).toList();

    _emitUpdatedState();
  }

  void _emitUpdatedState() {
    final selectedSeats = seats
        .where(
          (seat) => seat.status == SeatStatus.selected,
        )
        .toList();

    final selectedSeatsCount = selectedSeats.length;

    final totalPrice = selectedSeats.fold<double>(
      0,
      (total, seat) => total + seat.price,
    );

    emit(
      SeatSelectionUpdated(
        seats: List.from(seats),
        selectedSeatsCount: selectedSeatsCount,
        totalPrice: totalPrice,
      ),
    );
  }
}
