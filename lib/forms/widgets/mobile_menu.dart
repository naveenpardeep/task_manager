import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/invitation/acceptController.dart';
import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
import '../../app_pages.dart';

class TmMobileMenu extends StatelessWidget {
  const TmMobileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: ControlOptions.instance.colorGrey),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Get.find<ProjectController>().refreshData();
              Get.toNamed(Routes.projectListPage);
            },
            child: Icon(
              Icons.hub,
              color: ControlOptions.instance.colorMain,
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.find<TasksController>().refreshData();
              Get.toNamed(Routes.tasksListPage);
            },
            child: Icon(
              Icons.task,
              color: ControlOptions.instance.colorMain,
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed(Routes.userAccountListPage);
            },
            child: Icon(
              Icons.groups,
              color: ControlOptions.instance.colorMain,
            ),
          )),
          Expanded(
            child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.organizationListMobilePage);
                 // Get.toNamed(Routes.organizationPage);
                  //  Get.find<OrganizationController>().newItemPageOpen(pageName: Routes.organizationPage );
                },
                child: Icon(
                  Icons.apartment,
                  color: ControlOptions.instance.colorMain,
                )),
          ),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.find<InvitationController>().newItemPageOpen(pageName: Routes.acceptInvitationPage);
            },
            child: Icon(
              Icons.insert_invitation,
              color: ControlOptions.instance.colorMain,
            ),
          )),
          Expanded(
            child: InkWell(
              onTap: () {
                Get.find<AccpetController>().refreshData();
                Get.find<AccpetController>().newItemPageOpen(pageName: Routes.acceptRejectListPage);
              },
              child: Icon(
                Icons.list_alt,
                color: ControlOptions.instance.colorMain,
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
                  color: ControlOptions.instance.colorMain,
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
                  child: Text(
                    Get.find<NotificationController>().items.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      // Get.toNamed(Routes.userProfilePage);
                      Get.find<UserAccountController>().itemPageOpen(Get.find<UserAccountController>().currentItem, Routes.userProfilePage);
                    },
                    child: ClipOval(
                      child: Get.find<DataController>().currentUser.photoFile.isEmpty
                          ? Container(
                              decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                              width: 32,
                              height: 32,
                              child: Icon(
                                Icons.account_circle,
                                size: 20,
                                color: ControlOptions.instance.colorMain.withOpacity(0.4),
                              ),
                            )
                          : Image.memory(
                              Uint8List.fromList(Get.find<DataController>().currentUser.photoFile),
                              fit: BoxFit.cover,
                              width: 32,
                              height: 32,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
