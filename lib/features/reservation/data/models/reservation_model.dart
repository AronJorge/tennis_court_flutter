import 'package:nolatech_tenis/features/common/domain/entities/reservation_entity.dart';

class ReservationModel extends ReservationEntity {
  const ReservationModel({
    required super.id,
    required super.userId,
    required super.courtId,
    required super.courtName,
    required super.courtImageUrl,
    required super.dateTime,
    required super.userName,
    super.instructor,
    super.comment,
    super.isFavorite,
    super.rainProbability,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      userId: json['userId'],
      courtId: json['courtId'],
      courtName: json['courtName'],
      courtImageUrl: json['courtImageUrl'],
      dateTime: DateTime.parse(json['dateTime']),
      userName: json['userName'],
      instructor: json['instructor'],
      comment: json['comment'],
      isFavorite: json['isFavorite'] ?? false,
      rainProbability:
          (json['rainProbability'] != null)
              ? (json['rainProbability'] as num).toDouble()
              : null,
    );
  }

  factory ReservationModel.fromEntity(ReservationEntity entity) {
    return ReservationModel(
      id: entity.id,
      userId: entity.userId,
      courtId: entity.courtId,
      courtName: entity.courtName,
      courtImageUrl: entity.courtImageUrl,
      dateTime: entity.dateTime,
      userName: entity.userName,
      instructor: entity.instructor,
      comment: entity.comment,
      isFavorite: entity.isFavorite,
      rainProbability: entity.rainProbability,
    );
  }

  ReservationEntity toEntity() {
    return ReservationEntity(
      id: id,
      userId: userId,
      courtId: courtId,
      courtName: courtName,
      courtImageUrl: courtImageUrl,
      dateTime: dateTime,
      userName: userName,
      instructor: instructor,
      comment: comment,
      isFavorite: isFavorite,
      rainProbability: rainProbability,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courtId': courtId,
      'courtName': courtName,
      'courtImageUrl': courtImageUrl,
      'dateTime': dateTime.toIso8601String(),
      'userName': userName,
      'instructor': instructor,
      'comment': comment,
      'isFavorite': isFavorite,
      'rainProbability': rainProbability,
    };
  }

  ReservationModel copyWith({
    String? id,
    String? userId,
    String? courtId,
    String? courtName,
    String? courtImageUrl,
    DateTime? dateTime,
    String? userName,
    String? instructor,
    String? comment,
    bool? isFavorite,
    double? rainProbability,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courtId: courtId ?? this.courtId,
      courtName: courtName ?? this.courtName,
      courtImageUrl: courtImageUrl ?? this.courtImageUrl,
      dateTime: dateTime ?? this.dateTime,
      userName: userName ?? this.userName,
      instructor: instructor ?? this.instructor,
      comment: comment ?? this.comment,
      isFavorite: isFavorite ?? this.isFavorite,
      rainProbability: rainProbability ?? this.rainProbability,
    );
  }
}
