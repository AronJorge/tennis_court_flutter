import 'package:nolatech_tenis/features/court/data/datasources/weather_remote_data_source.dart';
import 'package:nolatech_tenis/features/court/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<double> getRainProbability(double latitude, double longitude) {
    return remoteDataSource.getRainProbability(latitude, longitude);
  }
}
