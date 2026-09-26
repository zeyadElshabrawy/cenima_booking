import 'seat_status.dart';

class CinemaSeat {
  final int id;
  final int row;
  final int column;
  final double price;
  final SeatStatus status;

  const CinemaSeat({
    required this.id,
    required this.row,
    required this.column,
    required this.price,
    required this.status,
  });

  CinemaSeat copyWith({
    int? id,
    int? row,
    int? column,
    double? price,
    SeatStatus? status,
  }) {
    return CinemaSeat(
      id: id ?? this.id,
      row: row ?? this.row,
      column: column ?? this.column,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }
}