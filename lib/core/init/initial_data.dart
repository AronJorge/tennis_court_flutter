import 'package:hive/hive.dart';
import 'package:nolatech_tenis/core/constants/fields_contants.dart';
import 'package:nolatech_tenis/core/constants/local_data_source_keys.dart';
import 'package:nolatech_tenis/core/constants/initial_data_constants.dart';
import 'package:nolatech_tenis/features/court/data/models/court_model.dart';
import 'package:nolatech_tenis/features/reservation/data/models/reservation_model.dart';

class InitialDataSeeder {
  static Future<void> seedCourtsIfNeeded() async {
    final courtsBox = Hive.box(LocalDataSourceKeys.courtsBox);
    final storedCourts = courtsBox.get(LocalDataSourceKeys.courtsList);

    if (storedCourts == null || (storedCourts as List).isEmpty) {
      final now = DateTime.now();
      final initialCourts =
          InitialDataCourts.courts.map((courtData) {
            return CourtModel(
              id: courtData[CourtFields.id] as String,
              name: courtData[CourtFields.name] as String,
              imageUrl: courtData[CourtFields.imageUrl] as String,
              type: courtData[CourtFields.type] as String,
              isAvailable: courtData[CourtFields.isAvailable] as bool,
              rainProbability: 0.0,
              availableDate: now,
              availableStartTime:
                  courtData[CourtFields.availableStartTime] as String,
              availableEndTime:
                  courtData[CourtFields.availableEndTime] as String,
              latitude: courtData[CourtFields.latitude] as double,
              longitude: courtData[CourtFields.longitude] as double,
            );
          }).toList();

      await courtsBox.put(
        LocalDataSourceKeys.courtsList,
        initialCourts.map((court) => court.toJson()).toList(),
      );
    }
  }

  static Future<void> seedReservationsIfNeeded() async {
    final reservationsBox = Hive.box(LocalDataSourceKeys.reservationsBox);
    final storedReservations = reservationsBox.get(
      LocalDataSourceKeys.reservationsList,
    );

    if (storedReservations == null || (storedReservations as List).isEmpty) {
      final now = DateTime.now();
      final initialReservations =
          InitialDataReservations.reservations.map((reservationData) {
            return ReservationModel(
              id: reservationData[ReservationFields.id] as String,
              userId: reservationData[ReservationFields.userId] as String,
              courtId: reservationData[ReservationFields.courtId] as String,
              courtName: reservationData[ReservationFields.courtName] as String,
              courtImageUrl:
                  reservationData[ReservationFields.courtImageUrl] as String,
              dateTime: now.add(const Duration(days: 1)),
              userName: reservationData[ReservationFields.userName] as String,
              instructor:
                  reservationData[ReservationFields.instructor] as String?,
              comment: reservationData[ReservationFields.comment] as String?,
              isFavorite: reservationData[ReservationFields.isFavorite] as bool,
              rainProbability: 0.0,
            );
          }).toList();

      await reservationsBox.put(
        LocalDataSourceKeys.reservationsList,
        initialReservations.map((res) => res.toJson()).toList(),
      );
    }
  }

  static Future<void> seedAll() async {
    await seedCourtsIfNeeded();
    await seedReservationsIfNeeded();
  }
}
