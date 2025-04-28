import 'package:equatable/equatable.dart';

class ReservationEntity extends Equatable {
  final String id;
  final String userId;
  final String courtId;
  final String courtName;
  final String courtImageUrl;
  final DateTime dateTime;
  final String? instructor;
  final String? comment;
  final bool isFavorite;
  final double? rainProbability;
  final String userName;

  const ReservationEntity({
    required this.id,
    required this.userId,
    required this.courtId,
    required this.courtName,
    required this.courtImageUrl,
    required this.dateTime,
    required this.userName,
    this.instructor,
    this.comment,
    this.isFavorite = false,
    this.rainProbability,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    courtId,
    courtName,
    courtImageUrl,
    dateTime,
    userName,
    instructor,
    comment,
    isFavorite,
    rainProbability,
  ];
}
