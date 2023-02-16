

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
                          
                              NsgTable(
                                controller: Get.find<TaskCheckListController>(),
                                elementEditPageName: Routes.taskChecklistPage,
                                availableButtons: const [
                                  NsgTableMenuButtonType.createNewElement,
                                  NsgTableMenuButtonType.editElement,
                                  NsgTableMenuButtonType.removeElement
                                ],
                                columns: [
                                  NsgTableColumn(
                                      name: TaskDocCheckListTableGenerated
                                          .nameText,
                                      expanded: true,
                                      presentation: 'CheckList Name'),
                                  NsgTableColumn(
                                      name: TaskDocCheckListTableGenerated
                                          .nameIsDone,
                                      width: 100,
                                      presentation: 'Done'),
                                ],

                                
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


  Widget checkList( BuildContext context) {
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
          onLongPress: () {
            
          },
          child: Row(
            children: [
              Expanded(
                child: Card(
                  // elevation: 3,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              // controller.currentItem = project;
                              // await controller
                              //     .deleteItems([controller.currentItem]);
                              // controller.sendNotify();
                              showAlertDialog(context,checkList);
                            },
                            icon: const Icon(Icons.delete)),
                        Expanded(
                          child: Text(
                            checkList.text,
                            style: TextStyle(
                              color: ControlOptions.instance.colorMainDark,
                              fontSize: ControlOptions.instance.sizeL,
                            ),
                          ),
                        ),
                         NsgInput(
                              dataItem: controller.currentItem,
                              fieldName:
                                  TaskDocCheckListTableGenerated.nameIsDone,
                              label: 'Done',
                            ),
                      //  const Icon(Icons.arrow_forward_ios),
                       
                      ],
                    ),
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

  showAlertDialog(BuildContext context, checkList ) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () async {
        Get.find<TaskCheckListController>().currentItem = checkList;
        await Get.find<TaskCheckListController>()
            .deleteItems([Get.find<TaskCheckListController>().currentItem]);
        Get.find<TaskCheckListController>().sendNotify();
        Navigator.of( context).pop();
        
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
