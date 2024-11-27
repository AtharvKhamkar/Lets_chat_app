class ChatRoomModel {
  String? id;
  String? roomId;
  String? senderId;
  String? receiverId;
  List<dynamic>? messages;
  String? createdAt;
  String? updatedAt;
  int? v;

  ChatRoomModel({
    this.id,
    this.roomId,
    this.senderId,
    this.receiverId,
    this.messages,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'ChatRoomModel(id: $id, roomId: $roomId, senderId: $senderId, receiverId: $receiverId, messages: $messages, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        id: json['_id'] as String?,
        roomId: json['roomId'] as String?,
        senderId: json['senderId'] as String?,
        receiverId: json['receiverId'] as String?,
        messages: json['messages'] as List<dynamic>?,
        createdAt:
            json['createdAt'] == null ? null : json['createdAt'] as String,
        updatedAt:
            json['updatedAt'] == null ? null : json['updatedAt'] as String,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'roomId': roomId,
        'senderId': senderId,
        'receiverId': receiverId,
        'messages': messages,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '__v': v,
      };
}
