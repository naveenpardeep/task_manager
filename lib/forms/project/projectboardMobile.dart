import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';

import 'package:task_manager_app/forms/task_status/task_status_controller.dart';

class ProjectBoardMobile extends StatefulWidget {
  const ProjectBoardMobile({Key? key}) : super(key: key);
  @override
  State<ProjectBoardMobile> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectBoardMobile> {
  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    // scaffoldKey;
    isHidden;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    // var todaydate = controller.currentItem.date;

    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    var isNewProject = controller.currentItem.name.isEmpty;
    var scrollController = ScrollController();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //   key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: scrollController,
                        thickness: 10,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              if ( controller.currentItem.name.isEmpty)
                                NsgButton(
                                  text: 'Сохранить и далее',
                                  color: Colors.white,
                                  onPressed: () {
                                    if (controller.currentItem.name.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите название проекта ')));
                                    } else {
                                      setState(() {
                                       
                                        controller.itemPagePost(goBack: false);
                                      });
                                    }
                                  },
                                ),
                              //   if (controller.currentItem.name.isNotEmpty)
                              //   const Align(alignment: Alignment.centerLeft, child: NsgText('Создать экран для этого проекта')),
                              if (controller.currentItem.name.isNotEmpty)
                                // NsgTable(
                                //   controller: Get.find<TaskBoardController>(),
                                //   elementEditPageName: Routes.taskBoard,
                                //   availableButtons: const [
                                //     NsgTableMenuButtonType.createNewElement,
                                //     NsgTableMenuButtonType.editElement,
                                //     NsgTableMenuButtonType.removeElement
                                //   ],
                                //   columns: [
                                //     NsgTableColumn(name: TaskBoardGenerated.nameName, expanded: true, presentation: 'Название доски'),
                                //   ],
                                // ),
                              Get.find<TaskBoardController>().obx((state) => getProjectBoard(context),)  
                            ],
                          ),
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

  Widget getProjectBoard(BuildContext context) {
    List<Widget> list = [];
    var taskBoardtable = Get.find<TaskBoardController>().items;

    for (var taskboard in taskBoardtable) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            Get.find<TaskBoardController>().currentItem = taskboard;
            Get.toNamed(Routes.taskBoard);
          },
          onLongPress: () {},
          child: Row(
            children: [
              Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          taskboard.name,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold),
                        ),
                     // getTaskBoardStatus(taskboard.name)
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

  Widget getTaskBoardStatus(taskBoard) {
    List<Widget> list = [];
     var taskboardstatusList = Get.find<TaskStatusTableController>().items;

    for (var taskboardstatus in taskboardstatusList) {
      // if (taskboardstatus.status!= taskBoard) continue;

      {
        list.add(GestureDetector(
          onTap: () {},
          child: Text(taskboardstatus.status.name),
        ));
      }
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: list,
          ),
        ));
  }
}
