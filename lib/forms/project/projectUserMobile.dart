// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';

class ProjectUserMobile extends StatefulWidget {
  const ProjectUserMobile({Key? key}) : super(key: key);
  @override
  State<ProjectUserMobile> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectUserMobile> {
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

    return SafeArea(
      child: Scaffold(
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
                              NsgButton(
                                borderRadius: 30,
                                color: const Color(0xff529FBF),
                                backColor: const Color(0xffEDEFF3),
                                text: '+ Добавить участника в проект',
                                onPressed: () async {
                                  await Get.find<ProjectUserController>().requestItems();
                                  Get.find<ProjectItemUserTableController>().prepapreProjectUsers();
                                  Get.find<ProjectItemUserTableController>().newItemPageOpen(pageName: Routes.projectuserRowpage);
                                },
                              ),
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
    var projectUsertable = Get.find<ProjectItemUserTableController>().items;

    for (var projectuser in projectUsertable) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            Get.find<ProjectItemUserTableController>().currentItem = projectuser;
            Get.toNamed(Routes.projectUserViewPage);
          },
          onLongPress: () {},
          child: Column(
            children: [
              Card(
                // elevation: 3,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: projectuser.userAccount.photoFile.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                  width: 32,
                                  height: 32,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 20,
                                    color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                  ),
                                )
                              : Image.memory(
                                  Uint8List.fromList(projectuser.userAccount.photoFile),
                                  fit: BoxFit.cover,
                                  width: 32,
                                  height: 32,
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
                            // Text(
                            //   projectuser.userAccount.email,
                            //   style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                            // ),
                          ],
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       showAlertDialog(context, projectuser);
                      //     },
                      //     icon: const Icon(
                      //       Icons.remove_circle_outline,
                      //       color: Colors.red,
                      //     )),
                      const Icon(Icons.arrow_forward_ios),
                    ],
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

  showAlertDialog(BuildContext context, user) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        Get.find<ProjectItemUserTableController>().currentItem = user;
        controller.currentItem.tableUsers.removeRow(Get.find<ProjectItemUserTableController>().currentItem);
        controller.itemPagePost();

        Navigator.of(context).pop();
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
