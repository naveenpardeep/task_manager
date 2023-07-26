import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_grid.dart';
import 'package:nsg_controls/widgets/nsg_circle.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';
import '../task_board/task_board_controller.dart';
import '../widgets/top_menu.dart';

// ignore: must_be_immutable
class ProjectListPage extends StatefulWidget {
  const ProjectListPage({Key? key}) : super(key: key);
  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  var controller = Get.find<ProjectController>();
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var orgcon = Get.find<OrganizationController>();
  var orgitemcon = Get.find<OrganizationItemUserTableController>();
  late double width;
  var textEditController = TextEditingController();

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
    return SafeArea(
      child: BodyWrap(
        child: Scaffold(
            key: scaffoldKey,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (width > 700) const TmTopMenu(),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                    child: Row(
                      children: [
                        if (width > 700)
                          const Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Text(
                              'Проекты',
                              style: TextStyle(fontSize: 16 , fontFamily: 'Inter'),
                            ),
                          ),
                        Flexible(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Routes.archProjectListPage);
                                },
                                child: Text(
                                  'Архивные проекты',
                                  style: TextStyle(fontSize: width > 700 ? 16 : 12, fontFamily: 'Inter'),
                                ),
                              )),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: width > 700 ? 30 : 30,
                            child: TextField(
                                controller: textEditController,
                                decoration: InputDecoration(
                                    filled: false,
                                    fillColor: ControlOptions.instance.colorMainLight,
                                    prefixIcon: width > 700 ? const Icon(Icons.search) : null,
                                    border: OutlineInputBorder(
                                        gapPadding: 1,
                                        borderSide: BorderSide(color: ControlOptions.instance.colorMainDark),
                                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                                    suffixIcon: IconButton(
                                        hoverColor: Colors.transparent,
                                        padding: const EdgeInsets.only(bottom: 0),
                                        onPressed: (() {
                                          setState(() {});
                                          textEditController.clear();
                                        }),
                                        icon: const Icon(Icons.cancel)),
                                    // prefixIcon: Icon(Icons.search),
                                    hintText: 'Search Project...'),
                                textAlignVertical: TextAlignVertical.bottom,
                                style: TextStyle(color: ControlOptions.instance.colorMainLight, fontFamily: 'Inter', fontSize: width > 700 ? 16 : 10),
                                onChanged: (val) {
                                  setState(() {});
                                }),
                          ),
                        ),
                        SizedBox(
                          width: width < 700 ? 50 : 150,
                          height: 30,
                          child: IconButton(
                            iconSize: 30,
                            hoverColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            icon: width < 700
                                ? const Icon(
                                    Icons.add,
                                    size: 24,
                                  )
                                : const Text(
                                    '+ Создать проект',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 16),
                                  ),
                            color: Colors.black,
                            onPressed: () {
                              Get.find<ProjectController>().newItemPageOpen(pageName: Routes.projectSettingsPage);
                            },
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: RefreshIndicator(
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
                      thumbColor: ControlOptions.instance.colorPrimary.withOpacity(0.2),
                      radius: const Radius.circular(0),
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          child: controller.obx((state) {
                            return width > 700
                                ? Animate(effects: const [ScaleEffect()], child: NsgGrid(crossAxisCount: width ~/ 400, children: showProjects()))
                                : Column(children: showProjects());
                          }))),
                )),
                if (width < 700) const BottomMenu(),
              ],
            )),
      ),
    );
  }

  List<Widget> showProjects() {
    List<Widget> list = [];
    for (var project in controller.items.where((element) => !element.isArchived)) {
      if (project.name.toString().toLowerCase().contains(textEditController.text.toLowerCase())) {
        list.add(ProjectItemView(
          project: project,
          searchvalue: textEditController.text,
        ));
      }
    }
    return list;
  }
}

class ProjectItemView extends StatelessWidget {
  ProjectItemView({super.key, required this.project, this.searchvalue});

  final ProjectItem project;
  final String? searchvalue;
  final controller = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () async {
          await Get.find<TaskBoardController>().refreshData();
          //await Get.find<TasksController>().refreshData();
          controller.itemPageOpen(project, Routes.homePage, needRefreshSelectedItem: false);
          //Get.find<TasksController>().getTasksControllers();
        },
        onLongPress: () {
          pinDialog(context, project);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffEDEFF3),
          ),
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
                            textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 16, color: Colors.black),
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
                      Text('Рук.: ${project.leader.name}', style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF))),
                      Text('Организация: ${project.organization}', style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF))),
                      Text('Заказчик: ${project.contractor}', style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF))),
                    ],
                  )),
                  if (project.numberOfNotifications > 0)
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
                  if (project.numberOfTasksUpdatedIn24Hours > 0)
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
                  if (project.numberOfTasksOverdue > 0)
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
                  if (project.numberOfTasksOpen > 0)
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
                  const Padding(padding: EdgeInsets.only(left: 10)),
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
    );
  }

  pinDialog(BuildContext context, ProjectItem project) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(width, height * 0.08),
              ),
              child: Text(project.isPinned ? 'Unpin' : 'Pin'),
              onPressed: () async {
                project.isPinned = project.isPinned ? false : true;
                await controller.postItems([project]);
                controller.refreshData();
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
            )
          ],
        );
      },
    );
  }

  Future<void> showPopUpMenu(Offset globalPosition, project, BuildContext context) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;

    await showMenu(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      color: const Color(0xffEDEFF3).withOpacity(0.9),
      context: context,
      position: RelativeRect.fromLTRB(left, top, left + 1, top + 1),
      items: [
        PopupMenuItem(
          value: 1,
          child: Animate(
            effects: const [FlipEffect()],
            child: const Padding(
              padding: EdgeInsets.only(left: 0, right: 40),
              child: Text(
                "Редактировать",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Animate(
            effects: const [FlipEffect()],
            child: const Padding(
              padding: EdgeInsets.only(left: 0, right: 40),
              child: Text(
                "Закрепить",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Animate(
            effects: const [FlipEffect()],
            child: const Padding(
              padding: EdgeInsets.only(left: 0, right: 40),
              child: Text(
                "Архив проекта",
                style: TextStyle(color: Colors.black),
              ),
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
        pinDialog(context, project);
      }
      if (value == 3) {
        archiveProject(context, project);
      }
    });
  }

  archiveProject(BuildContext context, project) {
    Widget yesButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        project.isArchived = true;
        controller.postItems([project]);
        controller.refreshData();
        Navigator.of(context).pop();
      },
    );
    Widget noButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content:  Text('Do you want to Archive ' "${project.name} Project?"),
      actions: [
        yesButton,
        noButton,
      ],
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
