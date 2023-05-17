import 'package:get/get.dart';
import 'package:task_manager_app/forms/TaskList/taskList_file_controller.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';

import 'package:task_manager_app/forms/TaskList/tasklist_controller.dart';



import '../project/project_controller.dart';



// ignore: deprecated_member_use
class TaskListBinding extends Bindings {
  @override
  void dependencies() {
   
    Get.put(ProjectController());
    Get.put(TaskListController());
    Get.put(NotificationController());
    Get.put(TaskListFilesController());
    Get.put(TasklistTaskCheckListController());
    
  }
}
