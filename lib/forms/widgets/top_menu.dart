import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
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
                        Get.toNamed(Routes.projectListPage);
                      },
                      child: Text(
                        'Проекты',
                        style: TextStyle(
                            color: ControlOptions.instance.colorMainText,
                            fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.tasksListPage);
                      },
                      child: Text(
                        'Задачи',
                        style: TextStyle(
                            color: ControlOptions.instance.colorMainText,
                            fontSize: ControlOptions.instance.sizeXL),
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
                        style: TextStyle(
                            color: ControlOptions.instance.colorMainText,
                            fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () async {
                        await Get.find<DataController>().provider!.logout();
                        await Get.find<DataController>().onInit();
                      },
                      child: Text(
                        'logout',
                        style: TextStyle(
                            color: ControlOptions.instance.colorMainText,
                            fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.invitationPage);
                      },
                      child: Icon(
                        Icons.insert_invitation_sharp,
                        color: ControlOptions.instance.colorMainText,
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
                          child: Text(
                            Get.find<NotificationController>()
                                .items
                                .length
                                .toString(),
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
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2, color: ControlOptions.instance.colorMainText)),
            child: InkWell(
              onTap: () {
                Get.find<UserAccountController>().itemPageOpen(
                    Get.find<UserAccountController>().currentItem,
                    Routes.userProfilePage);
              },
              child: ClipOval(
                child: Image.network(
                    width: 32,
                    height: 32,
                    'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
