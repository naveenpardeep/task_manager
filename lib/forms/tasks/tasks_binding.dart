import 'package:get/get.dart';

import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

import '../project/project_controller.dart';
import '../task_status/task_status_controller.dart';
import 'task_user_account_controler.dart';

// ignore: deprecated_member_use
class TasksListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TasksController());
    Get.put(ProjectController());
    Get.put(CommentTableTasksController());
    Get.put(TaskStatusController());
    Get.put(TaskUserAccountController());

    Get.put(TaskCheckListController());

    Get.put(TaskFilesController());
  }
}
