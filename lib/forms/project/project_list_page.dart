import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_grid.dart';
import 'package:nsg_controls/widgets/nsg_circle.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';
import '../task_board/task_board_controller.dart';
import '../tasks/tasks_controller.dart';
import '../widgets/mobile_menu.dart';
import '../widgets/top_menu.dart';

// ignore: must_be_immutable
class ProjectListPage extends GetView<ProjectController> {
  ProjectListPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late double width;

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    width = MediaQuery.of(context).size.width;
    return BodyWrap(
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
                      Expanded(
                        child: Text(
                          'Все проекты',
                          style: TextStyle(color: ControlOptions.instance.colorText, fontSize: ControlOptions.instance.sizeXL),
                        ),
                      ),
                      NsgButton(
                        width: 150,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        height: 40,
                        icon: Icons.add,
                        text: 'Новый проект',
                        color: Colors.white,
                        backColor: ControlOptions.instance.colorMain,
                        onPressed: () {
                          Get.find<ProjectController>().newItemPageOpen(pageName: Routes.projectSettingsPage);
                        },
                      ),
                    ],
                  )),
              Expanded(child: controller.obx((state) => showProjects())),
              if (width < 700) const BottomMenu(),
            ],
          )),
    );
  }

  Widget showProjects() {
    List<Widget> list = [];
    for (var project in controller.items) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.currentItem = project;
                  var taskConstroller = Get.find<TasksController>();
                  taskConstroller.refreshData();
                  Get.find<TaskBoardController>().refreshData();
                  // Get.toNamed(Routes.homePage);
                  controller.itemPageOpen(
                    project,
                    Routes.homePage,
                  );
                },
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
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
                                child: Text(
                                  project.name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: ControlOptions.instance.sizeL, height: 1),
                                ),
                              ),
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
                                          .userAccount)
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InkWell(
                                        onTap: () {
                                          //  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
                                          //    controller.itemPageOpen(project, Routes.projectSettingsPage);
                                          // } else {
                                          controller.itemPageOpen(project, Routes.projectMobilePageview);
                                          //   }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.edit,
                                            color: ControlOptions.instance.colorGrey,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ))
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
                                Text('Рук.: ${project.leader.name}', style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: const Color(0xff529FBF))),
                                Text('Организация: ${project.organization}',
                                    style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: const Color(0xff529FBF))),
                                Text('Заказчик: ${project.contractor}',
                                    style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: const Color(0xff529FBF))),
                              ],
                            )),
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
                              child: project.leader.photoFile.isEmpty
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
                                      Uint8List.fromList(project.leader.photoFile),
                                      fit: BoxFit.cover,
                                      width: 32,
                                      height: 32,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    }
    return RefreshIndicator(
      onRefresh: () {
        return controller.refreshData();
      },
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
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: width > 700 ? NsgGrid(crossAxisCount: width ~/ 400, children: list) : Column(children: list))),
    );
  }
}
