import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/invitation/acceptController.dart';
import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
import '../../app_pages.dart';

class TmTopMenu extends StatelessWidget {
  const TmTopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ControlOptions.instance.colorMain),
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
                      onTap: () {
                        Get.find<ProjectController>().refreshData();

                        Get.find<ServiceObjectController>().selectedItem = null;
                        NsgNavigator.instance.toPage(Routes.projectListPage);
                        // Get.find<ProjectController>()
                        //     .itemPageOpen(Get.find<ProjectController>().currentItem, Routes.projectListPage, needRefreshSelectedItem: true);
                        //  Get.toNamed(Routes.projectListPage);
                      },
                      child: Text(
                        'Проекты',
                        style: TextStyle(color: ControlOptions.instance.colorMainText, fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.find<TasksController>().refreshData();
                        Get.toNamed(Routes.tasksListPage);
                      },
                      child: Text(
                        'Задачи',
                        style: TextStyle(color: ControlOptions.instance.colorMainText, fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.userAccountListPage);
                      },
                      child: Text(
                        'Пользователи',
                        style: TextStyle(color: ControlOptions.instance.colorMainText, fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.organizationListMobilePage);
                        //  Get.toNamed(Routes.organizationPage);
                        //  Get.find<OrganizationController>().newItemPageOpen(pageName: Routes.organizationPage );
                      },
                      child: Text(
                        'Организации',
                        style: TextStyle(color: ControlOptions.instance.colorMainText, fontSize: ControlOptions.instance.sizeXL),
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
                    message: 'Invitations',
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.invitationAcceptNew);
                        },
                        child: Icon(
                          Icons.insert_invitation_sharp,
                          color: ControlOptions.instance.colorMainText,
                        ),
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'Invited User List',
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.acceptRejectListPage);
                        },
                        child: Icon(
                          Icons.list_alt,
                          color: ControlOptions.instance.colorMainText,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.notificationPage);
                          //  Get.find<NotificationController>().newItemPageOpen(pageName: Routes.notificationPage
                          // );
                        },
                        child: Icon(
                          Icons.notifications,
                          color: ControlOptions.instance.colorWhite,
                          size: 32,
                        ),
                      ),
                      Positioned(
                        right: 1,
                        top: 1,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
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
