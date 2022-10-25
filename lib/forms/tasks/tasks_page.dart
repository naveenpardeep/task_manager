import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';
import '../project/project_controller.dart';

class TasksPage extends GetView<TasksController> {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
      child: Scaffold(
        key: _scaffoldKey,
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
                      ? 'Новая задача'.toUpperCase()
                      : controller.currentItem.date.toString().toUpperCase(),
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
                              fieldName: TaskDocGenerated.nameText,
                              label: 'Заголовок',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameDescription,
                              label: 'Описание',
                            ),
                            NsgInput(
                                selectionController:
                                    Get.find<ProjectController>(),
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.nameProjectId,
                                label: 'Проект',
                                selectionForm: Routes.projectListPage),
                            NsgTable(
                              controller:
                                  Get.find<CommentTableTasksController>(),
                              columns: [
                                NsgTableColumn(
                                    name:
                                        TaskDocCommentsTableGenerated.nameText,
                                    expanded: true,
                                    presentation: 'Комментарий')
                              ],
                              elementEditPageName: Routes.commentRowPage,
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
