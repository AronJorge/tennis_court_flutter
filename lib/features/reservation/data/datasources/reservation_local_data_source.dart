import 'package:hive/hive.dart';
import 'package:nolatech_tenis/features/reservation/data/models/reservation_model.dart';

class ReservationLocalDataSource {
  final Box _reservationsBox = Hive.box('reservationsBox');
  static const String _reservationsKey = 'reservations_list';

  List<ReservationModel> getReservations() {
    final storedReservations = _reservationsBox.get(_reservationsKey);

    if (storedReservations != null) {
      final List<dynamic> reservationsList = storedReservations;
      return reservationsList
          .map(
            (resMap) =>
                ReservationModel.fromJson(Map<String, dynamic>.from(resMap)),
          )
          .toList();
    }

    return [];
  }

  // Guardar todas las reservas (sobrescribe todo)
  Future<void> saveReservations(List<ReservationModel> reservations) async {
    final reservationsJson = reservations.map((res) => res.toJson()).toList();
    await _reservationsBox.put(_reservationsKey, reservationsJson);
  }

  Future<void> createReservation(ReservationModel reservation) async {
    final currentReservations = getReservations();
    final updatedReservations = List<ReservationModel>.from(currentReservations)
      ..add(reservation);
    await saveReservations(updatedReservations);
  }

  Future<void> deleteReservation(String reservationId) async {
    final currentReservations = getReservations();
    final updatedReservations =
        currentReservations.where((res) => res.id != reservationId).toList();
    await saveReservations(updatedReservations);
  }

  Future<void> markReservationAsFavorite(
    String reservationId,
    bool isFavorite,
  ) async {
    final currentReservations = getReservations();

    final updatedReservations =
        currentReservations.map((res) {
          if (res.id == reservationId) {
            return res.copyWith(isFavorite: isFavorite);
          }
          return res;
        }).toList();

    await saveReservations(updatedReservations);
  }

  Future<void> clearReservations() async {
    await _reservationsBox.delete(_reservationsKey);
  }
}
