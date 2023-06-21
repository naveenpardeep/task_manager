// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_tasks_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/task_doc_check_list_table.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key}) : super(key: key);
  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  var controller = Get.find<TasksController>().isPeriodicController ? Get.find<PeriodicTaskCheckListController>() : Get.find<TaskCheckListController>();
  var taskcontroller = Get.find<TasksController>().isPeriodicController ? Get.find<PeriodicTasksController>() : Get.find<TasksController>();

  @override
  void initState() {
    super.initState();
    if (controller.lateInit) {
      controller.requestItems();
    }
    if (taskcontroller.lateInit) {
      taskcontroller.requestItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    double width = MediaQuery.of(context).size.width;

    for (var checkList in controller.items) {
      list.add(wrapdragTarget(
        checkList: checkList,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: InkWell(
            onTap: () {
              controller.currentItem = checkList;
              Get.toNamed(Routes.taskChecklistPage);
            },
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Draggable(
                        data: checkList,
                        childWhenDragging: SizedBox(width: 30, child: IconButton(onPressed: () {}, icon: const Icon(Icons.drag_indicator))),
                        feedback: SizedBox(
                          height: 60,
                          width: width,
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(width: 30, child: IconButton(onPressed: () {}, icon: const Icon(Icons.drag_indicator))),
                                  ),
                                  Expanded(
                                    child: Text(
                                      checkList.text,
                                      style: TextStyle(
                                        color: checkList.isDone == true ? const Color(0xff529FBF) : ControlOptions.instance.colorMainDark,
                                        fontSize: ControlOptions.instance.sizeL,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 30,
                                      child: NsgCheckBox(
                                          toggleInside: true, key: GlobalKey(), label: '', value: checkList.isDone, onPressed: (currentValue) async {})),
                                ],
                              ),
                            ),
                          ),
                        ),
                        child: SizedBox(width: 30, child: IconButton(onPressed: () {}, icon: const Icon(Icons.drag_indicator))),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        checkList.text,
                        style: TextStyle(
                          color: checkList.isDone == true ? const Color(0xff529FBF) : ControlOptions.instance.colorMainDark,
                          fontSize: ControlOptions.instance.sizeL,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 30,
                        child: NsgCheckBox(
                            toggleInside: true,
                            key: GlobalKey(),
                            label: '',
                            value: checkList.isDone,
                            onPressed: (currentValue) async {
                              checkList.isDone = currentValue;

                              await taskcontroller.postItems([taskcontroller.currentItem]);
                              controller.refreshData();

                              taskcontroller.refreshData();
                            })),
                  ],
                ),
              ),
            ),
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
        controller.currentItem = checkList;
        taskcontroller.currentItem.checkList.removeRow(controller.currentItem);
        taskcontroller.itemPagePost();

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

  Widget wrapdragTarget({required Widget child, required TaskDocCheckListTable checkList}) {
    return DragTarget<TaskDocCheckListTable>(
      builder: (context, accepted, rejected) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: accepted.isNotEmpty ? ControlOptions.instance.colorMain.withOpacity(0.4) : Colors.transparent,
            ),
            child: child);
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) async {
        int newPosition = taskcontroller.currentItem.checkList.rows.indexOf(checkList);
        moveRow(data, newPosition);
        if (data != checkList) {
          taskcontroller.sendNotify();
          controller.refreshData();
        }
      },
    );
  }

  void moveRow(TaskDocCheckListTable row, int newPosition) {
    var oldPostition = taskcontroller.currentItem.checkList.rows.indexOf(row);
    if (oldPostition < newPosition) {
      oldPostition++;
    }

    taskcontroller.currentItem.checkList.rows.remove(row);

    taskcontroller.currentItem.checkList.rows.insert(newPosition, row);
  }
}
