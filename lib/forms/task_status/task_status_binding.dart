import 'package:get/get.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';

import 'task_status_controller.dart';

// ignore: deprecated_member_use
class TaskStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskStatusController());
    Get.put(ProjectStatusController());
  }
}
