import '../models/cinema_seat.dart';
import '../models/seat_status.dart';

final class SeatSelectionValidator {
  const SeatSelectionValidator._();

  // ------------------------------------------------------------
  // SELECT SEAT
  // ------------------------------------------------------------

  static String? validateSelection({
    required List<CinemaSeat> seats,
    required CinemaSeat seat,
  }) {
    // Disabled seat cannot be selected.
    if (seat.status == SeatStatus.disabled) {
      return 'This seat is disabled.';
    }

    // Reserved seat is handled as a cancellation action.
    if (seat.status == SeatStatus.reserved) {
      return 'This seat is reserved. Tap it to cancel the booking.';
    }

    // A selected seat cannot be selected again.
    if (seat.status == SeatStatus.selected) {
      return 'This seat is already selected.';
    }

    // Maximum number of selected seats.
    final selectedSeatsCount = seats
        .where(
          (currentSeat) =>
              currentSeat.status == SeatStatus.selected,
        )
        .length;

    if (selectedSeatsCount >= 5) {
      return 'You can select a maximum of 5 seats.';
    }

    // Simulate selecting the seat.
    final updatedSeats = seats.map((currentSeat) {
      if (currentSeat.id == seat.id) {
        return currentSeat.copyWith(
          status: SeatStatus.selected,
        );
      }

      return currentSeat;
    }).toList();

    // Check if the new selection creates:
    // X O X
    // or
    // X O O X
    if (_hasInvalidAvailableGroup(updatedSeats)) {
      return 'You cannot select this seat because it would leave fewer than 3 available seats between unavailable seats.';
    }

    return null;
  }

  // ------------------------------------------------------------
  // UNSELECT SEAT
  // ------------------------------------------------------------

  static String? validateUnselection({
    required List<CinemaSeat> seats,
    required CinemaSeat seat,
  }) {
    // Only selected seats can be unselected.
    if (seat.status != SeatStatus.selected) {
      return 'This seat is not selected.';
    }

    // Simulate making the seat available again.
    final updatedSeats = seats.map((currentSeat) {
      if (currentSeat.id == seat.id) {
        return currentSeat.copyWith(
          status: SeatStatus.available,
        );
      }

      return currentSeat;
    }).toList();

    // Check the new arrangement.
    if (_hasInvalidAvailableGroup(updatedSeats)) {
      return 'You cannot unselect this seat because it would leave fewer than 3 available seats between unavailable seats.';
    }

    return null;
  }

  // ------------------------------------------------------------
  // CANCEL BOOKING
  // ------------------------------------------------------------

  static String? validateBookingCancellation({
    required List<CinemaSeat> seats,
    required CinemaSeat seat,
  }) {
    // Only reserved seats can be cancelled.
    if (seat.status != SeatStatus.reserved) {
      return 'This seat is not reserved.';
    }

    // Simulate:
    // Reserved -> Available
    final updatedSeats = seats.map((currentSeat) {
      if (currentSeat.id == seat.id) {
        return currentSeat.copyWith(
          status: SeatStatus.available,
        );
      }

      return currentSeat;
    }).toList();

    // If cancellation creates an invalid group,
    // the booking must remain reserved.
    if (_hasInvalidAvailableGroup(updatedSeats)) {
      return 'This booking cannot be cancelled because it would leave fewer than 3 available seats between unavailable seats.';
    }

    return null;
  }

  // ------------------------------------------------------------
  // INVALID AVAILABLE GROUP
  // ------------------------------------------------------------

  static bool _hasInvalidAvailableGroup(
    List<CinemaSeat> seats,
  ) {
    // We check every row separately.
    for (int row = 1; row <= 6; row++) {
      final rowSeats = seats
          .where(
            (seat) => seat.row == row,
          )
          .toList()
        ..sort(
          (a, b) => a.column.compareTo(b.column),
        );

      int availableCount = 0;

      bool hasUnavailableBefore = false;

      for (final seat in rowSeats) {
        final isAvailable =
            seat.status == SeatStatus.available;

        // ------------------------------------------------------
        // AVAILABLE SEAT
        // ------------------------------------------------------

        if (isAvailable) {
          // We only count available seats if there is already
          // an unavailable seat before them.
          if (hasUnavailableBefore) {
            availableCount++;
          }

          continue;
        }

        // ------------------------------------------------------
        // UNAVAILABLE SEAT
        // ------------------------------------------------------

        // Current seat is unavailable.
        //
        // If we already had:
        //
        // X O
        //
        // and the current seat is X,
        // then we have:
        //
        // X O X
        //
        // which is invalid.
        //
        // Same for:
        //
        // X O O X
        //
        if (hasUnavailableBefore &&
            availableCount > 0 &&
            availableCount < 3) {
          return true;
        }

        // Current unavailable seat becomes the new
        // left boundary.
        hasUnavailableBefore = true;

        // Start counting a new available group.
        availableCount = 0;
      }

      // IMPORTANT:
      //
      // We intentionally DO NOT check availableCount here.
      //
      // Because a group at the end of the row has no
      // unavailable seat on its right side.
      //
      // Example:
      //
      // X O O
      //
      // is allowed.
    }

    return false;
  }
}