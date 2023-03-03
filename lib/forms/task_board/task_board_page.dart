import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';

class TaskBoardPage extends GetView<TaskBoardController> {
  const TaskBoardPage({Key? key}) : super(key: key);

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
            decoration: const BoxDecoration(color: Colors.white),
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
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskBoardGenerated.nameName,
                              label: 'Название экрана',
                            ),
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
}
