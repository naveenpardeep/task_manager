import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';

class ProjectListPage extends GetView<ProjectController> {
  ProjectListPage({Key? key}) : super(key: key);

  final _textTitle = 'Проекты'.toUpperCase();
  final _textNoItems = 'Проекты ещё не добавлены';
  final _elementPage = Routes.projectPage;

  @override
  Widget build(BuildContext context) {
    return NsgListPage(
        type: NsgListPageMode.table,
        controller: controller,
        title: _textTitle,
        textNoItems: _textNoItems,
        elementEditPage: _elementPage,
        onElementTap: (element) {
          element as ProjectItem;
          controller.currentItem = element;
          Get.toNamed(Routes.homePage);
        },
        availableButtons: [
          NsgTableMenuButtonType.createNewElement,
          NsgTableMenuButtonType.editElement
        ],
        columns: [
          NsgTableColumn(
              name: ProjectItemGenerated.nameName,
              expanded: true,
              presentation: 'Название проекта'),
          NsgTableColumn(
              name: ProjectItemGenerated.nameDate,
              expanded: true,
              presentation: 'Дата создания'),
        ]);
  }
}
