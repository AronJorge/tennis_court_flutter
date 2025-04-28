import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';

abstract class ReservationRepository {
  Future<void> createReservation(ReservationEntity reservation);

  Future<List<ReservationEntity>> getReservations();

  Future<void> deleteReservation(String reservationId);

  Future<void> markReservationAsFavorite(String reservationId, bool isFavorite);
}
