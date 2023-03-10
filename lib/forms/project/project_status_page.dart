import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectStatusPage extends StatefulWidget {
  const ProjectStatusPage({Key? key}) : super(key: key);
  @override
  State<ProjectStatusPage> createState() => _ProjectStatuspageState();
}

class _ProjectStatuspageState extends State<ProjectStatusPage> {
  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    // scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;

    // DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    var isNewProject = controller.currentItem.name.isEmpty;
    var scrollController = ScrollController();
    var newscrollController = ScrollController();

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
                              if (isHidden == true && controller.currentItem.name.isEmpty)
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
                              if (!isNewProject) const Align(alignment: Alignment.centerLeft, child: NsgText('Добавление Статусы проекта')),
                              if (!isNewProject)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: SizedBox(
                                    child: RawScrollbar(
                                      thumbVisibility: true,
                                      trackVisibility: true,
                                      controller: newscrollController,
                                      thickness: 8,
                                      trackBorderColor: ControlOptions.instance.colorGreyLight,
                                      trackColor: ControlOptions.instance.colorGreyLight,
                                      thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                                      radius: const Radius.circular(0),
                                      child: SingleChildScrollView(
                                          physics: const BouncingScrollPhysics(),
                                          controller: newscrollController,
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
                                          )),
                                    ),
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
}
