import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? socket;
  final messageStream = ValueNotifier<List<Map<String, dynamic>>>([]);

  void connect(String roomId, String userId) {
    socket = IO.io(
        'https://lets-chat-backend-5wa8.onrender.com',
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
          messageStream.value = List<Map<String, dynamic>>.from(data);
        }
      },
    );

    socket!.on('message', (data) {
      if (data != null) {
        debugPrint('Data from message event $data');
        messageStream.value = [...messageStream.value, data];
      }
    });

    socket!.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket!.onError((error) {
      print('Socket Error: $error');
    });
  }

  void sendMessage(String roomId, String senderId, String message) {
    if (socket != null) {
      socket!.emit(
        'message',
        {'roomId': roomId, 'senderId': senderId, 'message': message},
      );
    }
  }

  void disconnect() {
    socket?.disconnect();
    socket = null;
  }
}
