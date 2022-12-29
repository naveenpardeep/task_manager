import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';

class ProjectListPage extends StatelessWidget {
  ProjectListPage({Key? key}) : super(key: key);

  final _textTitle = 'Проекты'.toUpperCase();
  final _textNoItems = 'Проекты ещё не добавлены';
  final _elementPage = Routes.projectPage;
  var controller = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
           actions: [
            Image.asset(
              'lib/assets/images/logo.png',
              height: 70,
            ),
          ],
          title: Row(
            children: [
              SizedBox(width: width*0.4,),
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
                textScaleFactor: 1.5,
              ),
              onPressed: () {
                Get.toNamed(Routes.tasksListPage);
              },
            )),
            ],
          ),
          backgroundColor: const Color(0xff7876D9),
        ),
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
            var taskBoardController= Get.find<TaskBoardController>();
            taskBoardController.selectedItem;
           
            taskBoardController.sendNotify();
              element as ProjectItem;
              
              controller.currentItem = element;
             
              Get.toNamed(Routes.homePage);
            },
            availableButtons: const [
              NsgTableMenuButtonType.createNewElement,
              NsgTableMenuButtonType.editElement
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
            ]));
  }
}
