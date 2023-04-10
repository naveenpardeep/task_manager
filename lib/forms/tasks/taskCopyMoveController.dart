import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/new_task_status_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';

import 'task_file_controller.dart';

class TaskCopyMoveController extends NsgDataController<TaskDoc> {
  TaskCopyMoveController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      // TaskDocGenerated.nameSprintId,
      TaskDocGenerated.nameTaskStatusId,
      // TaskDocGenerated.nameAuthorId,
      TaskDocGenerated.nameAssigneeId,
      //  TaskDocGenerated.nameTableComments,
      TaskDocGenerated.nameCheckList,
      TaskDocGenerated.nameFiles
    ];
  }

  Future<List<TaskDoc>> getTasksFromStatus(TaskStatus status, int top, int count) async {
    var tasks = NsgDataRequest<TaskDoc>(dataItemType: TaskDoc);
    var filter = NsgDataRequestParams(top: top, count: count);
    filter.compare.add(name: TaskDocGenerated.nameTaskStatusId, value: status);
    return await tasks.requestItems(filter: filter);
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = NsgDataRequestParams();
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
    // notfinalTask.add(
    //     name: TaskDocGenerated.nameTaskStatusId,
    //     value: notfinalStatusId,
    //     comparisonOperator: NsgComparisonOperator.inList);
    // finalTasks.add(
    //     name: TaskDocGenerated.nameDate,
    //     value: DateTime.now().add(const Duration(days: -31)),
    //     comparisonOperator: NsgComparisonOperator.greater);
    // finalTasks.add(
    //     name: TaskDocGenerated.nameTaskStatusId,
    //     value: statusId,
    //     comparisonOperator: NsgComparisonOperator.inList);

    // var taskCondtion = NsgCompare();
    // taskCondtion.logicalOperator = NsgLogicalOperator.or;
    // taskCondtion.add(name: 'one', value: notfinalTask);

    // taskCondtion.add(name: 'two', value: finalTasks);

    // filter.compare.add(name: 'three', value: taskCondtion);

    //finished tasks filter
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
      // finalTasks.add(
      //     name: TaskDocGenerated.nameDate,
      //     value: DateTime.now().add(const Duration(days: -9999)),
      //     comparisonOperator: NsgComparisonOperator.greaterOrEqual);
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
      filter.compare.add(name: TaskDocGenerated.nameAssigneeId + '.' + UserAccountGenerated.nameMainUserAccountId, value: serviceC.currentItem.userAccountId);
    }
    if (projectController.currentItem.id != "") {
      if (taskBoardController.currentItem.sortBy == ESorting.dateAsc) {
        filter.compare.add(name: TaskDocGenerated.nameProjectId, value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.nameDate}+";
        //  sort = NsgSortingParam(
        //     parameterName: TaskDocGenerated.nameDate,
        //     direction: NsgSortingDirection.ascending);
        // return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      if (taskBoardController.currentItem.sortBy == ESorting.dateDesc) {
        filter.compare.add(name: TaskDocGenerated.nameProjectId, value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.nameDate}-";
        //  sort = NsgSortingParam(
        //     parameterName: TaskDocGenerated.nameDate,
        //     direction: NsgSortingDirection.descending);
        //  return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      if (taskBoardController.currentItem.sortBy == ESorting.priorityAsc) {
        filter.compare.add(name: TaskDocGenerated.nameProjectId, value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.namePriority}+";
        //  sort = NsgSortingParam(
        //     parameterName: TaskDocGenerated.namePriority,
        //     direction: NsgSortingDirection.ascending);
        //  return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      if (taskBoardController.currentItem.sortBy == ESorting.priorityDesc) {
        filter.compare.add(name: TaskDocGenerated.nameProjectId, value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.namePriority}-";
        //filter.sorting=NsgSortingParam(
        //     parameterName: TaskDocGenerated.namePriority,
        //   direction: NsgSortingDirection.descending);
        //  return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      filter.compare.add(name: TaskDocGenerated.nameProjectId, value: projectController.currentItem.id);
    }
    return filter;
    // return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
    // return NsgDataRequestParams(compare: filter.compare);
  }

  @override
  Future itemRemove({bool goBack = true}) {
    return super.itemRemove();
  }

  // @override
  // Future<List<NsgDataItem>> doRequestItems() async {
  //   controllerFilter.isOpen = true;
  //   controllerFilter.isPeriodAllowed = true;
  //   controllerFilter.periodFieldName = TaskDocGenerated.nameDate;
  //   return super.doRequestItems();
  // }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskDoc;
    element.id = Guid.newGuid();
    element.project = Get.find<ProjectController>().currentItem;
    element.date = DateTime.now();
    element.dateUpdated = DateTime.now();
    element.taskStatus = Get.find<TaskBoardController>().currentItem.statusTable.rows.first.status;

    return element;
  }

  @override
  Future createAndSetSelectedItem() async {
    await super.createAndSetSelectedItem();
  }

  @override
  Future<bool> itemPagePost({bool goBack = false, bool useValidation = false}) async {
    var imageController = Get.find<TaskFilesController>();
    //if (imageController.images.firstWhereOrNull((e) => e.id == '') != null) {
    await imageController.checkImagesInRichText();
   // await imageController.saveImages();
    //}
    return await super.itemPagePost(goBack: false, useValidation: useValidation);
  }

  // @override
  // Future setAndRefreshSelectedItem(NsgDataItem item, List<String>? referenceList) async {
  //   await super.setAndRefreshSelectedItem(item, referenceList);
  //   //Обновление подчиненных контроллеров происходит автоматически при смене текущей строки
  //   //await Get.find<TaskFilesController>().refreshData();
  // }
}



