import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';

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
                  color: Colors.black,
                  text: 'Пункт чек-листа'.toUpperCase(),
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
                            TTNsgInput(
                              maxLines: 20,
                              minLines: 5,
                              dataItem: controller.currentItem,
                              fieldName: TaskDocCheckListTableGenerated.nameText,
                              label: '',
                              infoString: '',
                            ),
                            // NsgInput(
                            //   dataItem: controller.currentItem,
                            //   fieldName:
                            //       TaskDocCheckListTableGenerated.nameIsDone,
                            //   label: 'Done',
                            // ),
                            if (controller.currentItem.text.isNotEmpty)
                              NsgButton(
                                backColor: Colors.transparent,
                                text: 'Удалить пункт',
                                color: Colors.red,
                                onPressed: () async {
                                  showAlertDialog(context);
                                },
                              )
                          ],
                        ),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                        child: TaskButton(
                      text: 'Отменить',
                      style: TaskButtonStyle.light,
                      onTap: () {
                        controller.itemPageCancel();
                      },
                    )),
                    Expanded(
                        child: TaskButton(
                      text: 'Сохранить',
                      onTap: () async {
                        await controller.itemPagePost();
                        await Get.find<TasksController>().itemPagePost();
                      },
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () async {
        Get.find<TasksController>().currentItem.checkList.removeRow(controller.currentItem);
        await Get.find<TasksController>().itemPagePost();

        Get.back();
        Get.back();
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
