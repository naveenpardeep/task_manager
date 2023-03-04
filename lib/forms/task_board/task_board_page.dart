import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';

class TaskBoardPage extends GetView<TaskBoardController> {
 const  TaskBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            key: GlobalKey(),
            decoration:  BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  backColor: Colors.white,
                  color: Colors.black,
                  text: controller.currentItem.isEmpty
                      ? 'Экран '.toUpperCase()
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
                      padding:  EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TTNsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskBoardGenerated.nameName,
                              label: 'Название доски',
                              infoString: 'Название доски',
                            ),
                            //  NsgInput(
                            //   selectionController:
                            //       Get.find<ProjectStatusController>(),
                            //   controller: Get.find<TaskStatusTableController>(),
                            //   dataItem:  controller.currentItem.statusTable.rows.insert(1)
                            //   ,
                            //   fieldName:
                            //       TaskBoardStatusTableGenerated.nameStatusId,
                            //   label: 'Status ',
                            // ),
                            //  TTNsgInput(
                            //   selectionController:
                            //       Get.find<ProjectStatusController>(),
                            //   controller: Get.find<TaskStatusTableController>(),
                            //   dataItem:  controller.currentItem.statusTable.rows[1],
                            //   fieldName:
                            //       TaskBoardStatusTableGenerated.nameStatusId,
                            //   label: 'Status ',
                            // ),
                            //  TTNsgInput(
                            //   selectionController:
                            //       Get.find<ProjectStatusController>(),
                            //   controller: Get.find<TaskStatusTableController>(),
                            //   dataItem:  controller.currentItem.statusTable.rows[2],
                            //   fieldName:
                            //       TaskBoardStatusTableGenerated.nameStatusId,
                            //   label: 'Status ',
                            // ),
                            //  TTNsgInput(
                            //   selectionController:
                            //       Get.find<ProjectStatusController>(),
                            //   controller: Get.find<TaskStatusTableController>(),
                            //   dataItem:  controller.currentItem.statusTable.rows[3],
                            //   fieldName:
                            //       TaskBoardStatusTableGenerated.nameStatusId,
                            //   label: 'Status ',
                            // ),
                            //  TTNsgInput(
                            //   selectionController:
                            //       Get.find<ProjectStatusController>(),
                            //   controller: Get.find<TaskStatusTableController>(),
                            //   dataItem:  controller.currentItem.statusTable.rows[4],
                            //   fieldName:
                            //       TaskBoardStatusTableGenerated.nameStatusId,
                            //   label: 'Status ',
                            // ),
                           
                            NsgTable(
                              controller: Get.find<TaskStatusTableController>(),
                              elementEditPageName: Routes.taskrow,
                              availableButtons: const [
                                NsgTableMenuButtonType.createNewElement,
                                NsgTableMenuButtonType.editElement,
                                NsgTableMenuButtonType.removeElement
                              ],
                              columns: [
                                NsgTableColumn(
                                    name: TaskBoardStatusTableGenerated.nameStatusId,
                                    expanded: true,
                                    presentation: 'Статусы'),
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

void moveRow(TaskBoardStatusTable row, int newPosition) {
   controller.currentItem.statusTable.rows.remove(row);

    controller.currentItem.statusTable.rows.insert(newPosition, row);
  }
}