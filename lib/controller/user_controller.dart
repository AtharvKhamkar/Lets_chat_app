import 'package:get/get.dart';
import 'package:lets_chat/modals/user_modal.dart';
import 'package:lets_chat/repository/user_repository.dart';

class UserController extends GetxController with StateMixin<dynamic> {
  final _userRepo = UserRepository();
  RxList<User> userList = <User>[].obs;

  //Booleans
  var isLoading = false.obs;
  var hasData = false.obs;

  //Strings
  var errorMessage = ''.obs;

  void getUserList() async {
    if (isLoading.value) return;
    isLoading(true);
    update();

    final result = await _userRepo.userList();
    userList.assignAll(result!);

    isLoading(false);
    update();
  }

  // void getUserDetails(String userId) async {
  //   if (isLoading.value) return;
  //   isLoading(true);
  //   update();

  //   final result = await _userRepo.userDetails(userId);
  // }
}
