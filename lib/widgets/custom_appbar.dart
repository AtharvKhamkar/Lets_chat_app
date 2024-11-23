import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lets_chat/utils/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? textWidget;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.textWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Get.currentRoute != '/home-screen'
          ? ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStateColor.transparent,
              ),
              iconAlignment: IconAlignment.start,
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 30,
              ),
            )
          : null,
      actions: actions,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.headLine1),
          textWidget ?? const SizedBox.shrink()
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
