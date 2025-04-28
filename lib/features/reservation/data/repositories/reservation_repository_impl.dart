import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';
import 'package:nolatech_tenis/features/reservation/data/datasources/reservation_local_data_source.dart';
import 'package:nolatech_tenis/features/reservation/data/models/reservation_model.dart';
import 'package:nolatech_tenis/features/reservation/domain/repositories/reservation_repository.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationLocalDataSource localDataSource;

  ReservationRepositoryImpl({required this.localDataSource});

  @override
  Future<void> createReservation(ReservationEntity reservation) async {
    final model = ReservationModel.fromEntity(reservation);
    await localDataSource.createReservation(model);
  }

  @override
  Future<List<ReservationEntity>> getReservations() async {
    final models = localDataSource.getReservations();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> deleteReservation(String reservationId) async {
    await localDataSource.deleteReservation(reservationId);
  }

  @override
  Future<void> markReservationAsFavorite(
    String reservationId,
    bool isFavorite,
  ) async {
    await localDataSource.markReservationAsFavorite(reservationId, isFavorite);
  }
}
