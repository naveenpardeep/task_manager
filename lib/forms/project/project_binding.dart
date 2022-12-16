import 'package:get/get.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_binding.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProjectController());
    Get.put(TasksController());
  }
}
