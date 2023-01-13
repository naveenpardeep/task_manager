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
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: width >= 600 ? 70 : 150,
          actions: [
            Image.asset(
              'lib/assets/images/logo.png',
              height: 70,
            ),
          ],
          title: width >= 600
              ? Row(
                  children: [
                    SizedBox(
                      width: width * 0.27,
                    ),
                    Text(
                      _textTitle.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 15, 15),
                        child: TextButton(
                          child: Text(
                            'Все задачи',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: width >= 800 ? 1.5 : 1,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.tasksListPage);
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 15, 15),
                        child: TextButton(
                          child: Text(
                            'Добавить пользователя',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                            textScaleFactor: width >= 800 ? 1.5 : 1,
                          ),
                          onPressed: () {
                            userAccountController.newItemPageOpen(
                                pageName: Routes.userAccountListPage);
                            // Get.toNamed(Routes.userAccountListPage);
                          },
                        )),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        _textTitle.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 15, 15),
                          child: TextButton(
                            child: const Text(
                              'Все задачи',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.tasksListPage);
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 15, 15),
                          child: TextButton(
                            child: const Text(
                              'Добавить пользователя',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              userAccountController.newItemPageOpen(
                                  pageName: Routes.userAccountListPage);
                              // Get.toNamed(Routes.userAccountListPage);
                            },
                          )),
                    ],
                  ),
                ),
          backgroundColor: const Color(0xff7876D9),
        ),
        body: Tooltip(
          message: 'Click on the project for more details',
          child: NsgListPage(
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

                Get.toNamed(Routes.homePage);
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
                NsgTableColumn(
                    name: ProjectItemGenerated.nameLeaderId,
                    expanded: true,
                    presentation: 'Руководитель проекта'),
                NsgTableColumn(
                    name: ProjectItemGenerated.nameDate,
                    expanded: true,
                    presentation: 'Дата создания'),
                NsgTableColumn(
                    name: ProjectItemGenerated.nameContractor,
                    expanded: true,
                    presentation: 'Заказчик'),
              ]),
        ));
  }
}
