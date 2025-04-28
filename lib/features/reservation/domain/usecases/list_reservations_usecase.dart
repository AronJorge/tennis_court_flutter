import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';
import 'package:nolatech_tenis/features/reservation/domain/repositories/reservation_repository.dart';

class ListReservationsUseCase {
  final ReservationRepository repository;

  ListReservationsUseCase(this.repository);

  Future<List<ReservationEntity>> call() {
    return repository.getReservations();
  }
}
