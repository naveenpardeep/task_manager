import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

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
    var newscrollController = ScrollController();

    // String formatted = formateddate.format(controller.currentItem.date);

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
                              if (isHidden && controller.currentItem.name.isEmpty)
                                NsgButton(
                                  text: 'Сохранить и далее',
                                  color: Colors.white,
                                  onPressed: () {
                                    if (controller.currentItem.name.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите название проекта ')));
                                    } else {
                                      setState(() {
                                        isHidden = false;
                                        controller.itemPagePost(goBack: false);
                                      });
                                    }
                                  },
                                ),
                              if (controller.currentItem.name.isNotEmpty)
                                const Align(alignment: Alignment.centerLeft, child: NsgText('Создать экран для этого проекта')),
                              if (controller.currentItem.name.isNotEmpty)
                                NsgTable(
                                  controller: Get.find<TaskBoardController>(),
                                  elementEditPageName: Routes.taskBoard,
                                  availableButtons: const [
                                    NsgTableMenuButtonType.createNewElement,
                                    NsgTableMenuButtonType.editElement,
                                    NsgTableMenuButtonType.removeElement
                                  ],
                                  columns: [
                                    NsgTableColumn(name: TaskBoardGenerated.nameName, expanded: true, presentation: 'Название доски'),
                                  ],
                                ),
                              // if (!isNewProject) const Align(alignment: Alignment.centerLeft, child: NsgText('Добавление Статусы проекта')),
                              // if (!isNewProject)
                              //   Padding(
                              //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              //     child: SizedBox(
                              //       height: height * 0.6,
                              //       child: RawScrollbar(
                              //         thumbVisibility: true,
                              //         trackVisibility: true,
                              //         controller: newscrollController,
                              //         thickness: 8,
                              //         trackBorderColor: ControlOptions.instance.colorGreyLight,
                              //         trackColor: ControlOptions.instance.colorGreyLight,
                              //         thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                              //         radius: const Radius.circular(0),
                              //         child: SingleChildScrollView(
                              //             physics: const BouncingScrollPhysics(),
                              //             controller: newscrollController,
                              //             child: NsgTable(
                              //               showIconFalse: false,
                              //               controller: Get.find<ProjectStatusController>(),
                              //               elementEditPageName: Routes.taskStatusPage,
                              //               availableButtons: const [
                              //                 NsgTableMenuButtonType.createNewElement,
                              //                 NsgTableMenuButtonType.editElement,
                              //                 NsgTableMenuButtonType.removeElement
                              //               ],
                              //               columns: [
                              //                 NsgTableColumn(name: TaskStatusGenerated.nameName, expanded: true, presentation: 'Статусы'),
                              //                 NsgTableColumn(name: TaskStatusGenerated.nameIsDone, width: 100, presentation: 'Финальный'),
                              //               ],
                              //             )),
                              //       ),
                              //     ),
                              //   ),
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
}
