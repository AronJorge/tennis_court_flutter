import 'package:nolatech_tenis/features/reservation/domain/repositories/reservation_repository.dart';

class MarkFavoriteUseCase {
  final ReservationRepository repository;

  MarkFavoriteUseCase(this.repository);

  Future<void> call(String reservationId, bool isFavorite) {
    return repository.markReservationAsFavorite(reservationId, isFavorite);
  }
}
