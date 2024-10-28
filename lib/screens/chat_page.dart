import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/controller/chat_controller.dart';
import 'package:lets_chat/modals/user_modal.dart';
import 'package:lets_chat/services/chat_service.dart';
import 'package:lets_chat/services/shared_preference_service.dart';
import 'package:lets_chat/utils/util_function.dart';
import 'package:lets_chat/widgets/custom_appbar.dart';
import 'package:lets_chat/widgets/custom_padding.dart';

class ChatPage extends StatefulWidget {
  final User receiverUser;
  const ChatPage({super.key, required this.receiverUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GetIt _getIt = GetIt.instance;
  late SharedPreferenceService _sharedPref;
  late ChatService _chatService;
  String? _userId;
  String? _roomId;
  String? _receiverId;
  bool _loading = true;
  final AuthController controller =
      AuthController().initialized ? Get.find() : Get.put(AuthController());

  final ChatController chatController =
      ChatController().initialized ? Get.find() : Get.put(ChatController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatService = _getIt.get<ChatService>();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    _sharedPref = await _getIt.getAsync<SharedPreferenceService>();

    _userId = _sharedPref.prefs!.getString(SharedPreferenceService.userIdKey);
    _receiverId = widget.receiverUser.Id;

    if (_userId != null && _receiverId != null) {
      initializeRoom(_userId!, _receiverId!);
      _chatService.connect(_roomId!, _userId!);
      setState(() => _loading = false);
    }
  }

  void initializeRoom(String userId, String receiverId) {
    final result = chatController.createChatRoom(userId, receiverId);
    _roomId = UtilFunction().generateChatID(uid1: userId, uid2: receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.receiverUser.username!),
      body: const CustomPadding(
          child: Column(
        children: [],
      )),
    );
  }
}
