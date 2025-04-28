import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';

abstract class CourtRepository {
  Future<List<CourtEntity>> getCourts();
}
