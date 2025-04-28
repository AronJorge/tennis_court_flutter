import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nolatech_tenis/features/court/domain/usecases/list_courts_usecase.dart';
import 'package:nolatech_tenis/features/court/domain/usecases/get_rain_probability_usecase.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_bloc.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_event.dart';
import 'package:nolatech_tenis/features/court/presentation/bloc/court_state.dart';
import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';

class MockListCourtsUseCase extends Mock implements ListCourtsUseCase {}
class MockGetRainProbabilityUseCase extends Mock implements GetRainProbabilityUseCase {}

void main() {
  late MockListCourtsUseCase mockListCourtsUseCase;
  late MockGetRainProbabilityUseCase mockGetRainProbabilityUseCase;
  late CourtBloc courtBloc;

  final tCourts = [
    CourtEntity(
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
    mockListCourtsUseCase = MockListCourtsUseCase();
    mockGetRainProbabilityUseCase = MockGetRainProbabilityUseCase();
    courtBloc = CourtBloc(
      listCourtsUseCase: mockListCourtsUseCase,
      getRainProbabilityUseCase: mockGetRainProbabilityUseCase,
    );
  });

  group('CourtBloc Tests', () {
    test('initial state should be CourtInitial', () {
      expect(courtBloc.state, CourtInitial());
    });

    blocTest<CourtBloc, CourtState>(
      'emits [CourtLoading, CourtLoaded] when loading courts succeeds',
      build: () {
        when(() => mockListCourtsUseCase()).thenAnswer((_) async => tCourts);
        when(() => mockGetRainProbabilityUseCase(any(), any()))
            .thenAnswer((_) async => 50.0); // por ejemplo 50% de nubes
        return courtBloc;
      },
      act: (bloc) => bloc.add(LoadCourtsEvent()),
      expect: () => [
        CourtLoading(),
        isA<CourtLoaded>(), // no podemos comparar directamente porque cambiamos el rainProbability
      ],
      verify: (_) {
        verify(() => mockListCourtsUseCase()).called(1);
        verify(() => mockGetRainProbabilityUseCase(any(), any())).called(tCourts.length);
      },
    );

    blocTest<CourtBloc, CourtState>(
      'emits [CourtLoading, CourtFailure] when loading courts fails',
      build: () {
        when(() => mockListCourtsUseCase()).thenThrow(Exception());
        return courtBloc;
      },
      act: (bloc) => bloc.add(LoadCourtsEvent()),
      expect: () => [
        CourtLoading(),
        const CourtFailure('Failed to load courts'),
      ],
      verify: (_) {
        verify(() => mockListCourtsUseCase()).called(1);
      },
    );
  });
}
