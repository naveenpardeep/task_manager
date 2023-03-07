import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';

import 'package:task_manager_app/forms/task_status/task_status_controller.dart';

class TaskBoardStatusPage extends GetView<TaskStatusTableController> {
  const TaskBoardStatusPage({Key? key}) : super(key: key);

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
                  color: Colors.black,
                  backColor: Colors.white,
                  text: 'Status',
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    Get.back();
                  //  controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () {
                    controller.statusSaved(); 
                    Get.back();
                    Get.find<TaskBoardController>().sendNotify();

               
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                           
                            Get.find<ProjectStatusController>().obx(
                              (state) => getProjectstatus(context),
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

  Widget getProjectstatus(BuildContext context) {
    List<Widget> list = [];
    var projectstatusitem =  controller.taskboardstatus;
    for (var projectstatus in projectstatusitem) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: Card(
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
                        value: projectstatus.isChecked,
                        onPressed: (currentValue)  {
                          projectstatus.isChecked=currentValue;
                        //  Get.find<TaskBoardController>().currentItem.statusTable.addRow();
                        })),
                Text(
                  projectstatus.status.name,
                  style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return SingleChildScrollView(child: Column(children: list));
  }
}
