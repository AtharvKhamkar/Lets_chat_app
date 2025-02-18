import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/constants/constants.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/controller/chat_controller.dart';
import 'package:lets_chat/modals/user_modal.dart';
import 'package:lets_chat/services/app_dialog_handler_service.dart';
import 'package:lets_chat/services/chat_service.dart';
import 'package:lets_chat/services/shared_preference_service.dart';
import 'package:lets_chat/utils/colors.dart';
import 'package:lets_chat/utils/text_styles.dart';
import 'package:lets_chat/utils/util_function.dart';
import 'package:lets_chat/widgets/custom_appbar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

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

    debugPrint('UserId from the initializeSharedPreferences function $_userId');

    if (_userId != null && _receiverId != null) {
      await initializeRoom(_userId!, _receiverId!);
      await chatController.connectToSocket(_roomId!, _userId!);
      setState(() => _loading = false);
    }
  }

  Future<void> initializeRoom(String userId, String receiverId) async {
    final result = chatController.createChatRoom(userId, receiverId);
    _roomId = UtilFunction().generateChatID(uid1: userId, uid2: receiverId);
    Constants.kCurrentRoomId = _roomId ?? '';
  }

  void _onSendPressed(types.PartialText message) async {
    if (_roomId != null && _userId != null) {
      await chatController.sendMessage(_roomId!, _userId!, message.text);
      await chatController.sendTypingEvent(_roomId!, _receiverId!, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.receiverUser.username!,
          actions: [
            IconButton(
                onPressed: () {
                  AppDialogHandlerService.chooseAttachmentTypeDialog();
                },
                icon: const Icon(Icons.plus_one)),
            IconButton(
              onPressed: () {
                chatController.sendImageMessage(_roomId!, _userId!);
              },
              icon: const Icon(
                Icons.file_upload_outlined,
                color: Colors.white,
              ),
            )
          ],
          textWidget: Obx(() {
            return chatController.isOtherUserTyping.value
                ? const Text(
                    'Typing...',
                    style: TextStyles.defaultText,
                  )
                : const SizedBox.shrink();
          }),
        ),
        body: _userId != null
            ? Obx(() => Chat(
                  messages: chatController.messages.toList(),
                  onSendPressed: _onSendPressed,
                  onAttachmentPressed: () {
                    //for sending image
                    // chatController.sendImageMessage(_roomId!, _userId!);
                    AppDialogHandlerService.chooseAttachmentTypeDialog();

                    //For sending file
                    // chatController.sendFileMessage(_roomId!, _userId!);
                  },
                  user: types.User(id: _userId!),
                  theme: const DefaultChatTheme(
                      backgroundColor: AppColors.primaryColor,
                      inputBackgroundColor: AppColors.secondaryColor),
                  inputOptions: InputOptions(onTextChanged: (text) {
                    debugPrint(
                        'User started typing :: length of the text is ${text.length}');
                    // if (text.isNotEmpty) {
                    //   chatController.sendTypingEvent(
                    //       _roomId!, _receiverId!, true);
                    // } else {
                    //   chatController.sendTypingEvent(
                    //       _roomId!, _receiverId!, false);
                    // }
                    chatController.onTextChanged(
                        _roomId!, text, _receiverId!, true);
                  }),
                ))
            : const Center(
                child: Text(
                  'User Id not found',
                  style: TextStyles.defaultText,
                ),
              ),
      ),
    );
  }
}
