import 'package:get/get.dart';
import 'package:task_manager_app/forms/TaskList/taskList_file_controller.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_tasks_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_status/new_task_status_controller.dart';

import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/TaskList/tasklist_controller.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

import '../periodic_tasks/periodic_task_file_controller.dart';
import '../project/project_controller.dart';

import 'task_user_account_controler.dart';

// ignore: deprecated_member_use
class TasksListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TasksController());
    Get.put(ProjectController());
    Get.put(CommentTableTasksController());
   
    Get.put(TaskUserAccountController());

    Get.put(TaskCheckListController());

    Get.put(TaskFilesController());
    Get.put(TaskCommentsController());
    Get.put(NewTaskStatusController());
    Get.put(TaskListController());
    Get.put(NotificationController());
    Get.put(TaskListFilesController());
    Get.put(PeriodicTaskFilesController());
    Get.put(PeriodicTaskCheckListController());
    
  }
}
