import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/task%20type/task_type_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';

class TaskTypeListPage extends GetView<TaskTypeController> {
  TaskTypeListPage({Key? key}) : super(key: key);

  final _textTitle = 'Task Type '.toUpperCase();
  final _textNoItems = 'Add task type';
  final _elementPage = Routes.taskTypePage;

  @override
  Widget build(BuildContext context) {
    return NsgListPage(
        type: NsgListPageMode.table,
        controller: controller,
        title: _textTitle,
        textNoItems: _textNoItems,
        elementEditPage: _elementPage,
        availableButtons: const [
          NsgTableMenuButtonType.createNewElement,
          NsgTableMenuButtonType.editElement
        ],
        columns: [
          NsgTableColumn(
              name: TaskTypeGenerated.nameName,
              expanded: true,
              presentation: 'Task type name'),
        ]);
  }
}