// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

class NewUserForDeletedUserPage extends StatefulWidget {
  const NewUserForDeletedUserPage({Key? key}) : super(key: key);
  @override
  State<NewUserForDeletedUserPage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<NewUserForDeletedUserPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();

  @override
  void initState() {
    super.initState();

    scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    double width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(child: Text('Выберите пользователя для назначения отложенных задач')),
        ),
        resizeToAvoidBottomInset: true,
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
                      child: RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: scrollController,
                        thickness:  width>700? 10: 0,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              projectUsersList(context),
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

  Widget projectUsersList(BuildContext context) {
    List<Widget> list = [];
    bool res;

    for (var projectuser in controller.currentItem.tableUsers.rows.where((element) => element.userAccountId!=Get.find<ProjectItemUserTableController>().currentItem.userAccountId)) {
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        child: InkWell(
          onTap: () async {
            var dataController = Get.find<DataController>();
            var projController = Get.find<ProjectController>();
            res = (await dataController.removeUser(
                    projController.currentItem.id, Get.find<ProjectItemUserTableController>().currentItem.userAccountId, projectuser.userAccountId,
                    showProgress: true))
                .first;

            if (res) {
              controller.currentItem.tableUsers.removeRow(Get.find<ProjectItemUserTableController>().currentItem);
              Get.find<ProjectItemUserTableController>().selectedItem = null;
              Get.toNamed(Routes.projectMobilePageview);
              projController.refreshData();
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipOval(
                      child: projectuser.userAccount.photoName.isEmpty
                          ? Container(
                              decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.account_circle,
                                size: 48,
                                color: ControlOptions.instance.colorMain.withOpacity(0.4),
                              ),
                            )
                          : Image.network(
                              TaskFilesController.getFilePath(projectuser.userAccount.photoName),
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projectuser.userAccount.name,
                          style: TextStyle(
                            fontSize: ControlOptions.instance.sizeL,
                          ),
                        ),
                        Text(
                          projectuser.userAccount.phoneNumber,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                        ),
                      ],
                    ),
                  ),
                  if (projectuser.isAdmin) const Icon(Icons.admin_panel_settings),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projectuser.userAccount.organization.name,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }

    return SingleChildScrollView(child: Column(children: list));
  }
}
