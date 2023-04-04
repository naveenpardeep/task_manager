import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_icon_button.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';

import '../../app_pages.dart';
import '../../model/data_controller.dart';
import '../../model/generated/user_account.g.dart';
import '../../model/user_notification_settings.dart';
import '../widgets/tt_nsg_input.dart';
import 'user_account_controller.dart';
import 'user_notification_controller.dart';

class NotificationSettings extends GetView<UserAccountController> {
  const NotificationSettings({super.key});

  final EdgeInsets margin = const EdgeInsets.fromLTRB(0, 10, 0, 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.obx(
            (state) {
              return TaskButton(
                isEnabled: controller.isModified,
                style: TaskButtonStyle.light,
                text: 'Сохранить',
                onTap: () async {
                  NsgProgressDialog progress = NsgProgressDialog(textDialog: 'Сохранение...', canStopped: false);
                  try {
                    progress.show();
                    await controller.itemPagePost(goBack: false, useValidation: true);
                    //controller.saveBackup(controller.currentItem);
                  } finally {
                    progress.hide();
                  }
                },
              );
            },
          ),
          TTNsgInput(
            controller: controller,
            margin: margin,
            dataItem: controller.currentItem,
            fieldName: UserAccountGenerated.nameSettingNotifyByPush,
            label: 'Push-уведомления',
          ),

          TTNsgInput(
            controller: controller,
            margin: margin,
            dataItem: controller.currentItem,
            fieldName: UserAccountGenerated.nameSettingNotifyByEmail,
            label: 'Уведомления на почту',
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          TTNsgInput(
            controller: controller,
            margin: margin,
            dataItem: controller.currentItem,
            fieldName: UserAccountGenerated.nameSettingNotifyNewTasks,
            label: 'Новые задачи со мной',
            infoString: 'Уведомлять о новых задачах во всех проектах, где я указан исполнителем',
          ),

          TTNsgInput(
            controller: controller,
            margin: margin,
            dataItem: controller.currentItem,
            fieldName: UserAccountGenerated.nameSettingNotifyEditedTasks,
            label: 'Изменения в задачах со мной',
            infoString: 'Уведомлять об изменениях в задачах во всех проектах, где я указан исполнителем',
          ),

          TTNsgInput(
            controller: controller,
            margin: margin,
            dataItem: controller.currentItem,
            fieldName: UserAccountGenerated.nameSettingNotifyNewTasksInProjects,
            label: 'Новая задача в проекте',
            infoString: 'Уведомлять о новых задачах во всех проектах',
          ),

          TTNsgInput(
            controller: controller,
            margin: margin,
            dataItem: controller.currentItem,
            fieldName: UserAccountGenerated.nameSettingNotifyEditedTasksInProjects,
            label: 'Изменения во всех задачах',
            infoString: 'Уведомлять об изменениях в задачах во всех проектах',
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: NsgTable(
          //     controller: Get.find<UserNotificationController>(),
          //     elementEditPageName:
          //         Routes.userProjectListPage,
          //     availableButtons: const [NsgTableMenuButtonType.createNewElement],
          //     columns: [
          //       NsgTableColumn(
          //           name: UserNotificationSettingsGenerated.nameProjectId,
          //           expanded: true,
          //           presentation: 'Проекты'),
          //     ],
          //   ),
          // ),
          Get.find<UserNotificationController>().obx(
            (state) => (projectList(context)),
          ),

          Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Проекты-исключения',
                      style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontFamily: 'Inter'),
                    ),
                    NsgIconButton(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      size: 25,
                      color: ControlOptions.instance.colorMainLight,
                      icon: Icons.add,
                      onPressed: () {
                        Get.find<UserNotificationController>().newItemPageOpen(pageName: Routes.userProjectListPage);
                      },
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  'Добавьте проекты, для которых вы хотите настроить индивидуальные параметры уведомлений',
                  style: TextStyle(fontSize: ControlOptions.instance.sizeM, fontFamily: 'Inter'),
                )
              ])),

          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: SizedBox(
          //     width: width,
          //     height: 200,
          //     child: NsgListPage(
          //         appBar: const SizedBox(),
          //         appBarIcon: null,
          //         appBarIcon2: null,
          //         appBarBackColor:
          //             const Color(0xff7876D9),
          //         appBarColor: Colors.white,
          //         type: NsgListPageMode.table,
          //         controller: Get.find<
          //             UserNotificationController>(),
          //         title: '',
          //         textNoItems: '',
          //         elementEditPage:
          //             Routes.userProjectListPage,
          //         onElementTap: (element) {
          //           element as UserNotificationSettings;

          //           Get.find<UserNotificationController>()
          //               .currentItem = element;
          //           Get.toNamed(Routes
          //               .userNotificationNewTaskPage);
          //         },
          //         availableButtons: const [
          //           NsgTableMenuButtonType
          //               .createNewElement,
          //           NsgTableMenuButtonType.editElement,
          //           NsgTableMenuButtonType.removeElement
          //         ],
          //         columns: [
          //           NsgTableColumn(
          //               name:
          //                   UserNotificationSettingsGenerated
          //                       .nameProjectId,
          //               expanded: true,
          //               presentation: 'Название проекта'),
          //         ]),
          //   ),
          // ),
        ],
      )),
    );
  }

  Widget projectList(BuildContext context) {
    var controller = Get.find<UserNotificationController>();
    List<Widget> list = [];
    for (var project in controller.items) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            controller.currentItem = project;
            Get.toNamed(Routes.userNotificationNewTaskPage);
          },
          onLongPress: () {
            // controller.itemPageOpen(project, Routes.projectPage);
          },
          child: Row(
            children: [
              Expanded(
                child: Card(
                  // elevation: 3,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              // controller.currentItem = project;
                              // await controller
                              //     .deleteItems([controller.currentItem]);
                              // controller.sendNotify();
                              showAlertDialog(context, project);
                            },
                            icon: const Icon(Icons.delete)),
                        Expanded(
                          child: Text(
                            project.project.name,
                            style: TextStyle(
                              color: ControlOptions.instance.colorMainDark,
                              fontSize: ControlOptions.instance.sizeL,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return SingleChildScrollView(child: Column(children: list));
  }

  showAlertDialog(BuildContext context, UserNotificationSettings project) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        Get.find<UserNotificationController>().currentItem = project;
        Get.find<UserNotificationController>().deleteItems([Get.find<UserNotificationController>().currentItem]).then((value) {
          Get.find<UserNotificationController>().sendNotify();
          Navigator.of(context).pop();
        });
      },
    );
    Widget noButton = ElevatedButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to Delete?"),
      actions: [okButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
