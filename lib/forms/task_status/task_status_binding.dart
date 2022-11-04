import 'package:get/get.dart';

import 'task_status_controller.dart';

class TaskStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskStatusController());
  }
}
