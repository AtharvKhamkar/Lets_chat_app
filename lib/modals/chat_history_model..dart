class ChatHistoryModel {
  String id;
  String roomId;
  SenderDetails senderDetails;
  ReceiverDetails receiverDetails;
  List<Message> messages;

  ChatHistoryModel({
    required this.id,
    required this.roomId,
    required this.senderDetails,
    required this.receiverDetails,
    required this.messages,
  });

  @override
  String toString() {
    return 'ChatHistoryModel(id: $id, roomId: $roomId, senderDetails: $senderDetails, receiverDetails: $receiverDetails, messages: $messages)';
  }

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
      id: json['_id'] as String? ?? 'Id is unavailable',
      roomId: json['roomId'] as String? ?? 'Rooom Id is unavailable',
      senderDetails: json['senderDetails'] == null
          ? SenderDetails(
              senderId: 'SenderId unavailable',
              senderName: 'Sender name unavailable')
          : SenderDetails.fromJson(
              json['senderDetails'] as Map<String, dynamic>),
      receiverDetails: json['receiverDetails'] == null
          ? ReceiverDetails(
              receiverId: 'receiverId unavailable',
              receiverName: 'Receiver Name unavailable')
          : ReceiverDetails.fromJson(
              json['receiverDetails'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'roomId': roomId,
        'senderDetails': senderDetails.toJson(),
        'receiverDetails': receiverDetails.toJson(),
        'messages': messages.map((e) => e.toJson()).toList(),
      };
}

class Message {
  String id;
  String senderId;
  String senderName;
  String content;
  String messageType;
  String createdAt;
  String updatedAt;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.messageType,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, senderName: $senderName, content: $content, messageType: $messageType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json['Id'] as String? ?? 'MessageId unavailable',
        senderId: json['senderId'] as String? ?? 'SenderId unavailable',
        senderName: json['senderName'] as String? ?? 'Sender name unavailable',
        content: json['content'] as String? ?? 'Content unavailable',
        messageType:
            json['messageType'] as String? ?? 'Message type unavailable',
        createdAt:
            json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
        updatedAt:
            json['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
      );

  Map<String, dynamic> toJson() => {
        'Id': id,
        'senderId': senderId,
        'senderName': senderName,
        'content': content,
        'messageType': messageType,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class ReceiverDetails {
  String receiverId;
  String receiverName;

  ReceiverDetails({required this.receiverId, required this.receiverName});

  @override
  String toString() {
    return 'ReceiverDetails(receiverId: $receiverId, receiverName: $receiverName)';
  }

  factory ReceiverDetails.fromJson(Map<String, dynamic> json) {
    return ReceiverDetails(
      receiverId: json['receiverId'] as String? ?? 'ReciverId unavailable',
      receiverName:
          json['receiverName'] as String? ?? 'ReciverName unavailable',
    );
  }

  Map<String, dynamic> toJson() => {
        'receiverId': receiverId,
        'receiverName': receiverName,
      };
}

class SenderDetails {
  String senderId;
  String senderName;

  SenderDetails({required this.senderId, required this.senderName});

  @override
  String toString() {
    return 'SenderDetails(senderId: $senderId, senderName: $senderName)';
  }

  factory SenderDetails.fromJson(Map<String, dynamic> json) => SenderDetails(
        senderId: json['senderId'] as String? ?? 'SenderId unavailable',
        senderName: json['senderName'] as String? ?? 'SenderName unavailable',
      );

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'senderName': senderName,
      };
}
