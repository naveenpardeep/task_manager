import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_controller.dart';
import 'package:task_manager_app/model/generated/user_notification_settings.g.dart';

class UserNotifictionNewTaskPage extends GetView<UserNotificationController> {
  const UserNotifictionNewTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    double width = MediaQuery.of(context).size.width;
    return controller.obx(
      (state) => BodyWrap(
          child: SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   // ignore: prefer_const_constructors
            //   title: Center(
            //     child: const Text(
            //       'Уведомления',
            //       style: TextStyle(color: Colors.black),
            //     ),
            //   ),
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: InkWell(
            //           onTap: () {
            //             controller.itemPagePost();
            //           },
            //           child: const Icon(Icons.check)),
            //     ),
            //   ],
            //   leading: InkWell(
            //       onTap: () {
            //         Get.back();
            //       },
            //       child: const Icon(Icons.arrow_back_ios)),
            //   backgroundColor: Colors.white,
            //   //  toolbarHeight: 200, // Set this height
            // ),
            body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                NsgAppBar(
                  backColor: Colors.white,
                  color: Colors.black,
                  text: 'Уведомления'.toUpperCase(),
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () {
                    controller.itemPagePost();
                  },
                ),
                SizedBox(
                  width: width,
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              Get.find<ProjectController>().currentItem.name,
                              textScaleFactor: 2,
                            ),
                          ),
                        ),
                        NsgInput(
                          dataItem: controller.currentItem,
                          fieldName: UserNotificationSettingsGenerated
                              .nameNotifyNewTasks,
                          label: 'Создана задача с моим участием',
                        ),
                        NsgInput(
                          dataItem: controller.currentItem,
                          fieldName: UserNotificationSettingsGenerated
                              .nameNotifyEditedTasks,
                          label: 'Все изменения в задачах с моим участием',
                        ),
                        NsgInput(
                          dataItem: controller.currentItem,
                          fieldName: UserNotificationSettingsGenerated
                              .nameNotifyNewTasksInProjects,
                          label: 'Новая задача в проекте',
                        ),
                        NsgInput(
                          dataItem: controller.currentItem,
                          fieldName: UserNotificationSettingsGenerated
                              .nameNotifyEditedTasksInProjects,
                          label: 'Все изменения в задачах проектов',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }
}
