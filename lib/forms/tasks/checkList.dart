// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class ChecklistPage extends GetView<TaskCheckListController> {
  const ChecklistPage({Key? key}) : super(key: key);

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
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            checkList(context),
                            NsgButton(
                              text: 'Создать контрольный список',
                              onPressed: () {
                                Get.find<TaskCheckListController>().newItemPageOpen(pageName: Routes.taskChecklistPage);
                              },
                            )
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
    var controller = Get.find<TaskCheckListController>();
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
                              label: '',
                              value: controller.currentItem.isDone,
                              onPressed: (currentValue) {
                                if (currentValue == false) {
                                  controller.currentItem.isDone == true;
                                } else {
                                  controller.currentItem.isDone == false;
                                }

                                controller.refreshData();
                              })),

                      // SizedBox(
                      //   width: 90,
                      //   child: NsgInput(
                      //     dataItem: controller.currentItem,
                      //     fieldName: TaskDocCheckListTableGenerated.nameIsDone,
                      //   ),
                      // ),

                      Expanded(
                        child: Text(
                          checkList.text,
                          style: TextStyle(
                            color: ControlOptions.instance.colorMainDark,
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
                            color: Colors.red,
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
      onPressed: () async {
        Get.find<TaskCheckListController>().currentItem = checkList;
        await Get.find<TasksController>().deleteItems([Get.find<TaskCheckListController>().currentItem]);
        Get.find<TaskCheckListController>().sendNotify();
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
