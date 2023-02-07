import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../user_account/user_account_controller.dart';

class ProjectUserRowPage extends GetView<ProjectItemUserTableController> {
  const ProjectUserRowPage({Key? key}) : super(key: key);

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
                  text: controller.currentItem.isEmpty
                      ? 'User '.toUpperCase()
                      : controller.currentItem.owner.name,
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () async {
                    await controller.itemPagePost();
                    await Get.find<ProjectController>().itemPagePost();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NsgInput(
                              selectionController:
                                  Get.find<ProjectUserController>(),
                              dataItem: controller.currentItem,
                              fieldName: ProjectItemUserTableGenerated
                                  .nameUserAccountId,
                              label: 'User ',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName:
                                  ProjectItemUserTableGenerated.nameIsAdmin,
                              label: 'Admin',
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
}
