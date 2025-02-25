class CoordinatesModel {
  String? roomId;
  String? senderId;
  double? latitude;
  double? longitude;

  CoordinatesModel({
    this.roomId,
    this.senderId,
    this.latitude,
    this.longitude,
  });

  @override
  String toString() {
    return 'CoordinatesModel(roomId: $roomId, senderId: $senderId, latitude: $latitude, longitude: $longitude)';
  }

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      roomId: json['roomId'] as String?,
      senderId: json['senderId'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
    );
  }

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'senderId': senderId,
        'latitude': latitude,
        'longitude': longitude,
      };

  CoordinatesModel copyWith({
    String? roomId,
    String? senderId,
    double? latitude,
    double? longitude,
  }) {
    return CoordinatesModel(
      roomId: roomId ?? this.roomId,
      senderId: senderId ?? this.senderId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
