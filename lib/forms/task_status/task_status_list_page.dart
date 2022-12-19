import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';
import 'task_status_controller.dart';

class TaskStatusListPage extends GetView<TaskStatusController> {
  TaskStatusListPage({Key? key}) : super(key: key);

  final _textTitle = 'Статусы задач'.toUpperCase();
  final _textNoItems = 'Нет элементов';
  final _elementPage = Routes.taskStatusPage;

  @override
  Widget build(BuildContext context) {
    return NsgListPage(
        type: NsgListPageMode.table,
        controller: controller,
        title: _textTitle,
        textNoItems: _textNoItems,
        elementEditPage: _elementPage,
        columns: [
          NsgTableColumn(
              name: TaskStatusGenerated.nameName,
              expanded: true,
              presentation: 'Наименование'),
        ]);
  }
}
