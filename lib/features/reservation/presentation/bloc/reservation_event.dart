import 'package:equatable/equatable.dart';
import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

class LoadReservationsEvent extends ReservationEvent {}

class CreateReservationEvent extends ReservationEvent {
  final ReservationEntity reservation;

  const CreateReservationEvent(this.reservation);
}

class DeleteReservationEvent extends ReservationEvent {
  final String reservationId;

  const DeleteReservationEvent(this.reservationId);
}

class MarkFavoriteReservationEvent extends ReservationEvent {
  final String reservationId;
  final bool isFavorite;

  const MarkFavoriteReservationEvent(this.reservationId, this.isFavorite);
}
