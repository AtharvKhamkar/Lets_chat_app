import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/constants/asset_path.dart';
import 'package:lets_chat/controller/chat_controller.dart';
import 'package:lets_chat/controller/user_controller.dart';
import 'package:lets_chat/modals/user_modal.dart';
import 'package:lets_chat/screens/chat_page.dart';
import 'package:lets_chat/services/app_dialog_handler_service.dart';
import 'package:lets_chat/services/shared_preference_service.dart';
import 'package:lets_chat/utils/text_styles.dart';
import 'package:lets_chat/widgets/custom_appbar.dart';
import 'package:lets_chat/widgets/custom_padding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetIt _getIt = GetIt.instance;
  String? _userName;
  bool _loading = true;

  final UserController controller =
      UserController().initialized ? Get.find() : Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserDetails();
    controller.getUserList();
  }

  Future<void> _loadUserDetails() async {
    SharedPreferenceService _sharedPref =
        await _getIt.getAsync<SharedPreferenceService>();

    setState(() {
      _userName =
          _sharedPref.prefs?.getString(SharedPreferenceService.userNameKey);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chats',
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AssetPath.kMessagePlus,
              height: 30,
              width: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AssetPath.kMessageRead,
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body: CustomPadding(
        child: GetBuilder<UserController>(
          initState: (_) => controller.userList(),
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              );
            }

            if (controller.userList.isEmpty) {
              return const Center(
                child: Text(
                  'No users found',
                  style: TextStyles.defaultText,
                ),
              );
            }

            return ListView.builder(
              itemCount: controller.userList.length,
              itemBuilder: (context, index) {
                User user = controller.userList[index];
                return ChatTile(
                  receiverUser: user,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final User receiverUser;
  const ChatTile({super.key, required this.receiverUser});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.1,
      width: Get.width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              AppDialogHandlerService.showUserDetailsDialog(
                  receiverUser.Id ?? '');
            },
            child: CircleAvatar(
              backgroundColor: Colors.blue[300],
              child: Text(receiverUser.username![0].toUpperCase()),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => ChatPage(receiverUser: receiverUser),
                  binding: ChatBinding());
            },
            child: SizedBox(
              child: Text(
                receiverUser.username!,
                style: TextStyles.headLine2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
