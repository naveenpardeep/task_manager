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

class UserProjectListPage extends GetView<ProjectController> {
  UserProjectListPage({Key? key}) : super(key: key);

  final _textTitle = 'Проекты'.toUpperCase();
  final _textNoItems = 'Проекты ещё не добавлены';
  final _elementPage = Routes.projectPage;
  // var controller = Get.find<ProjectController>();
  var userAccountController = Get.find<UserAccountController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: scaffoldKey,
      
        body: NsgListPage(
            appBar: const SizedBox(),
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
              taskConstroller.refreshData();

              element as ProjectItem;

              controller.currentItem = element;

              Get.toNamed(Routes.userProfilePage);
            },
            availableButtons: const [
              NsgTableMenuButtonType.createNewElement,
              NsgTableMenuButtonType.editElement,
              NsgTableMenuButtonType.removeElement
            ],
            columns: [
              NsgTableColumn(
                  name: ProjectItemGenerated.nameName,
                  expanded: true,
                  presentation: 'Название проекта'),
              
            ]));
  }
}