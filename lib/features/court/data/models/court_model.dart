import 'package:nolatech_tenis/features/common/domain/entities/court_entity.dart';

class CourtModel extends CourtEntity {
  const CourtModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.type,
    required super.isAvailable,
    required super.rainProbability,
    required super.availableDate,
    required super.availableStartTime,
    required super.availableEndTime,
    required super.latitude,
    required super.longitude,
  });

  factory CourtModel.fromJson(Map<String, dynamic> json) {
    return CourtModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      type: json['type'],
      isAvailable: json['isAvailable'],
      rainProbability: json['rainProbability'],
      availableDate: DateTime.parse(json['availableDate']),
      availableStartTime: json['availableStartTime'],
      availableEndTime: json['availableEndTime'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'type': type,
      'isAvailable': isAvailable,
      'rainProbability': rainProbability,
      'availableDate': availableDate.toIso8601String(),
      'availableStartTime': availableStartTime,
      'availableEndTime': availableEndTime,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
