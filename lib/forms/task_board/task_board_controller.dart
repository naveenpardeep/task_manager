import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/task_board.dart';

import '../../model/enums/e_period.dart';
import '../../model/enums/e_sorting.dart';
import '../../model/generated/task_board.g.dart';

import '../project/project_controller.dart';

class TaskBoardController extends NsgDataController<TaskBoard> {
  TaskBoardController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<ProjectController>();
  }

  @override
  void sendNotify({List<NsgUpdateKey>? keys}) {
    //Get.find<TasksController>().refreshAllTasksControllers();
    super.sendNotify(keys: keys);
  }

  @override
  Future afterRequestItems(List<NsgDataItem> newItemsList) async {
    var projectController = Get.find<ProjectController>();
    if (!newItemsList.contains(currentItem) && newItemsList.isNotEmpty) {
      currentItem = newItemsList.first as TaskBoard;
    }
    if (NsgUserSettings.controller!.getSettingItem('sort_${projectController.currentItem.id}') != null) {
      currentItem.sortBy =
          getSort(int.parse((NsgUserSettings.controller!.getSettingItem('sort_${projectController.currentItem.id}') as UserSettings).settings));
    }
    if (NsgUserSettings.controller!.getSettingItem('period_${projectController.currentItem.id}') != null) {
      currentItem.periodOfFinishedTasks =
          getPeriod(int.parse((NsgUserSettings.controller!.getSettingItem('period_${projectController.currentItem.id}') as UserSettings).settings));
    }
    Get.find<ProjectController>().sendNotify();
    Get.find<TasksController>().getTasksControllers();
    return await super.afterRequestItems(newItemsList);
  }

  ESorting getSort(int val) {
    switch (val) {
      case 1:
        return ESorting.dateAsc;
      case 2:
        return ESorting.priorityDesc;
      case 3:
        return ESorting.priorityAsc;
      default:
        return ESorting.dateDesc;
    }
  }

  EPeriod getPeriod(int val) {
    switch (val) {
      case 1:
        return EPeriod.day;
      case 2:
        return EPeriod.week;
      case 3:
        return EPeriod.month;
      case 4:
        return EPeriod.year;
      default:
        return EPeriod.all;
    }
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskBoard;
    element.project = Get.find<ProjectController>().currentItem;

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var projectController = Get.find<ProjectController>();

    cmp.add(name: TaskBoardGenerated.nameProjectId, value: projectController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }
}
