
import 'package:cenima_booking/features/cinema_booking/presentation/models/cinema_seat.dart';
import 'package:cenima_booking/features/cinema_booking/presentation/models/seat_status.dart';

final class CinemaSeatsData {
  const CinemaSeatsData._();

  static const double firstTierPrice = 100;
  static const double secondTierPrice = 150;
  static const double thirdTierPrice = 200;

  static const Set<int> disabledSeatIds = {
    3,
    8,
    12,
    17,
    22,
    27,
    34,
    39,
    45,
    49,
    53,
    58,
  };

  static List<CinemaSeat> generateSeats() {
    final List<CinemaSeat> seats = [];

    for (int row = 1; row <= 6; row++) {
      for (int column = 1; column <= 10; column++) {
        final int seatId = ((row - 1) * 10) + column;

        final bool isDisabled = disabledSeatIds.contains(seatId);

        seats.add(
          CinemaSeat(
            id: seatId,
            row: row,
            column: column,
            price: _getPriceForRow(row),
            status: isDisabled
                ? SeatStatus.disabled
                : SeatStatus.available,
          ),
        );
      }
    }

    return seats;
  }

  static double _getPriceForRow(int row) {
    if (row <= 2) {
      return firstTierPrice;
    }

    if (row <= 4) {
      return secondTierPrice;
    }

    return thirdTierPrice;
  }
}
