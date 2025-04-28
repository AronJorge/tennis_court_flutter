import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nolatech_tenis/features/court/data/datasources/court_local_data_source.dart';
import 'package:nolatech_tenis/features/court/data/models/court_model.dart';
import 'package:nolatech_tenis/features/court/data/repositories/court_repository_impl.dart';

class MockCourtLocalDataSource extends Mock implements CourtLocalDataSource {}

void main() {
  late CourtRepositoryImpl repository;
  late MockCourtLocalDataSource mockDataSource;

  final courtModels = [
    CourtModel(
      id: '1',
      name: 'Court A',
      imageUrl: 'court_1.jpg',
      type: 'Grass',
      isAvailable: true,
      rainProbability: 0.0,
      availableDate: DateTime.now(),
      availableStartTime: '07:00',
      availableEndTime: '17:00',
      latitude: 10.0,
      longitude: 20.0,
    ),
  ];

  setUp(() {
    mockDataSource = MockCourtLocalDataSource();
    repository = CourtRepositoryImpl(localDataSource: mockDataSource);
  });

  test('should return list of courts from local data source', () async {
    when(() => mockDataSource.getCourts()).thenAnswer((_) async => courtModels);

    final result = await repository.getCourts();

    expect(result, equals(courtModels));
    verify(() => mockDataSource.getCourts()).called(1);
  });
}
