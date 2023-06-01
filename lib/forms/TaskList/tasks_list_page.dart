import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/TaskList/tasklist_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';
import '../user_account/service_object_controller.dart';
import '../widgets/top_menu.dart';

class TasksListPage extends GetView<TaskListController> {
  TasksListPage({Key? key}) : super(key: key);

  final _textTitle = 'Все задачи'.toUpperCase();
  final _textNoItems = 'Задачи ещё не добавлены';
  final _elementPage = Routes.taskPageFortaskList;
  var serviceC = Get.find<ServiceObjectController>();

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    double width = MediaQuery.of(context).size.width;
    return controller.obx(
      (state) => BodyWrap(
        child: Scaffold(
          body: Column(
            children: [
              if (width > 700) const TmTopMenu(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: NsgListPage(
                      appBar: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 150,
                              child: TTNsgInput(
                                label: 'Project',
                                infoString: 'Select Project',
                                selectionController: Get.find<ProjectController>(),
                                dataItem: serviceC.currentItem,
                                fieldName: ServiceObjectGenerated.nameProjectId,
                                onEditingComplete: (p0, p1) {
                                  controller.top=0;
                                  controller.refreshData();
                                },
                              ),
                            ),
                          )
                        ],
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
                        NsgTableColumn(name: TaskDocGenerated.nameDocNumber, expanded: true, width: 50, presentation: 'Номер'),
                        NsgTableColumn(name: TaskDocGenerated.nameProjectId, expanded: true, presentation: 'Проект'),
                        NsgTableColumn(name: TaskDocGenerated.nameDate, expanded: true, presentation: 'Дата'),
                        NsgTableColumn(name: TaskDocGenerated.nameName, expanded: true, presentation: 'Название задачи'),
                        if (width > 700) NsgTableColumn(name: TaskDocGenerated.nameDescription, presentation: 'Описание', expanded: true),
                        if (width > 700) NsgTableColumn(name: TaskDocGenerated.nameAssigneeId, width: 100, presentation: 'Исполнитель', expanded: true),
                        NsgTableColumn(name: TaskDocGenerated.nameTaskStatusId, expanded: true, presentation: 'Статус'),
                      ]),
                ),
              ),
              controller.obx((state) => controller.pagination(), onLoading: const SizedBox()),
              Center(child: Text('Total Tasks: ${controller.totalCount}')),
              if (width < 700) const BottomMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
