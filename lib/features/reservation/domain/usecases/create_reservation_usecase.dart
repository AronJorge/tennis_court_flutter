import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';
import 'package:nolatech_tenis/features/reservation/domain/repositories/reservation_repository.dart';

class CreateReservationUseCase {
  final ReservationRepository repository;

  CreateReservationUseCase(this.repository);

  Future<void> call(ReservationEntity reservation) {
    return repository.createReservation(reservation);
  }
}
