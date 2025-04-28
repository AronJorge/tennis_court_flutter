import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nolatech_tenis/features/court/domain/usecases/list_courts_usecase.dart';
import 'package:nolatech_tenis/features/court/domain/usecases/get_rain_probability_usecase.dart';
import 'court_event.dart';
import 'court_state.dart';

class CourtBloc extends Bloc<CourtEvent, CourtState> {
  final ListCourtsUseCase listCourtsUseCase;
  final GetRainProbabilityUseCase getRainProbabilityUseCase;

  CourtBloc({
    required this.listCourtsUseCase,
    required this.getRainProbabilityUseCase,
  }) : super(CourtInitial()) {
    on<LoadCourtsEvent>(_onLoadCourts);
  }

  Future<void> _onLoadCourts(
    LoadCourtsEvent event,
    Emitter<CourtState> emit,
  ) async {
    emit(CourtLoading());
    try {
      final courts = await listCourtsUseCase();

      final courtsWithWeather = await Future.wait(
        courts.map((court) async {
          final rainProbability = await getRainProbabilityUseCase(
            court.latitude,
            court.longitude,
          );

          return court.copyWith(rainProbability: rainProbability);
        }),
      );

      emit(CourtLoaded(courtsWithWeather));
    } catch (_) {
      emit(const CourtFailure('failed_to_load_courts'));
    }
  }
}
