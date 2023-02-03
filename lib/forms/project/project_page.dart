import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../task_status/task_status_controller.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);
  @override
  State<ProjectPage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectPage> {
  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    // scaffoldKey;
    isHidden;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // var todaydate = controller.currentItem.date;

    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    // String formatted = formateddate.format(controller.currentItem.date);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //   key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  color: Colors.white,
                  text: controller.currentItem.name.isEmpty
                      ? 'Новый проект'.toUpperCase()
                      : controller.currentItem.name.toUpperCase(),
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () {
                    if (controller.currentItem.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Пожалуйста, введите название проекта ')));
                    } else {
                      controller.itemPagePost();
                    }
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NsgText(
                                'Создано :${formateddate.format(controller.currentItem.date)}'),
                           const Align(
                            alignment: Alignment.centerLeft,
                            child: NsgText('Добавление пользователей в проект')),
                            // NsgTable(
                            //   showIconFalse: false,
                            //   controller:
                            //       Get.find<ProjectItemUserTableController>(),
                            //   elementEditPageName: Routes.projectuserRowpage,
                            //   availableButtons: const [
                            //     NsgTableMenuButtonType.createNewElement,
                            //     NsgTableMenuButtonType.editElement,
                            //     NsgTableMenuButtonType.removeElement
                            //   ],
                            //   columns: [
                            //     NsgTableColumn(
                            //         name: ProjectItemUserTableGenerated
                            //             .nameUserAccountId,
                            //         expanded: true,
                            //         presentation: 'User'),
                            //     NsgTableColumn(
                            //         name: ProjectItemUserTableGenerated
                            //             .nameIsAdmin,
                            //         width: 100,
                            //         presentation: 'Admin'),
                            //   ],
                            // ),
                            NsgButton(text: ' добавить пользователей в проект',onPressed: () {
                              Get.find<UserAccountController>().currentItem.inviteProject=controller.currentItem;
                              Get.find<UserAccountController>().itemNewPageOpen(Routes.createInvitationUser);
                            },),
                            NsgInput(
                              selectionController:
                                  Get.find<OrganizationController>(),
                              dataItem: controller.currentItem,
                              fieldName:
                                  ProjectItemGenerated.nameOrganizationId,
                              label: 'Select Organization',
                            ),
                            NsgInput(
                              selectionController:
                                  Get.find<UserAccountController>(),
                              dataItem: controller.currentItem,
                              fieldName: ProjectItemGenerated.nameLeaderId,
                              label: 'Руководитель проекта',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: ProjectItemGenerated.nameProjectPrefix,
                              label: 'Project Prefix',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: ProjectItemGenerated.nameName,
                              label: 'Наименование',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: ProjectItemGenerated.nameContractor,
                              label: 'Заказчик',
                            ),
                             const Align(
                            alignment: Alignment.centerLeft,
                            child: NsgText('Добавление Статусы проекта')),
                            SizedBox(
                              height: height * 0.3,
                              child: SingleChildScrollView(
                                  child: NsgTable(
                                showIconFalse: false,
                                controller: Get.find<TaskStatusController>(),
                                elementEditPageName: Routes.taskStatusPage,
                                availableButtons: const [
                                  NsgTableMenuButtonType.createNewElement,
                                  NsgTableMenuButtonType.editElement,
                                  NsgTableMenuButtonType.removeElement
                                ],
                                columns: [
                                  NsgTableColumn(
                                      name: TaskStatusGenerated.nameName,
                                      expanded: true,
                                      presentation: 'Статусы'),
                                  NsgTableColumn(
                                      name: TaskStatusGenerated.nameIsDone,
                                      width: 100,
                                      presentation: 'Финальный'),
                                ],
                              )),
                            ),
                            if (isHidden == true &&
                                controller.currentItem.name.isEmpty)
                              NsgButton(
                                text: 'Сохранить и далее',
                                color: Colors.white,
                                onPressed: () {
                                  if (controller.currentItem.name.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Пожалуйста, введите название проекта ')));
                                  } else {
                                    setState(() {
                                      isHidden = false;
                                      controller.itemPagePost(goBack: false);
                                    });
                                  }
                                },
                              ),
                            if (controller.currentItem.name.isNotEmpty)
                              NsgTable(
                                controller: Get.find<TaskBoardController>(),
                                elementEditPageName: Routes.taskBoard,
                                availableButtons: const [
                                  NsgTableMenuButtonType.createNewElement,
                                  NsgTableMenuButtonType.editElement,
                                  NsgTableMenuButtonType.removeElement
                                ],
                                columns: [
                                  NsgTableColumn(
                                      name: TaskBoardGenerated.nameName,
                                      expanded: true,
                                      presentation: 'Название доски'),
                                ],
                              )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
