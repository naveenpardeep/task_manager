import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/mobile_menu.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';
import '../widgets/top_menu.dart';
import 'tasks_controller.dart';

class TasksListPage extends GetView<TasksController> {
  TasksListPage({Key? key}) : super(key: key);

  final _textTitle = 'Все задачи'.toUpperCase();
  final _textNoItems = 'Задачи ещё не добавлены';
  final _elementPage = Routes.newTaskPage;

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    double width = MediaQuery.of(context).size.width;
    return BodyWrap(
      child: Scaffold(
        body: Column(
          children: [
            if (width > 700) const TmTopMenu(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: NsgListPage(
                    appBar: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Все задачи',
                        style: TextStyle(color: ControlOptions.instance.colorText, fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                    type: NsgListPageMode.table,
                    controller: controller,
                    title: _textTitle,
                    textNoItems: _textNoItems,
                    elementEditPage: _elementPage,
                    availableButtons: const [
                      NsgTableMenuButtonType.editElement,
                      NsgTableMenuButtonType.filterPeriod,
                      NsgTableMenuButtonType.filterPeriod,
                      NsgTableMenuButtonType.filterText,
                      NsgTableMenuButtonType.refreshTable,
                      NsgTableMenuButtonType.removeElement
                    ],
                    columns: [
                      NsgTableColumn(name: TaskDocGenerated.nameProjectId, expanded: true, presentation: 'Проект'),
                      NsgTableColumn(name: TaskDocGenerated.nameDate, expanded: true, presentation: 'Дата'),

                      NsgTableColumn(name: TaskDocGenerated.nameName, expanded: true, presentation: 'Название задачи'),
                      if (width > 700) NsgTableColumn(name: TaskDocGenerated.nameDescription, presentation: 'Описание', expanded: true),
                      if (width > 700) NsgTableColumn(name: TaskDocGenerated.nameAssigneeId, width: 100, presentation: 'Исполнитель', expanded: true),
                      NsgTableColumn(name: TaskDocGenerated.nameTaskStatusId, expanded: true, presentation: 'Статус'),

                      // NsgTableColumn(
                      //     name: TaskDocGenerated.nameSprintId,
                      //     width: 100,
                      //     presentation: 'Спринт')
                    ]),
              ),
            ),
            //  if (width < 700) const TmMobileMenu(),
            if (width < 700) 
            //const BottomMenu(),
             const TmMobileMenu()
          ],
        ),
      ),
    );
  }
}
