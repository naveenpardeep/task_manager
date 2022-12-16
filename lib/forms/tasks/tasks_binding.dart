import 'package:get/get.dart';
import 'package:task_manager_app/forms/tasks/task_image_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../project/project_controller.dart';
import '../task_status/task_status_controller.dart';

class TasksListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TasksController());
    Get.put(ProjectController());
    Get.put(CommentTableTasksController());
    Get.put(TaskImageController());
    Get.put(TaskStatusController());
    Get.put(UserAccountController());
  }
}
