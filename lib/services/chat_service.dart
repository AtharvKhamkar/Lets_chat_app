import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  IO.Socket? socket;

  void connect() {
    socket = IO.io(
        'https://lets-chat-backend-5wa8.onrender.com',
        IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {'autoconnect': false}).build());
    socket!.connect();
    socket!.onConnect((_) {
      print('connect');
      socket!.emit('msg', 'test');
    });

    socket!.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket!.onError((error) {
      print('Socket Error: $error');
    });
  }
}
