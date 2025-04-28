import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/create_reservation_usecase.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/delete_reservation_usecase.dart';
import 'package:nolatech_tenis/features/reservation/domain/usecases/list_reservations_usecase.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final CreateReservationUseCase createReservationUseCase;
  final ListReservationsUseCase listReservationsUseCase;
  final DeleteReservationUseCase deleteReservationUseCase;

  ReservationBloc({
    required this.createReservationUseCase,
    required this.listReservationsUseCase,
    required this.deleteReservationUseCase,
  }) : super(ReservationInitial()) {
    on<LoadReservationsEvent>(_onLoadReservations);
    on<CreateReservationEvent>(_onCreateReservation);
    on<DeleteReservationEvent>(_onDeleteReservation);
  }

  Future<void> _onLoadReservations(
    LoadReservationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(ReservationLoading());
    try {
      final reservations = await listReservationsUseCase();
      emit(ReservationLoaded(reservations));
    } catch (e) {
      emit(const ReservationFailure('failed_load_reservations'));
    }
  }

  Future<void> _onCreateReservation(
    CreateReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      await createReservationUseCase(event.reservation);
      final reservations = await listReservationsUseCase();
      emit(ReservationLoaded(reservations));
    } catch (e) {
      emit(const ReservationFailure('failed_create_reservation'));
    }
  }

  Future<void> _onDeleteReservation(
    DeleteReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      await deleteReservationUseCase(event.reservationId);
      final reservations = await listReservationsUseCase();
      emit(ReservationLoaded(reservations));
    } catch (e) {
      emit(const ReservationFailure('failed_delete_reservation'));
    }
  }
}
