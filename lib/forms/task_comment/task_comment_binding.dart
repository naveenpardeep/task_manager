import 'package:get/get.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';



// ignore: deprecated_member_use
class TaskCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskCommentsController());
    Get.put(TasksController());
    Get.put(ProjectStatusController());
  }
}
