import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? socket;

  void connect(String roomId, String userId) {
    socket = IO.io(
        'https://lets-chat-backend-5wa8.onrender.com',
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {'autoconnect': false}).build());
    socket!.connect();
    socket!.onConnect((_) {
      print('connect');
      socket!.emit('msg', 'test');
    });

    socket!.on('chatHistory', (data) {
      debugPrint(data);
    });

    socket!.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket!.onError((error) {
      print('Socket Error: $error');
    });
  }
}
