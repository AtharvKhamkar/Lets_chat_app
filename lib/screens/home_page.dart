import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/services/chat_service.dart';
import 'package:lets_chat/services/shared_preference_service.dart';
import 'package:lets_chat/utils/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  late ChatService _chatService;
  String? _userName;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatService = _getIt.get<ChatService>();
    _chatService.connect();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails()async{
    SharedPreferenceService _sharedPref = await _getIt.getAsync<SharedPreferenceService>();

    setState(() {
      _userName = _sharedPref.prefs?.getString(SharedPreferenceService.userNameKey);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lets_Chat'),
      ),
      body: Center(
        child: _loading ? const CircularProgressIndicator.adaptive() : Text('Username : $_userName',style: TextStyles.headLine1,),
      )
    );
  }
}
