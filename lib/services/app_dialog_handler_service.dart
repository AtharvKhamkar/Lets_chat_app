import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lets_chat/constants/constants.dart';
import 'package:lets_chat/modals/user_details_model.dart';
import 'package:lets_chat/repository/user_repository.dart';
import 'package:lets_chat/utils/colors.dart';

class AppDialogHandlerService {
  AppDialogHandlerService._();

  static final AppDialogHandlerService _instance = AppDialogHandlerService._();

  static AppDialogHandlerService get instance => _instance;

  static void showUserDetailsDialog(String userId) {
    final userRepository = UserRepository();
    Get.dialog(
        PopScope(
          canPop: true,
          child: Dialog(
            backgroundColor: Colors.blue.shade100,
            child: SizedBox(
              height: Get.height * 0.5,
              child: FutureBuilder<UserDetailsModel?>(
                  future: userRepository.userDetails(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: AppColors.primaryColor,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Some error occured'),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(
                        child: Text('No user details found'),
                      );
                    }

                    if (snapshot.hasData && snapshot.data != null) {
                      final userDetails = snapshot.data!;
                      DateTime utcTime = DateTime.parse(userDetails.createdAt!);

                      DateTime localCreatedTime = utcTime.toLocal();

                      String formattedLocalCreatedTime =
                          DateFormat('dd MMM yyyy').format(localCreatedTime);

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.blue[300],
                                radius: Get.width * 0.12,
                                child: Text(
                                  userDetails.username![0].toUpperCase(),
                                  style: const TextStyle(fontSize: 64),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Username : ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
                                  TextSpan(
                                    text: userDetails.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Email : ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
                                  TextSpan(
                                    text: userDetails.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Joined from : ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
                                  TextSpan(
                                    text: formattedLocalCreatedTime,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const Center(
                      child: Text('Default returned'),
                    );
                  }),
            ),
          ),
        ),
        barrierDismissible: true,
        transitionDuration: const Duration(milliseconds: 400),
        transitionCurve: Curves.easeInOut);
  }

  static void chooseAttachmentTypeDialog() {
    Get.bottomSheet(
      backgroundColor: AppColors.primaryColor,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: Constants.kAttachmentTypesOptions.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
          itemBuilder: (context, index) {
            Map<String, dynamic> option =
                Constants.kAttachmentTypesOptions[index];
            return buildSingleAttachmentItem(context,
                assetPath: option['assetPath'] ?? '',
                title: option['title'] ?? '',
                onTap: option['action']);
          },
        ),
      ),
    );
  }

  static Widget buildSingleAttachmentItem(BuildContext context,
      {required String assetPath,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: SvgPicture.asset(
              assetPath,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
