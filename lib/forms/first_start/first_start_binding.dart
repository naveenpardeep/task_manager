import 'package:get/get.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

// ignore: deprecated_member_use
class FirstStartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrganizationController());
  }
}
