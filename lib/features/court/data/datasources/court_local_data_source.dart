import 'package:nolatech_tenis/features/court/data/models/court_model.dart';

abstract class CourtLocalDataSource {
  Future<List<CourtModel>> getCourts();
  Future<void> saveCourts(List<CourtModel> courts);
  Future<void> clearCourts();
}
