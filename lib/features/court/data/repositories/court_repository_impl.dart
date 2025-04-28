import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';
import 'package:nolatech_tenis/features/court/data/datasources/court_local_data_source.dart';
import 'package:nolatech_tenis/features/court/domain/repositories/court_repository.dart';

class CourtRepositoryImpl implements CourtRepository {
  final CourtLocalDataSource localDataSource;

  CourtRepositoryImpl({required this.localDataSource});

  @override
  Future<List<CourtEntity>> getCourts() async {
    return await localDataSource.getCourts();
  }
}
