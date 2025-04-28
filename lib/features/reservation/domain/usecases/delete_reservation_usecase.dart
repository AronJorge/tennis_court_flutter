import 'package:nolatech_tenis/features/reservation/domain/repositories/reservation_repository.dart';

class DeleteReservationUseCase {
  final ReservationRepository repository;

  DeleteReservationUseCase(this.repository);

  Future<void> call(String reservationId) {
    return repository.deleteReservation(reservationId);
  }
}
