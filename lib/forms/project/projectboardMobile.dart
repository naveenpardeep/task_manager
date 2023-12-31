// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/business_process/business_process_controller.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task%20type/task_type_controller.dart';

import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/user_role/user_role_controller.dart';
import 'package:task_manager_app/model/generated/business_process.g.dart';
import 'package:task_manager_app/model/generated/user_role.g.dart';

import 'package:task_manager_app/model/task_board.dart';

import '../../model/generated/task_status.g.dart';
import '../../model/generated/task_type.g.dart';
import '../task_status/project_status_controller.dart';

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
    var scrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        //  key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //    key: GlobalKey(),
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
                        thickness: width > 700 ? 10 : 0,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              if (controller.currentItem.name.isEmpty)
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
                                getProjectBoard(context),
                                if (controller.currentItem.name.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: NsgTable(
                                    showIconFalse: false,
                                    controller: Get.find<UserRoleController>(),
                                    elementEditPageName: Routes.userRolePage,
                                    availableButtons: const [
                                      NsgTableMenuButtonType.createNewElement,
                                      NsgTableMenuButtonType.editElement,
                                      NsgTableMenuButtonType.removeElement
                                    ],
                                    columns: [
                                      NsgTableColumn(name: UserRoleGenerated.nameName,
                                       expanded: true, presentation: 'User Role'),
                                    ],
                                  ),
                                ),
                                 if (controller.currentItem.name.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: NsgTable(
                                    showIconFalse: false,
                                    controller: Get.find<BusinessProcessController>(),
                                    elementEditPageName: Routes.businessProcessPage,
                                    availableButtons: const [
                                      NsgTableMenuButtonType.createNewElement,
                                      NsgTableMenuButtonType.editElement,
                                      NsgTableMenuButtonType.removeElement
                                    ],
                                    columns: [
                                      NsgTableColumn(name: BusinessProcessGenerated.nameName,
                                       expanded: true, presentation: 'Business Process'),
                                    ],
                                  ),
                                ),
                              if (controller.currentItem.name.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: NsgTable(
                                    showIconFalse: false,
                                    controller: Get.find<ProjectStatusController>(),
                                    elementEditPageName: Routes.taskStatusPage,
                                    availableButtons: const [
                                      NsgTableMenuButtonType.createNewElement,
                                      NsgTableMenuButtonType.editElement,
                                      NsgTableMenuButtonType.removeElement
                                    ],
                                    columns: [
                                      NsgTableColumn(name: TaskStatusGenerated.nameName, expanded: true, presentation: 'Статусы'),
                                      NsgTableColumn(name: TaskStatusGenerated.nameIsDone, width: 100, presentation: 'Финальный'),
                                    ],
                                  ),
                                ),
                              if (controller.currentItem.name.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: NsgTable(
                                    showIconFalse: false,
                                    controller: Get.find<TaskTypeController>(),
                                    elementEditPageName: Routes.taskTypePage,
                                    availableButtons: const [
                                      NsgTableMenuButtonType.createNewElement,
                                      NsgTableMenuButtonType.editElement,
                                      NsgTableMenuButtonType.removeElement
                                    ],
                                    columns: [
                                      NsgTableColumn(name: TaskTypeGenerated.nameName,
                                       expanded: true, presentation: 'Тип задачи'),
                                    ],
                                  ),
                                ),
                                
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: const Color(0xffEDEFF3),
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskboard.name,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold),
                        ),
                        getTaskBoardStatus(taskboard)
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

  Widget getTaskBoardStatus(TaskBoard taskBoard) {
    List<Widget> list = [];

    for (var taskboardstatus in taskBoard.statusTable.rows) {
      {
        list.add(GestureDetector(
          onTap: () {
            Get.find<TaskBoardController>().currentItem = taskBoard;
            Get.toNamed(Routes.taskBoard);
          },
          child: Text(taskboardstatus.status.name,
              style: TextStyle(
                color: taskboardstatus.status.isDone ? Colors.green : Colors.black,
              )),
        ));
      }
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list,
          ),
        ));
  }
}
