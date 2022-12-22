import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_list.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectPage extends GetView<ProjectController> {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todaydate = controller.currentItem.date;

    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    String formatted = formateddate.format(todaydate);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  text: controller.currentItem.isEmpty
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
                    controller.itemPagePost();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NsgText('Создано :$formatted'),
                            NsgInput(
                              selectionController:
                                  Get.find<UserAccountController>(),
                              dataItem: controller.currentItem,
                              fieldName: ProjectItemGenerated.nameLeaderId,
                              label: 'Руководитель проекта',
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
                            NsgTable(
                              controller: Get.find<TaskBoardController>(),
                              elementEditPageName: Routes.taskBoard,
                              availableButtons: [
                                NsgTableMenuButtonType.createNewElement,
                                NsgTableMenuButtonType.editElement
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
