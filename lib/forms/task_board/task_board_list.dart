import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';

class TaskBoardListPage extends GetView<TaskBoardController> {
  TaskBoardListPage({Key? key}) : super(key: key);

  final _textTitle = 'Экран '.toUpperCase();
  final _textNoItems = 'add Экран';
  final _elementPage = Routes.taskBoard;

  @override
  Widget build(BuildContext context) {
    return NsgListPage(
        type: NsgListPageMode.table,
        controller: controller,
        title: _textTitle,
        textNoItems: _textNoItems,
        elementEditPage: _elementPage,
       
        availableButtons: [
          NsgTableMenuButtonType.createNewElement,
          NsgTableMenuButtonType.editElement
        ],
        columns: [
          NsgTableColumn(
              name: TaskBoardGenerated.nameName,
              expanded: true,
              presentation: 'Название доски'),
       
        ]);
  }
}
