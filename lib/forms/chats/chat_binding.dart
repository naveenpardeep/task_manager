import 'package:get/get.dart';
import 'package:task_manager_app/forms/chats/chat_controller.dart';
import 'package:task_manager_app/forms/chats/chat_tasklist_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';





// ignore: deprecated_member_use
class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
    Get.put(TasksController());
    Get.put(ProjectStatusController());
    Get.put(ChatTaskListController());

  
  
  }
}
