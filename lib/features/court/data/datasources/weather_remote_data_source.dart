import 'package:dio/dio.dart';
import 'package:nolatech_tenis/core/network/endpoints.dart';

class WeatherRemoteDataSource {
  final Dio dio;
  static const String _apiKey = 'c5ac00774915491d00858a80e958f516';

  WeatherRemoteDataSource(this.dio);

  Future<double> getRainProbability(double latitude, double longitude) async {
    final response = await dio.get(
      Endpoints.weather,
      queryParameters: {
        'lat': latitude,
        'lon': longitude,
        'appid': _apiKey,
        'units': 'metric',
      },
    );

    if (response.statusCode == 200) {
      final clouds = response.data['clouds']?['all'];
      return clouds != null ? (clouds as num).toDouble() : 0.0;
    } else {
      throw Exception('failed_to_fetch_rain_probability');
    }
  }
}
