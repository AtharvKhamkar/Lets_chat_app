class SendMesssageModel {
  String roomId;
  String senderId;
  String content;
  String messageType;

  SendMesssageModel({
    required this.roomId,
    required this.senderId,
    required this.content,
    required this.messageType,
  });

  @override
  String toString() {
    return 'SendMesssageModel(roomId: $roomId, senderId: $senderId, content: $content, messageType: $messageType)';
  }

  factory SendMesssageModel.fromJson(Map<String, dynamic> json) {
    return SendMesssageModel(
      roomId: json['roomId'] as String? ?? 'RoomId unavailable',
      senderId: json['senderId'] as String? ?? 'SenderId unavailable',
      content: json['content'] as String? ?? 'Content unavailable',
      messageType: json['messageType'] as String? ?? 'MessageType unavailable',
    );
  }

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'senderId': senderId,
        'content': content,
        'messageType': messageType,
      };
}
