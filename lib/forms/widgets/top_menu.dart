import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/TaskList/tasklist_controller.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_tasks_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/generated/task_doc.g.dart';
import '../../app_pages.dart';

class TmTopMenu extends StatelessWidget {
  const TmTopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Get.find<ProjectController>().refreshData();

                        Get.find<ServiceObjectController>().selectedItem = null;
                        Get.offAndToNamed(Routes.projectListPage);
                        // Get.find<ProjectController>()
                        //     .itemPageOpen(Get.find<ProjectController>().currentItem, Routes.projectListPage, needRefreshSelectedItem: true);
                        //  Get.toNamed(Routes.projectListPage);
                      },
                      child: Text(
                        'Проекты',
                        style: TextStyle(color: const Color(0xff529FBF), fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Get.find<TaskListController>().refreshData();
                        Get.offAndToNamed(Routes.tasksListPage);
                      },
                      child: Text(
                        'Задачи',
                        style: TextStyle(color: const Color(0xff529FBF), fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        //  Get.find<TaskListController>().refreshData();
                        // Get.offAndToNamed(Routes.newTasklistPage);
                        Get.find<TaskListController>().itemNewPageOpen(Routes.newTasklistPage);
                        Get.find<TaskListController>().refreshData();
                      },
                      child: Text(
                        'Tasklist',
                        style: TextStyle(color: const Color(0xff529FBF), fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Get.find<TasksController>().isPeriodicController = true;
                        Get.find<TaskCommentsController>().isTaskCommentCont=false;
                        
   
                         Get.find<PeriodicTasksController>().itemNewPageOpen(Routes.periodicTasksPage);
                        // Get.find<PeriodicTasksController>().refreshData();
                       // Get.offAndToNamed(Routes.periodicTasksPage);
                      },
                      child: Text(
                        'PeriodicTasks',
                        style: TextStyle(color: const Color(0xff529FBF), fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Get.offAndToNamed(Routes.userAccountListPage);
                      },
                      child: Text(
                        'Пользователи',
                        style: TextStyle(color: const Color(0xff529FBF), fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Get.offAndToNamed(Routes.organizationListMobilePage);
                        //  Get.toNamed(Routes.organizationPage);
                        //  Get.find<OrganizationController>().newItemPageOpen(pageName: Routes.organizationPage );
                      },
                      child: Text(
                        'Организации',
                        style: TextStyle(color: const Color(0xff529FBF), fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 20),
                  //   child: InkWell(
                  //     onTap: () async {
                  //       await Get.find<DataController>().provider!.logout();
                  //       //await Get.find<DataController>().onInit();\
                  //       //await Get.find<DataController>().provider!.resetUserToken();
                  //       await Get.find<DataController>().provider!.connect(Get.find<DataController>());
                  //       //NsgNavigator.instance.offAndToPage(Routes.firstStartPage);
                  //     },
                  //     child: Text(
                  //       'logout',
                  //       style: TextStyle(color: ControlOptions.instance.colorMainText, fontSize: ControlOptions.instance.sizeXL),
                  //     ),
                  //   ),
                  // ),
                  Tooltip(
                    message: 'Chats',
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                           Get.toNamed(Routes.chatPage);
                        },
                        child: const Icon(
                          Icons.chat,
                          color: Color(0xff529FBF),
                        ),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'Invitations',
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed(Routes.invitationAcceptNew);
                        },
                        child: const Icon(
                          Icons.insert_invitation_sharp,
                          color: Color(0xff529FBF),
                        ),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'Invited User List',
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed(Routes.acceptRejectListPage);
                        },
                        child: const Icon(
                          Icons.list_alt,
                          color: Color(0xff529FBF),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      InkWell(
                        hoverColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed(Routes.notificationPage);
                          //  Get.find<NotificationController>().newItemPageOpen(pageName: Routes.notificationPage
                          // );
                        },
                        child: const Icon(
                          Icons.notifications,
                          color: Color(0xff529FBF),
                          size: 32,
                        ),
                      ),
                      Positioned(
                        right: 2,
                        top: 1,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 9,
                            minHeight: 9,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 2, color: ControlOptions.instance.colorMainText)),
            child: InkWell(
              hoverColor: Colors.transparent,
              onTap: () {
                Get.find<UserAccountController>().itemPageOpen(Get.find<DataController>().currentUser, Routes.profileViewPage, needRefreshSelectedItem: true);
              },
              child: ClipOval(
                child: Get.find<DataController>().currentUser.photoName.isEmpty
                    ? const SizedBox(width: 32, height: 32)
                    : Image.network(
                        TaskFilesController.getFilePath(Get.find<DataController>().currentUser.photoName),
                        fit: BoxFit.fill,
                        width: 32,
                        height: 32,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
