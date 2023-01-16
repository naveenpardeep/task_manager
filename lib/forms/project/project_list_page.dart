import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';
import '../user_account/user_account_controller.dart';
import '../widgets/top_menu.dart';

class ProjectListPage extends GetView<ProjectController> {
  ProjectListPage({Key? key}) : super(key: key);

  final _textTitle = 'Проекты'.toUpperCase();
  final _textNoItems = 'Проекты ещё не добавлены';
  final _elementPage = Routes.projectPage;
  // var controller = Get.find<ProjectController>();
  var userAccountController = Get.find<UserAccountController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BodyWrap(
      child: Scaffold(
          key: scaffoldKey,
          body: Column(
            children: [
              if (width > 991) const TmTopMenu(),
              Expanded(
                child: Tooltip(
                  message: 'Click on the project for more details',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: NsgListPage(
                        appBar: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Все проекты',
                            style: TextStyle(
                                color: ControlOptions.instance.colorText, fontSize: ControlOptions.instance.sizeXL),
                          ),
                        ),
                        appBarIcon: null,
                        appBarIcon2: null,
                        appBarBackColor: const Color(0xff7876D9),
                        appBarColor: Colors.white,
                        type: NsgListPageMode.table,
                        controller: controller,
                        title: _textTitle,
                        textNoItems: _textNoItems,
                        elementEditPage: _elementPage,
                        onElementTap: (element) {
                          var taskConstroller = Get.find<TasksController>();
                          Get.find<TaskBoardController>().sendNotify();

                          element as ProjectItem;

                          controller.currentItem = element;
                          taskConstroller.refreshData();

                          Get.toNamed(Routes.homePage);
                        },
                        availableButtons: const [
                          NsgTableMenuButtonType.createNewElement,
                          NsgTableMenuButtonType.editElement,
                          NsgTableMenuButtonType.removeElement
                        ],
                        columns: [
                          NsgTableColumn(
                              name: ProjectItemGenerated.nameName, expanded: true, presentation: 'Название проекта'),
                          NsgTableColumn(
                              name: ProjectItemGenerated.nameLeaderId,
                              expanded: true,
                              presentation: 'Руководитель проекта'),
                          NsgTableColumn(
                              name: ProjectItemGenerated.nameDate, expanded: true, presentation: 'Дата создания'),
                          NsgTableColumn(
                              name: ProjectItemGenerated.nameContractor, expanded: true, presentation: 'Заказчик'),
                        ]),
                  ),
                ),
              ),
              if (width < 992) const TmTopMenu(),
            ],
          )),
    );
  }
}
