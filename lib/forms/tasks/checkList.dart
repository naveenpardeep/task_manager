// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data_item.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

class ChecklistPage extends GetView<TaskCheckListController> {
  const ChecklistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    var controller = Get.find<TaskCheckListController>();
    double totalChecklist = controller.items.length.toDouble();
    double isDone = controller.items.where((element) => element.isDone == true).length.toDouble();

    late double donePercent;
    if (isDone != 0) {
      donePercent = (isDone / totalChecklist);
    } else {
      donePercent = 0.0;
    }

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
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (controller.items.isNotEmpty)
                              LinearPercentIndicator(
                                key: GlobalKey(),
                                center: Text(
                                  ('${(donePercent * 100).toStringAsFixed(2)}%'),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                lineHeight: 20,
                                percent: donePercent,
                                backgroundColor: Colors.grey,
                                progressColor: Colors.green,
                              ),
                            checkList(context),
                            NsgButton(
                              text: 'Создать Чек-лист',
                              onPressed: () {
                                Get.find<TaskCheckListController>().newItemPageOpen(pageName: Routes.taskChecklistPage);
                              },
                            ),
                            //  NsgButton(
                            //   text: 'Edit Чек-лист',
                            //   onPressed: () {
                            //      Get.find<TaskCheckListController>().itemPageOpen(controller.currentItem, Routes.editChecklistPage);
                            //       },
                            // )
                            // NsgTable(
                            //   controller: G,
                            //   elementEditPageName: Routes.taskChecklistPage,
                            //   availableButtons: const [
                            //     NsgTableMenuButtonType.createNewElement,
                            //     NsgTableMenuButtonType.editElement,
                            //     NsgTableMenuButtonType.removeElement
                            //   ],
                            //   columns: [
                            //     NsgTableColumn(name: TaskDocCheckListTableGenerated.nameText, expanded: true, presentation: 'CheckList Name'),
                            //     NsgTableColumn(name: TaskDocCheckListTableGenerated.nameIsDone, width: 100, presentation: 'Done'),
                            //   ],
                            // ),
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

  Widget checkList(BuildContext context) {
    List<Widget> list = [];
    for (var checkList in controller.items) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
             controller.currentItem = checkList;
             Get.toNamed(Routes.taskChecklistPage);
          },
          onLongPress: () {},
          child: Column(
            children: [
              Card(
                // elevation: 3,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 30,
                          child: NsgCheckBox(
                              toggleInside: true,
                              key: GlobalKey(),
                              label: '',
                              value: checkList.isDone,
                              onPressed: (currentValue) async {
                                checkList.isDone = currentValue;

                                await Get.find<TasksController>().postItems([Get.find<TasksController>().currentItem]);
                                controller.sendNotify();

                                Get.find<TasksController>().sendNotify();
                              })),

                      Expanded(
                        child: Text(
                          checkList.text,
                          style: TextStyle(
                            color: checkList.isDone==true? const Color(0xff529FBF): ControlOptions.instance.colorMainDark,
                            fontSize: ControlOptions.instance.sizeL,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showAlertDialog(context, checkList);
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.black,
                          )),
                     //  const Icon(Icons.arrow_forward_ios),
                    ],
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

  showAlertDialog(BuildContext context, checkList) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        Get.find<TaskCheckListController>().currentItem = checkList;
        Get.find<TasksController>().currentItem.checkList.removeRow(controller.currentItem);
        Get.find<TasksController>().itemPagePost();

        Navigator.of(context).pop();
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
