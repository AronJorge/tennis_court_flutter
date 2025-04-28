import 'package:equatable/equatable.dart';
import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object?> get props => [];
}

class ReservationInitial extends ReservationState {}

class ReservationLoading extends ReservationState {}

class ReservationLoaded extends ReservationState {
  final List<ReservationEntity> reservations;

  const ReservationLoaded(this.reservations);

  @override
  List<Object?> get props => [reservations];
}

class ReservationFailure extends ReservationState {
  final String message;

  const ReservationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
