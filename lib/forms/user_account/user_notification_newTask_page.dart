import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_newTask_controller.dart';
import 'package:task_manager_app/model/generated/user_notification_settings.g.dart';

class UserNotifictionNewTaskPage extends GetView<UserNotificationNewTaskController> {
  const UserNotifictionNewTaskPage({Key? key}) : super(key: key);


 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return controller.obx((state) => (BodyWrap(
          child: SafeArea(
            child: Scaffold(
               
                appBar: AppBar(
                  // ignore: prefer_const_constructors
                  title: Center(
                    child: const Text(
                      'Уведомления',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          controller.itemPagePost();
                        },
                        child: const Icon(Icons.check)),
                    ),
                  ],
                  leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                  backgroundColor: Colors.white,
                  //  toolbarHeight: 200, // Set this height
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          child: Card(
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                                  child: Text('Новая задача с моим участием',textScaleFactor: 2,),
                                ),
                                NsgInput(
                                  dataItem: controller
                                      .currentItem,
                                  fieldName: UserNotificationSettingsGenerated
                                      .nameNotifyNewTasks,
                                  label: 'Новая задача с моим участием',
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                                  child: Text(
                                      'Укажите интересующий проекты и статусы для отслеживания'),
                                ),
                                NsgInput(
                                    label: 'выберите проект',
                                    selectionController:
                                        Get.find<ProjectController>(),
                                    dataItem: controller
                                        .currentItem,
                                    fieldName: UserNotificationSettingsGenerated
                                        .nameProjectId),
                                // NsgInput(
                                //   label: 'Выберите статус',

                                //     dataItem: userNotificationNewTaskController
                                //         .currentItem,
                                //     fieldName: UserNotificationSettingsGenerated
                                //         .nameStatusTable),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        )));
  }

  selectStatus() {
    var form = NsgSelection(
      inputType: NsgInputType.multiselection,
      controller: Get.find<UserNotificationSettingStatusTableController>(),
    );
    form.selectFromArray(
      'Status',
      (item) {
        
      },
    );
  }
}
