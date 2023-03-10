import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectPageUsers extends StatefulWidget {
  const ProjectPageUsers({Key? key}) : super(key: key);
  @override
  State<ProjectPageUsers> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectPageUsers> {
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
    // double height = MediaQuery.of(context).size.height;

    // DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
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
                              if (!isNewProject) const Align(alignment: Alignment.centerLeft, child: NsgText('Добавление пользователей в проект')),
                              if (!isNewProject)
                                NsgTable(
                                  showIconFalse: false,
                                  controller: Get.find<ProjectItemUserTableController>(),
                                  elementEditPageName: Routes.projectuserRowpage,
                                  availableButtons: const [
                                    NsgTableMenuButtonType.createNewElement,
                                    NsgTableMenuButtonType.editElement,
                                    NsgTableMenuButtonType.removeElement
                                  ],
                                  columns: [
                                    NsgTableColumn(name: ProjectItemUserTableGenerated.nameUserAccountId, expanded: true, presentation: 'User'),
                                    NsgTableColumn(name: ProjectItemUserTableGenerated.nameIsAdmin, width: 100, presentation: 'Admin'),
                                  ],
                                ),
                              //  if (!isNewProject)
                              //     Align(
                              //         alignment: Alignment.centerLeft,
                              //         child: Expanded(
                              //           child: NsgButton(
                              //             borderRadius: 20,

                              //             text: ' добавить пользователей в проект',
                              //             onPressed: () {
                              //               Get.find<ProjectItemUserTableController>().itemNewPageOpen(Routes.addUserToProjectPage);
                              //             },
                              //           ),
                              //         )),
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
