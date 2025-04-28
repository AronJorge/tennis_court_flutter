import 'package:equatable/equatable.dart';

class CourtEntity extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String type;
  final bool isAvailable;
  final double rainProbability;
  final DateTime availableDate;
  final String availableStartTime;
  final String availableEndTime;
  final double latitude;
  final double longitude;

  const CourtEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.isAvailable,
    required this.rainProbability,
    required this.availableDate,
    required this.availableStartTime,
    required this.availableEndTime,
    required this.latitude,
    required this.longitude,
  });

  CourtEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? type,
    bool? isAvailable,
    double? rainProbability,
    DateTime? availableDate,
    String? availableStartTime,
    String? availableEndTime,
    double? latitude,
    double? longitude,
  }) {
    return CourtEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      isAvailable: isAvailable ?? this.isAvailable,
      rainProbability: rainProbability ?? this.rainProbability,
      availableDate: availableDate ?? this.availableDate,
      availableStartTime: availableStartTime ?? this.availableStartTime,
      availableEndTime: availableEndTime ?? this.availableEndTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    type,
    isAvailable,
    rainProbability,
    availableDate,
    availableStartTime,
    availableEndTime,
    latitude,
    longitude,
  ];

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
