import 'package:get/get.dart';
import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../forms/organization/organization_controller.dart';
import '../forms/user_account/service_object_controller.dart';
import '../model/data_controller.dart';

// ignore: deprecated_member_use
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DataController(), permanent: true);
    Get.put(UserAccountController());
    Get.put(InvitationController());
    Get.put(ProjectController());
    Get.put(OrganizationController());
    Get.put(ServiceObjectController(), permanent: true);
  }
}
