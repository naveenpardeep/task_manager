import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class TaskChecklistPage extends GetView<TaskCheckListController> {
  const TaskChecklistPage({Key? key}) : super(key: key);

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
                  text: 'Task CheckList '.toUpperCase(),
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () async {
                    await controller.itemPagePost();
                    await Get.find<TasksController>().itemPagePost();
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
                                fieldName:
                                    TaskDocCheckListTableGenerated.nameText,
                                label: 'Task CheckList Name'),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName:
                                  TaskDocCheckListTableGenerated.nameIsDone,
                              label: 'Done',
                            ),
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
