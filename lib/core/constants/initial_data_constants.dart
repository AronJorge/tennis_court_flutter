import 'package:nolatech_tenis/core/constants/assets_constants.dart';

class InitialDataCourts {
  static const courts = [
    {
      'id': '1',
      'name': 'Epic Box',
      'imageUrl': Assets.court1,
      'type': 'A',
      'isAvailable': true,
      'latitude': 4.7110,
      'longitude': -74.0721,
      'availableStartTime': '07:00',
      'availableEndTime': '17:00',
    },
    {
      'id': '2',
      'name': 'Desert Court',
      'imageUrl': Assets.court2,
      'type': 'B',
      'isAvailable': true,
      'latitude': 36.1699,
      'longitude': -115.1398,
      'availableStartTime': '08:00',
      'availableEndTime': '18:00',
    },
    {
      'id': '4',
      'name': 'Mountain Top',
      'imageUrl': Assets.court3,
      'type': 'D',
      'isAvailable': true,
      'latitude': -33.8688,
      'longitude': 151.2093,
      'availableStartTime': '07:00',
      'availableEndTime': '17:00',
    },
  ];
}

class InitialDataReservations {
  static const reservations = [
    {
      'id': 'r1',
      'userId': 'user1',
      'courtId': '1',
      'courtName': 'Epic Box',
      'courtImageUrl': Assets.court1,
      'userName': 'Andrea',
      'instructor': 'Instructor A',
      'comment': 'Practicing serves',
      'isFavorite': false,
    },
    {
      'id': 'r2',
      'userId': 'user2',
      'courtId': '2',
      'courtName': 'Desert Court',
      'courtImageUrl': Assets.court2,
      'userName': 'Carlos',
      'instructor': 'Instructor B',
      'comment': 'Backhand training',
      'isFavorite': true,
    },
  ];
}
