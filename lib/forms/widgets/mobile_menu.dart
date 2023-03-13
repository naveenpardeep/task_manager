import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
import '../../app_pages.dart';

class TmMobileMenu extends StatefulWidget {
  const TmMobileMenu({super.key});

  @override
  State<TmMobileMenu> createState() => _TmMobileMenuState();
}

class _TmMobileMenuState extends State<TmMobileMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
                onTap: () {
                  Get.find<ProjectController>().refreshData();
                  Get.toNamed(Routes.projectListPage);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.folder,
                      color: ControlOptions.instance.colorMain,
                    ),
                    Text('Проекты', style: TextStyle(color: ControlOptions.instance.colorMain,fontSize: 10)),
                  ],
                )),
          ),
          Expanded(
            child: InkWell(
                onTap: () {
                  Get.find<TasksController>().refreshData();
                  Get.toNamed(Routes.tasksListPage);
                },
                child: Column(
                  children: [
                    Icon(Icons.task, color: ControlOptions.instance.colorMain),
                    Text('Задачи', style: TextStyle(color: ControlOptions.instance.colorMain,fontSize: 10))
                  ],
                )),
          ),
          Expanded(
            child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.userAccountListPage);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.people,
                      color: ControlOptions.instance.colorMain,
                    ),
                    Text('Люди', style: TextStyle(color: ControlOptions.instance.colorMain,fontSize: 10))
                  ],
                )),
          ),
          Expanded(
            child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.organizationListMobilePage);

                  // Get.toNamed(Routes.organizationPage);
                  //  Get.find<OrganizationController>().newItemPageOpen(pageName: Routes.organizationPage );
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.apartment,
                      color: ControlOptions.instance.colorMain,
                    ),
                    Text('Компании', style: TextStyle(color: ControlOptions.instance.colorMain,fontSize: 10))
                  ],
                )),
          ),
          // Expanded(
          //     child: InkWell(
          //   onTap: () {
          //     Get.find<InvitationController>().refreshData();
          //     Get.find<InvitationController>().newItemPageOpen(pageName: Routes.invitationAcceptNew);
          //   },
          //   child: Icon(
          //     Icons.insert_invitation,
          //     color: ControlOptions.instance.colorMain,
          //   ),
          // )),
          // Expanded(
          //   child: InkWell(
          //     onTap: () {
          //       Get.find<AccpetController>().refreshData();
          //       Get.find<AccpetController>().newItemPageOpen(pageName: Routes.acceptRejectListPage);
          //     },
          //     child: Icon(
          //       Icons.list_alt,
          //       color: ControlOptions.instance.colorMain,
          //     ),
          //   ),
          // ),
          // Stack(
          //   children: <Widget>[
          //     InkWell(
          //       onTap: () {
          //         Get.toNamed(Routes.notificationPage);
          //         //  Get.find<NotificationController>().newItemPageOpen(pageName: Routes.notificationPage
          //         // );
          //       },
          //       child: Icon(
          //         Icons.notifications,
          //         color: ControlOptions.instance.colorMain,
          //       ),
          //     ),
          //     Positioned(
          //       right: 1,
          //       top: 1,
          //       child: Container(
          //         padding: const EdgeInsets.all(2),
          //         decoration: BoxDecoration(
          //           color: Colors.red,
          //           borderRadius: BorderRadius.circular(6),
          //         ),
          //         constraints: const BoxConstraints(
          //           minWidth: 15,
          //           minHeight: 15,
          //         ),
          //         child: Text(
          //           Get.find<NotificationController>().items.length.toString(),
          //           style: const TextStyle(
          //             color: Colors.white,
          //             fontSize: 10,
          //           ),
          //           textAlign: TextAlign.center,
          //         ),
          //       ),
          //     )
          //   ],
          // ),

          Expanded(
            child: InkWell(
              onTap: () {
                // Get.toNamed(Routes.userProfilePage);
                //Get.find<UserAccountController>()
                //    .itemPageOpen(Get.find<DataController>().currentUser, Routes.userProfilePage, needRefreshSelectedItem: true);
                Get.find<UserAccountController>().itemPageOpen(Get.find<DataController>().currentUser, Routes.profileViewPage, needRefreshSelectedItem: true);
              },
              child: Column(
                children: [
                  ClipOval(
                    child: Get.find<DataController>().currentUser.photoFile.isEmpty
                        ? Container(
                            decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                            width: 25,
                            height: 25,
                            child: Icon(
                              Icons.account_circle,
                              size: 20,
                              color: ControlOptions.instance.colorMain.withOpacity(0.4),
                            ),
                          )
                        : Image.memory(
                            Uint8List.fromList(Get.find<DataController>().currentUser.photoFile),
                            fit: BoxFit.cover,
                            width: 25,
                            height: 25,
                          ),
                  ),
                  Text('Аккаунт', style: TextStyle(color: ControlOptions.instance.colorMain,fontSize: 10))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
