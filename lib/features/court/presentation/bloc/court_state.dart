import 'package:equatable/equatable.dart';
import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';

abstract class CourtState extends Equatable {
  const CourtState();

  @override
  List<Object?> get props => [];
}

class CourtInitial extends CourtState {}

class CourtLoading extends CourtState {}

class CourtLoaded extends CourtState {
  final List<CourtEntity> courts;

  const CourtLoaded(this.courts);

  @override
  List<Object?> get props => [courts];
}

class CourtFailure extends CourtState {
  final String message;

  const CourtFailure(this.message);

  @override
  List<Object?> get props => [message];
}
