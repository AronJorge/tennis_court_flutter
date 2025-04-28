import 'package:nolatech_tenis/features/court/domain/repositories/weather_repository.dart';

class GetRainProbabilityUseCase {
  final WeatherRepository repository;

  GetRainProbabilityUseCase(this.repository);

  Future<double> call(double latitude, double longitude) {
    return repository.getRainProbability(latitude, longitude);
  }
}
