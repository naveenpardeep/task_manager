import 'package:get/get.dart';
import 'package:task_manager_app/forms/invitation/acceptController.dart';
import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_controller.dart';

import '../task_status/project_status_controller.dart';
import '../tasks/task_file_controller.dart';
import '../user_account/service_object_controller.dart';
import '../user_account/user_project_notificationController.dart';

// ignore: deprecated_member_use
class ProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProjectController());
    Get.put(ProjectItemUserTableController());
    Get.put(TasksController());
    Get.put(UserAccountController());
    Get.put(TaskStatusController());
    Get.put(TaskBoardController());
    Get.put(TaskStatusTableController());
    Get.put(ProjectStatusController());
    Get.put(ServiceObjectController());
    Get.put(InvitationController());
    Get.put(OrganizationController());
    Get.put(NotificationController());
    Get.put(OrganizationItemUserTableController());
    Get.put(UserImageController());
    Get.put(UserNotificationController());
    Get.put(UserNotificationSettingStatusTableController());
    Get.put(OrganizationItemUserTableController());
    Get.put(CommentTableTasksController());
    Get.put(AccpetController());
    Get.put(ProjectUserController());
    Get.put(UserProjectNotificationController());
    Get.put(TaskCheckListController());
    Get.put(ProjectUserController());
    Get.put(TaskFilesController());
  }
}
