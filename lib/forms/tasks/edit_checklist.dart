import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/generated/task_doc_check_list_table.g.dart';

import '../periodic_tasks/periodic_tasks_controller.dart';

class EditChecklistPage extends StatefulWidget {
  const EditChecklistPage({Key? key}) : super(key: key);
  @override
  State<EditChecklistPage> createState() => _EditChecklistPageState();
}

class _EditChecklistPageState extends State<EditChecklistPage> {
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

                    await taskcontroller.itemPagePost();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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
    for (var checkList in controller.items) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: Column(
          children: [
            Card(
              // elevation: 3,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          showAlertDialog(context, checkList);
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                        )),

                    Expanded(child: NsgInput(maxLines: 5, dataItem: checkList, fieldName: TaskDocCheckListTableGenerated.nameText)),

                    //  const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
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
