import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
                                  const TextSpan(
                                    text: 'Username : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryColor),
                                  ),
                                  TextSpan(
                                    text: userDetails.username,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Email : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryColor),
                                  ),
                                  TextSpan(
                                    text: userDetails.email,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Joined from : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.primaryColor),
                                  ),
                                  TextSpan(
                                    text: formattedLocalCreatedTime,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold),
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
}
