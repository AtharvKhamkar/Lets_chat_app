import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lets_chat/constants/app_config.dart';
import 'package:lets_chat/main_prod.dart';
import 'package:lets_chat/modals/chat_history_model..dart';
import 'package:lets_chat/modals/send_messsage_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? socket;
  final messageStream = ValueNotifier<List<Message>>([]);
  final typingStream = ValueNotifier<bool>(false);
  AppConfig appConfig = getIt<AppConfig>();

  Future<void> connect(String roomId, String userId) async {
    socket = IO.io(
        appConfig.BASE_CHAT_URL,
        // Constants.BASE_IOS_CHAT_LOCAL_URL,
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
          final jsonData = jsonEncode(data);
          debugPrint('Data from chatHistory event (formatted JSON): $jsonData');

          ///History Object from 'chatHistory' event
          final chatHistoryObject = ChatHistoryModel.fromJson(data);

          ///Sending only messages list to the messageStream
          messageStream.value = chatHistoryObject.messages;
        }
      },
    );

    socket!.on('message', (data) {
      if (data != null) {
        final jsonData = jsonEncode(data);
        debugPrint('Data from message event (formatted JSON): $jsonData');

        final parsedMessage = Message.fromJson(data);

        messageStream.value = [...messageStream.value, parsedMessage];
      }
    });

    socket!.on('typing', (data) {
      debugPrint('received value of the typing event is $data');

      typingStream.value = data;
    });

    socket!.on('shareLocation', (data) {
      print('Received data from SHARE LOCATION EVENT is $data');
    });

    socket!.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket!.onError((error) {
      print('Socket Error: $error');
    });
  }

  void sendMessage(SendMesssageModel message) {
    if (socket != null) {
      socket!.emit(
        'message',
        {
          'roomId': message.roomId,
          'senderId': message.senderId,
          'message': message.content,
          'messageType': message.messageType
        },
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

  Future<void> shareLocationSharingEvent(
      String roomId, String senderId, double latitude, double longitude) async {
    if (socket != null) {
      print(
          'updating latest location latitude $latitude , longitude $longitude');
      socket!.emit('shareLocation', {
        'roomId': roomId,
        'senderId': senderId,
        'latitude': latitude,
        'longitude': longitude
      });
    }
  }

  void disconnect() {
    socket?.disconnect();
    socket = null;
  }
}
