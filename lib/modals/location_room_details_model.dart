class LocationRoomDetailsModel {
  String? id;
  String? roomId;
  String? senderId;
  double? latitude;
  double? longitude;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? v;

  LocationRoomDetailsModel({
    this.id,
    this.roomId,
    this.senderId,
    this.latitude,
    this.longitude,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'LocationRoomDetailsModel(id: $id, roomId: $roomId, senderId: $senderId, latitude: $latitude, longitude: $longitude, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory LocationRoomDetailsModel.fromJson(Map<String, dynamic> json) {
    return LocationRoomDetailsModel(
      id: json['_id'] as String?,
      roomId: json['roomId'] as String?,
      senderId: json['senderId'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null ? null : json['createdAt'] as String,
      updatedAt: json['updatedAt'] == null ? null : json['updatedAt'] as String,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'roomId': roomId,
        'senderId': senderId,
        'latitude': latitude,
        'longitude': longitude,
        'isActive': isActive,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };

  LocationRoomDetailsModel copyWith({
    String? id,
    String? roomId,
    String? senderId,
    double? latitude,
    double? longitude,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return LocationRoomDetailsModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      senderId: senderId ?? this.senderId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }
}
