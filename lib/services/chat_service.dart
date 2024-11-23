import 'package:flutter/material.dart';
import 'package:lets_chat/constants/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? socket;
  final messageStream = ValueNotifier<List<Map<String, dynamic>>>([]);
  final typingStream = ValueNotifier<bool>(false);

  Future<void> connect(String roomId, String userId) async {
    socket = IO.io(
        Constants.BASE_ANDROID_CHAT_LOCAL_URL,
        // 'ws://127.0.0.1:2525',
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {'autoconnect': false}).build());
    socket!.connect();
    socket!.onConnect(
      (_) {
        print('connect');
        socket!.emit('msg', 'test');
      },
    );

    socket!.on(
      'chatHistory',
      (data) {
        if (data != null) {
          debugPrint('Data from chatHistory event $data');
          messageStream.value =
              List<Map<String, dynamic>>.from(data['messages']);
        }
      },
    );

    socket!.on('message', (data) {
      if (data != null) {
        debugPrint('Data from message event $data');
        messageStream.value = [...messageStream.value, data];
      }
    });

    socket!.on('typing', (data) {
      debugPrint('received value of the typing event is $data');

      typingStream.value = data;
    });

    socket!.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket!.onError((error) {
      print('Socket Error: $error');
    });
  }

  void sendMessage(
      String roomId, String senderId, Map<String, dynamic> message) {
    if (socket != null) {
      socket!.emit(
        'message',
        {'roomId': roomId, 'senderId': senderId, 'message': message['content']},
      );
    }
  }

  void sendTypingEvent(String roomId, String receiverId, bool typingStatus) {
    if (socket != null) {
      socket!.emit('typing',
          {"roomId": roomId, "receiverId": receiverId, "status": typingStatus});
    }
  }

  Future<void> joinRoom(String roomId, String userId) async {
    if (socket != null) {
      debugPrint('Before the join room event');
      socket!.emit('join', {'roomId': roomId, 'userId': userId});
    }
  }

  void disconnect() {
    socket?.disconnect();
    socket = null;
  }
}
