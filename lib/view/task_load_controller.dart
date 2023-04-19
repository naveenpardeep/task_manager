import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../forms/project/project_controller.dart';
import '../forms/task_board/task_board_controller.dart';
import '../forms/user_account/service_object_controller.dart';
import '../model/enums/e_period.dart';
import '../model/enums/e_sorting.dart';
import '../model/generated/task_doc.g.dart';
import '../model/generated/user_account.g.dart';
import '../model/task_doc.dart';
import '../model/task_status.dart';

class TaskLoadController extends NsgBaseController {
  TaskLoadController({required this.currentTasksStatus});
  List<TaskDoc> currentStatusTasks = [];
  TaskStatus currentTasksStatus;

  set currentTaskStatus(TaskStatus tStat) {
    currentTasksStatus = tStat;
    getTasks(0, 0);
  }

  ///Текущий статус задач
  TaskStatus get currentTaskStatus => currentTasksStatus;

  Future<List<TaskDoc>> _getTasksFromStatus(TaskStatus status, int top, int count) async {
    var tasks = NsgDataRequest<TaskDoc>(dataItemType: TaskDoc);
    var filter = NsgDataRequestParams(top: top, count: count);

    var projectController = Get.find<ProjectController>();
    var taskBoardController = Get.find<TaskBoardController>();
    var finalTasks = NsgCompare();
    var notfinalTask = NsgCompare();
    List<String> notfinalStatusId = [];
    List<String> statusId = [];
    taskBoardController.currentItem.statusTable.rows.where((element) => element.status.isDone).toList().forEach((element) {
      statusId.add(element.statusId);
    });

    taskBoardController.currentItem.statusTable.rows.where((element) => !element.status.isDone).toList().forEach((element) {
      notfinalStatusId.add(element.statusId);
    });

    //Фильтр по времени исполнения задачи
    if (taskBoardController.currentItem.periodOfFinishedTasks == EPeriod.day) {
      notfinalTask.add(name: TaskDocGenerated.nameTaskStatusId, value: notfinalStatusId, comparisonOperator: NsgComparisonOperator.inList);
      finalTasks.add(
          name: TaskDocGenerated.nameDateUpdated,
          value: DateTime.now().add(const Duration(days: -1)),
          comparisonOperator: NsgComparisonOperator.greaterOrEqual);
      finalTasks.add(name: TaskDocGenerated.nameTaskStatusId, value: statusId, comparisonOperator: NsgComparisonOperator.inList);

      var taskCondtion = NsgCompare();
      taskCondtion.logicalOperator = NsgLogicalOperator.or;
      taskCondtion.add(name: 'one', value: notfinalTask);
      taskCondtion.add(name: 'two', value: finalTasks);
      filter.compare.add(name: 'three', value: taskCondtion);
    }
    if (taskBoardController.currentItem.periodOfFinishedTasks == EPeriod.week) {
      notfinalTask.add(name: TaskDocGenerated.nameTaskStatusId, value: notfinalStatusId, comparisonOperator: NsgComparisonOperator.inList);
      finalTasks.add(
          name: TaskDocGenerated.nameDateUpdated,
          value: DateTime.now().add(const Duration(days: -7)),
          comparisonOperator: NsgComparisonOperator.greaterOrEqual);
      finalTasks.add(name: TaskDocGenerated.nameTaskStatusId, value: statusId, comparisonOperator: NsgComparisonOperator.inList);

      var taskCondtion = NsgCompare();
      taskCondtion.logicalOperator = NsgLogicalOperator.or;
      taskCondtion.add(name: 'one', value: notfinalTask);
      taskCondtion.add(name: 'two', value: finalTasks);
      filter.compare.add(name: 'three', value: taskCondtion);
    }
    if (taskBoardController.currentItem.periodOfFinishedTasks == EPeriod.month) {
      notfinalTask.add(name: TaskDocGenerated.nameTaskStatusId, value: notfinalStatusId, comparisonOperator: NsgComparisonOperator.inList);
      finalTasks.add(
          name: TaskDocGenerated.nameDateUpdated,
          value: DateTime.now().add(const Duration(days: -31)),
          comparisonOperator: NsgComparisonOperator.greaterOrEqual);
      finalTasks.add(name: TaskDocGenerated.nameTaskStatusId, value: statusId, comparisonOperator: NsgComparisonOperator.inList);

      var taskCondtion = NsgCompare();
      taskCondtion.logicalOperator = NsgLogicalOperator.or;
      taskCondtion.add(name: 'one', value: notfinalTask);
      taskCondtion.add(name: 'two', value: finalTasks);
      filter.compare.add(name: 'three', value: taskCondtion);
    }
    if (taskBoardController.currentItem.periodOfFinishedTasks == EPeriod.year) {
      notfinalTask.add(name: TaskDocGenerated.nameTaskStatusId, value: notfinalStatusId, comparisonOperator: NsgComparisonOperator.inList);
      finalTasks.add(
          name: TaskDocGenerated.nameDateUpdated,
          value: DateTime.now().add(const Duration(days: -365)),
          comparisonOperator: NsgComparisonOperator.greaterOrEqual);
      finalTasks.add(name: TaskDocGenerated.nameTaskStatusId, value: statusId, comparisonOperator: NsgComparisonOperator.inList);
      var taskCondtion = NsgCompare();
      taskCondtion.logicalOperator = NsgLogicalOperator.or;
      taskCondtion.add(name: 'one', value: notfinalTask);
      taskCondtion.add(name: 'two', value: finalTasks);
      filter.compare.add(name: 'three', value: taskCondtion);
    }
    if (taskBoardController.currentItem.periodOfFinishedTasks == EPeriod.all) {
      notfinalTask.add(name: TaskDocGenerated.nameTaskStatusId, value: notfinalStatusId, comparisonOperator: NsgComparisonOperator.inList);
      finalTasks.add(name: TaskDocGenerated.nameTaskStatusId, value: statusId, comparisonOperator: NsgComparisonOperator.inList);

      var taskCondtion = NsgCompare();
      taskCondtion.logicalOperator = NsgLogicalOperator.or;
      taskCondtion.add(name: 'one', value: notfinalTask);
      taskCondtion.add(name: 'two', value: finalTasks);
      filter.compare.add(name: 'three', value: taskCondtion);
    }
    var serviceC = Get.find<ServiceObjectController>();

    // Если указан ID пользователя, то фильтруем заявки по пользователю
    if (serviceC.currentItem.userAccountId.isNotEmpty) {
      filter.compare.add(name: '${TaskDocGenerated.nameAssigneeId}.${UserAccountGenerated.nameMainUserAccountId}', value: serviceC.currentItem.userAccountId);
    }

    // Сортировка
    if (projectController.currentItem.id != "") {
      if (taskBoardController.currentItem.sortBy == ESorting.dateAsc) {
        filter.sorting = "${TaskDocGenerated.nameDate}+";
      }
      if (taskBoardController.currentItem.sortBy == ESorting.dateDesc) {
        filter.sorting = "${TaskDocGenerated.nameDate}-";
      }
      if (taskBoardController.currentItem.sortBy == ESorting.priorityAsc) {
        filter.sorting = "${TaskDocGenerated.namePriority}+";
      }
      if (taskBoardController.currentItem.sortBy == ESorting.priorityDesc) {
        filter.sorting = "${TaskDocGenerated.namePriority}-";
      }
      filter.compare.add(name: TaskDocGenerated.nameProjectId, value: projectController.currentItem.id);
    }
    filter.compare.add(name: TaskDocGenerated.nameTaskStatusId, value: status);

    //await NsgUserSettings.controller!.setSettingItem('taskF', filter.toString());
    //var test = NsgUserSettings.controller!.getSettingItem('taskF');
    return await tasks.requestItems(filter: filter);
  }

  ///Получение задач по статусу из БД. Если taskStatus == null, то загрузка будет происходить по currentTaskStatus
  getTasks(int top, int count, {TaskStatus? taskStatus}) async {
    taskStatus ??= currentTasksStatus;
    currentStatus = GetStatus<NsgBaseControllerData>.loading();
    sendNotify();
    currentStatusTasks = await _getTasksFromStatus(taskStatus, top, count);
    currentStatus = GetStatus<NsgBaseControllerData>.success(NsgBaseController.emptyData);
    sendNotify();
  }
}
