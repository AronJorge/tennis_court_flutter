import 'package:hive/hive.dart';
import 'package:nolatech_tenis/core/constants/fields_contants.dart';
import 'package:nolatech_tenis/core/constants/local_data_source_keys.dart';
import 'package:nolatech_tenis/core/constants/initial_data_constants.dart';
import 'package:nolatech_tenis/features/court/data/datasources/court_local_data_source.dart';
import 'package:nolatech_tenis/features/court/data/models/court_model.dart';

class CourtLocalDataSourceImpl implements CourtLocalDataSource {
  final Box _courtsBox = Hive.box(LocalDataSourceKeys.courtsBox);

  @override
  Future<List<CourtModel>> getCourts() async {
    final storedCourts = _courtsBox.get(LocalDataSourceKeys.courtsList);

    if (storedCourts != null) {
      final List<dynamic> courtsList = storedCourts;
      return courtsList
          .map(
            (courtMap) =>
                CourtModel.fromJson(Map<String, dynamic>.from(courtMap)),
          )
          .toList();
    }

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
            availableEndTime: courtData[CourtFields.availableEndTime] as String,
            latitude: courtData[CourtFields.latitude] as double,
            longitude: courtData[CourtFields.longitude] as double,
          );
        }).toList();

    await saveCourts(initialCourts);

    return initialCourts;
  }

  @override
  Future<void> saveCourts(List<CourtModel> courts) async {
    final courtsJson = courts.map((court) => court.toJson()).toList();
    await _courtsBox.put(LocalDataSourceKeys.courtsList, courtsJson);
  }

  @override
  Future<void> clearCourts() async {
    await _courtsBox.delete(LocalDataSourceKeys.courtsList);
  }
}
