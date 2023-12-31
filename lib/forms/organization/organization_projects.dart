import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_grid.dart';
import 'package:nsg_controls/widgets/nsg_circle.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';

import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/organization_item_user_table.dart';
import 'package:task_manager_app/model/project_item.dart';
import 'package:task_manager_app/model/project_item_user_table.dart';
import '../../app_pages.dart';

// ignore: must_be_immutable
class OrganizationProject extends GetView<ProjectController> {
  OrganizationProject({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late double width;

  var scrollController2 = ScrollController();

  var orgcon = Get.find<OrganizationController>();
  var orgitemcon = Get.find<OrganizationItemUserTableController>();

  var textEditController = TextEditingController();
  String searchvalue = '';

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    if (orgcon.lateInit) {
      orgcon.requestItems();
    }
    if (orgitemcon.lateInit) {
      orgitemcon.requestItems();
    }
    width = MediaQuery.of(context).size.width;
    return BodyWrap(
      child: Scaffold(
          key: scaffoldKey,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: controller.obx((state) => showProjects(context))),
              if (width < 700) const BottomMenu(),
            ],
          )),
    );
  }

  Widget showProjects(context) {
    List<Widget> list = [];
    for (var project in controller.items.where((element) => element.organization == orgcon.currentItem)) {
      if (project.name.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        list.add(Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffEDEFF3),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.currentItem = project;
                      var taskConstroller = Get.find<TasksController>();
                      taskConstroller.refreshData();
                      Get.find<TaskBoardController>().refreshData();

                      controller.itemPageOpen(project, Routes.homePage, needRefreshSelectedItem: true);
                    },
                    onLongPress: () {
                      showAlertDialogPin(context, project);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: SubstringHighlight(
                                        text: project.name,
                                        term: searchvalue,
                                        textStyle: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold, color: Colors.black),
                                        textStyleHighlight: const TextStyle(color: Colors.deepOrange),
                                      )),
                                ),
                                if (project.isPinned) const Icon(Icons.push_pin, color: Colors.lightBlue),
                                GestureDetector(
                                  onTapDown: (TapDownDetails details) {
                                    showPopUpMenu(details.globalPosition, project, context);
                                  },
                                  child: const Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Рук.: ${project.leader.name}',
                                      style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: const Color(0xff529FBF))),
                                  Text('Организация: ${project.organization}',
                                      style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: const Color(0xff529FBF))),
                                  Text('Заказчик: ${project.contractor}',
                                      style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: const Color(0xff529FBF))),
                                ],
                              )),
                              if (project.numberOfNotifications.isGreaterThan(0))
                                Tooltip(
                                  message: 'Number of Notifications',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: NsgCircle(
                                      text: project.numberOfNotifications.toString(),
                                      fontSize: 14,
                                      borderWidth: 1.3,
                                      color: ControlOptions.instance.colorText,
                                      borderColor: ControlOptions.instance.colorBlue,
                                      shadow: const BoxShadow(),
                                    ),
                                  ),
                                ),
                              if (project.numberOfTasksUpdatedIn24Hours.isGreaterThan(0))
                                Tooltip(
                                  message: 'Tasks Updated In 24Hours',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: NsgCircle(
                                      text: project.numberOfTasksUpdatedIn24Hours.toString(),
                                      fontSize: 14,
                                      borderWidth: 1.3,
                                      color: ControlOptions.instance.colorText,
                                      borderColor: ControlOptions.instance.colorWarning,
                                      shadow: const BoxShadow(),
                                    ),
                                  ),
                                ),
                              if (project.numberOfTasksOverdue.isGreaterThan(0))
                                Tooltip(
                                  message: 'Overdue Tasks',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: NsgCircle(
                                      text: project.numberOfTasksOverdue.toString(),
                                      fontSize: 14,
                                      borderWidth: 1.3,
                                      color: ControlOptions.instance.colorText,
                                      borderColor: ControlOptions.instance.colorError,
                                      shadow: const BoxShadow(),
                                    ),
                                  ),
                                ),
                              if (project.numberOfTasksOpen.isGreaterThan(0))
                                Tooltip(
                                  message: 'Tasks open',
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: NsgCircle(
                                      text: project.numberOfTasksOpen.toString(),
                                      fontSize: 14,
                                      borderWidth: 1.3,
                                      color: ControlOptions.instance.colorText,
                                      shadow: const BoxShadow(),
                                    ),
                                  ),
                                ),
                              ClipOval(
                                  child: project.photoPath.isEmpty
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
                                      : Image.network(
                                          TaskFilesController.getFilePath(project.photoPath),
                                          fit: BoxFit.cover,
                                          width: 32,
                                          height: 32,
                                        )),
                            ],
                          ),
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
    }
    return RefreshIndicator(
      onRefresh: () {
        return controller.refreshData();
      },
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
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: width > 700 ? NsgGrid(crossAxisCount: width ~/ 400, children: list) : Column(children: list))),
    );
  }

  Future<void> showPopUpMenu(Offset globalPosition, project, context) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;

    await showMenu(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      color: const Color(0xffEDEFF3),
      context: context,
      position: RelativeRect.fromLTRB(left, top, left + 1, top + 1),
      items: [
        const PopupMenuItem(
          value: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 40),
            child: Text(
              "Редактировать",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 40),
            child: Text(
              "Закрепить",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 1) {
        if (Get.find<DataController>().currentUser == project.leader ||
            Get.find<DataController>().currentUser == project.leader.mainUserAccount ||
            Get.find<DataController>().currentUser == project.organization.ceo ||
            Get.find<DataController>().currentUser == project.organization.ceo.mainUserAccount ||
            Get.find<DataController>().currentUser ==
                project.organization.tableUsers.rows
                    .firstWhere(
                      (element) => element.isAdmin == true,
                      orElse: () => OrganizationItemUserTable(),
                    )
                    .userAccount ||
            Get.find<DataController>().currentUser.mainUserAccount ==
                project.organization.tableUsers.rows
                    .firstWhere(
                      (element) => element.isAdmin == true,
                      orElse: () => OrganizationItemUserTable(),
                    )
                    .userAccount ||
            Get.find<DataController>().currentUser.mainUserAccount ==
                project.tableUsers.rows
                    .firstWhere(
                      (element) => element.isAdmin == true,
                      orElse: () => ProjectItemUserTable(),
                    )
                    .userAccount ||
            Get.find<DataController>().currentUser ==
                project.tableUsers.rows
                    .firstWhere(
                      (element) => element.isAdmin == true,
                      orElse: () => ProjectItemUserTable(),
                    )
                    .userAccount) {
          controller.itemPageOpen(project, Routes.projectMobilePageview);
        } else {
          Get.snackbar('', 'Sorry you can not edit this Project');
        }
      }
      if (value == 2) {
        if (project.isPinned == false) {
          showAlertDialogPin(context, project);
        }
        if (project.isPinned) {
          showAlertDialogUnpin(context, project);
        }
      }
    });
  }

  showAlertDialogPin(BuildContext context, ProjectItem project) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // set up the button
    Widget pin = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        // elevation: 3,
        minimumSize: Size(width, height * 0.08),
      ),
      child: const Text("Pin"),
      onPressed: () async {
        if (controller.items.where((element) => element.isPinned == true).length >= 3) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You can Pin upto 3 projects in free version')));
        } else {
          project.isPinned = true;
          controller.currentItem = project;
          await controller.postItems([controller.currentItem]);
          controller.refreshData();
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actions: [pin],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogUnpin(BuildContext context, ProjectItem project) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // set up the button

    Widget unpin = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        // elevation: 3,
        minimumSize: Size(width, height * 0.08),
      ),
      child: const Text("Unpin"),
      onPressed: () async {
        project.isPinned = false;
        controller.currentItem = project;
        await controller.postItems([controller.currentItem]);
        controller.refreshData();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actions: [unpin],
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
