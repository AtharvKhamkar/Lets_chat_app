import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lets_chat/constants/asset_path.dart';
import 'package:lets_chat/constants/constants.dart';
import 'package:lets_chat/modals/nearby_places_model.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: Constants.kAttachmentTypesOptions.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
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
        spacing: 8,
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
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }

  static Future<bool> customPermissionHandlerDialog(
      {required String title,
      required String description,
      required String confirmText,
      String? cancelText,
      required void Function()? onConfirm,
      required void Function()? onCancel}) async {
    return await Get.defaultDialog<bool>(
            title: title,
            middleText: description,
            textConfirm: confirmText,
            textCancel: cancelText ?? 'Cancel',
            onConfirm: onConfirm,
            onCancel: onCancel) ??
        false;
  }

  static void showNearByPlacesBottomSheet(
      BuildContext context, List<NearbyPlacesModel> nearbyPlacesList) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                // borderRadius: BorderRadius.vertical(
                //   top: Radius.circular(20),
                // ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    const NearbyPlacesTile(
                        assetPath: AssetPath.kShareLocation,
                        title: 'Share live location'),
                    const Divider(
                      thickness: 0.1,
                      color: AppColors.textFieldTitleColor,
                    ),
                    Text(
                      'Nearby Places',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: AppColors.textFieldTitleColor),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: nearbyPlacesList.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const NearbyPlacesTile(
                                assetPath: AssetPath.kCurrentLocation,
                                title: 'Send your current location');
                          }
                          final NearbyPlacesModel nearByPlace =
                              nearbyPlacesList[index - 1];
                          return NearbyPlacesTile(
                            assetPath: nearByPlace.icon ?? '',
                            title: nearByPlace.name ?? 'N/A',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class NearbyPlacesTile extends StatelessWidget {
  const NearbyPlacesTile({
    super.key,
    required this.assetPath,
    required this.title,
  });

  final String assetPath;
  final String title;

  bool isNetworkImage(String path) {
    return Uri.tryParse(path)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.secondaryColor,
            child: isNetworkImage(assetPath)
                ? Image.network(
                    color: AppColors.primaryColor,
                    height: 20,
                    width: 20,
                    assetPath,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.error,
                      color: AppColors.textFieldTitleColor,
                    ),
                  )
                : Image.asset(
                    color: AppColors.primaryColor,
                    height: 20,
                    width: 20,
                    assetPath)),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColors.textFieldTitleColor),
        ),
      ),
    );
  }
}
