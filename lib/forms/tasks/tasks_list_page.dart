import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';
import 'tasks_controller.dart';

class TasksListPage extends GetView<TasksController> {
  TasksListPage({Key? key}) : super(key: key);

  final _textTitle = 'Все задачи'.toUpperCase();
  final _textNoItems = 'Задачи ещё не добавлены';
  final _elementPage = Routes.tasksPage;

  @override
  Widget build(BuildContext context) {
    return NsgListPage(
        appBarColor: Colors.white,
        appBarIcon2: null,
        type: NsgListPageMode.table,
        controller: controller,
        title: _textTitle,
        textNoItems: _textNoItems,
        elementEditPage: _elementPage,
        columns: [
          NsgTableColumn(
              name: TaskDocGenerated.nameProjectId,
              width: 100,
              presentation: 'Проект'),
          NsgTableColumn(
              name: TaskDocGenerated.nameDate,
              width: 100,
              presentation: 'Дата'),

          NsgTableColumn(
              name: TaskDocGenerated.nameName,
              width: 100,
              presentation: 'Название задачи'),
          NsgTableColumn(
              name: TaskDocGenerated.nameDescription,
              width: 100,
              presentation: 'Описание',
              expanded: true),
          NsgTableColumn(
              name: TaskDocGenerated.nameTaskStatusId,
              width: 100,
              presentation: 'Статус'),

          // NsgTableColumn(
          //     name: TaskDocGenerated.nameSprintId,
          //     width: 100,
          //     presentation: 'Спринт')
        ]);
  }
}
