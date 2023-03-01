import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);
  @override
  State<ProjectPage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectPage> {
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
                              if (!isNewProject) NsgText('Создано :${formateddate.format(controller.currentItem.date)}'),
                              NsgInput(
                                selectionController: Get.find<OrganizationController>(),
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameOrganizationId,
                                label: 'Группа проектов (организация)',
                              ),
                              NsgInput(
                                selectionController: Get.find<UserAccountController>(),
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameLeaderId,
                                label: 'Руководитель проекта',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameProjectPrefix,
                                label: 'Project Prefix',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameName,
                                label: 'Наименование',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameContractor,
                                label: 'Заказчик',
                              ),
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
                              if (controller.currentItem.name.isNotEmpty)
                                NsgButton(
                                  text: 'Delete Project',
                                  color: Colors.white,
                                  onPressed: () async {
                                    await controller.deleteItems([controller.currentItem]);
                                    Get.back();
                                    controller.refreshData();
                                  },
                                )
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
