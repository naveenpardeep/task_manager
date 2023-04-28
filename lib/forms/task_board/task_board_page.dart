import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';

class TaskBoardPage extends GetView<TaskBoardController> {
  const TaskBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  //  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
      child: Scaffold(
     //   key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
          //  key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  backColor: Colors.white,
                  color: Colors.black,
                  text: controller.currentItem.isEmpty ? 'Экран '.toUpperCase() : controller.currentItem.name.toUpperCase(),
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
                            TTNsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskBoardGenerated.nameName,
                              label: 'Название доски',
                              infoString: 'Название доски',
                            ),
                            NsgButton(
                              borderRadius: 30,
                              color: const Color(0xff529FBF),
                              backColor: const Color(0xffEDEFF3),
                              text: '+ добавляйте статусы на эту доску',
                              onPressed: () {
                                Get.find<TaskStatusTableController>().prepapreProjectStatus();
                                Get.find<TaskStatusTableController>().newItemPageOpen(pageName: Routes.taskBoardStatusPage);
                              },
                            ),
                            getBoardstatus(context),
                            if (controller.currentItem.name.isNotEmpty)
                              NsgButton(
                                backColor: Colors.transparent,
                                text: 'Удалить доску',
                                color: Colors.red,
                                onPressed: () async {
                                  showAlertDialogforboard(context);
                                },
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

  Widget getBoardstatus(BuildContext context) {
    List<Widget> list = [];
    double width = MediaQuery.of(context).size.width;

    for (var boardstatus in controller.currentItem.statusTable.rows) {
      list.add(wrapdragTarget(
        status: boardstatus,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Draggable(
                      data: boardstatus,
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
                                    boardstatus.status.name,
                                    style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SizedBox(
                                      width: 30,
                                      child: IconButton(
                                          onPressed: () {
                                            showAlertDialog(context, boardstatus);
                                          },
                                          icon: const Icon(Icons.close))),
                                ),
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
                      boardstatus.status.name,
                      style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                        width: 30,
                        child: IconButton(
                            onPressed: () {
                              showAlertDialog(context, boardstatus);
                            },
                            icon: const Icon(Icons.close))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    }
    return SingleChildScrollView(child: Column(children: list));
  }

  showAlertDialogforboard(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () async {
        await controller.deleteItems([controller.currentItem]);
        Get.back();
        controller.refreshData();
        // Navigator.of(context).pop();
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

  showAlertDialog(BuildContext context, boardstatus) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        controller.currentItem.statusTable.removeRow(boardstatus);
        controller.itemPagePost(goBack: false);

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

  Widget wrapdragTarget({required Widget child, required TaskBoardStatusTable status}) {
    return DragTarget<TaskBoardStatusTable>(
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
       // data = status;
        int newPosition = controller.currentItem.statusTable.rows.indexOf(status);
        moveRow(data, newPosition);
        //  await controller.postItems([status.status]);
        // data.status = status.status;
        // // Get.find<TaskBoardController>().currentItem.statusTable.addRow(status);
       // await controller.postItems([controller.currentItem]);
   controller.sendNotify();
        // controller.refreshData();
      },
    );
  }

  void moveRow(TaskBoardStatusTable row, int newPosition) {
    var oldPostition=controller.currentItem.statusTable.rows.indexOf(row);
    if(oldPostition<newPosition){
      oldPostition++;
    }
   
    
    controller.currentItem.statusTable.rows.remove(row);

    controller.currentItem.statusTable.rows.insert(newPosition, row);
  }
}
