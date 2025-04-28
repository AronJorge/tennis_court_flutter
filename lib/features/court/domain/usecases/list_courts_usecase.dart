import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';
import 'package:nolatech_tenis/features/court/domain/repositories/court_repository.dart';

class ListCourtsUseCase {
  final CourtRepository repository;

  ListCourtsUseCase(this.repository);

  Future<List<CourtEntity>> call() {
    return repository.getCourts();
  }
}
