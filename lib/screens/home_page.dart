import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/services/chat_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late ChatService _chatService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatService = _getIt.get<ChatService>();
    _chatService.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lets_Chat'),
      ),
      body: Container(),
    );
  }
}
