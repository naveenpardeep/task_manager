import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';






class AddUserToProjectPage extends GetView<ProjectItemUserTableController> {
  const AddUserToProjectPage({Key? key}) : super(key: key);

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
                  onPressed2: () async{
                 await   controller.itemPagePost();
                  await  Get.find<ProjectController>().itemPagePost();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                           const  NsgText('Добавление пользователей в проект'),
                          
                             NsgTable(
                              showIconFalse: false,
                              controller:
                                  Get.find<ProjectItemUserTableController>(),
                              elementEditPageName: Routes.projectuserRowpage,
                              availableButtons: const [
                                NsgTableMenuButtonType.createNewElement,
                                NsgTableMenuButtonType.editElement,
                                NsgTableMenuButtonType.removeElement
                              ],
                              columns: [
                                NsgTableColumn(
                                    name: ProjectItemUserTableGenerated
                                        .nameUserAccountId,
                                    expanded: true,
                                    presentation: 'User'),
                                NsgTableColumn(
                                    name: ProjectItemUserTableGenerated
                                        .nameIsAdmin,
                                    width: 100,
                                    presentation: 'Admin'),
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
}
