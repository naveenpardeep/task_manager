// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/invitation/acceptController.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectUserMobile extends StatefulWidget {
  const ProjectUserMobile({Key? key}) : super(key: key);
  @override
  State<ProjectUserMobile> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectUserMobile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  var invitations = Get.find<AccpetController>();

  @override
  void initState() {
    super.initState();
    if (invitations.lateInit) {
      invitations.requestItems();
    }
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
                              invitations.obx((state) => projectuserInvitations(context)),
                              projectUsersList(context),
                            ],
                          ),
                        ),
                      )),
                ),
                NsgButton(
                  borderRadius: 30,
                  color: Colors.white,
                  backColor: const Color(0xff0859ff),
                  text: '+ Добавить участника в проект',
                  onPressed: () async {
                    await Get.find<ProjectUserController>().requestItems();
                    Get.find<ProjectItemUserTableController>().prepapreProjectUsers();

                    Get.find<ProjectItemUserTableController>().newItemPageOpen(pageName: Routes.projectuserRowpage);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget projectuserInvitations(BuildContext context) {
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];

    var invitations = Get.find<AccpetController>()
        .items
        .reversed
        .where((element) => element.project.name == controller.currentItem.name && element.isAccepted == false && element.isRejected == false);

    {
      for (var invitation in invitations) {
        {
          list.add(GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: invitation.invitedUser.photoName.isEmpty
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
                              TaskFilesController.getFilePath(invitation.invitedUser.photoName),
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
                              invitation.invitedUser.name,
                              style: TextStyle(
                                fontSize: ControlOptions.instance.sizeL,
                              ),
                            ),
                            Text(
                              invitation.invitedUser.phoneNumber,
                              style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invitated User',
                              style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: 'Cancel Invitation',
                        child: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () async {
                            Get.find<AccpetController>().currentItem = invitation;
                            await Get.find<AccpetController>().deleteItems([Get.find<AccpetController>().currentItem]);
                            Get.find<AccpetController>().refreshData();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        }
      }
    }

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: list,
      ),
    ));
  }

  Widget projectUsersList(BuildContext context) {
    List<Widget> list = [];
    //var projectUsertable = Get.find<ProjectItemUserTableController>().items;

    for (var projectuser in controller.currentItem.tableUsers.rows) {
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        child: InkWell(
          onTap: () {
            Get.find<ProjectItemUserTableController>().currentItem = projectuser;
            Get.toNamed(Routes.projectUserViewPage);
          },
          onLongPress: () {},
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
