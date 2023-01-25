import 'package:get/get.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../model/data_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataController(), permanent: true);
    Get.put(UserAccountController());
  }
}
