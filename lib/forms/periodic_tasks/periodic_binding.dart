import 'package:get/get.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_task_comment_controller.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_task_file_controller.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_tasks_controller.dart';


// ignore: deprecated_member_use
class PeriodicBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PeriodicTasksController());
    Get.put(PeriodicTaskCommentsController());
    Get.put(PeriodicTaskFilesController());


   
  }
}
