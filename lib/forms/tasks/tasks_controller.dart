import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';

import 'task_image_controller.dart';

class TasksController extends NsgDataController<TaskDoc> {
  TasksController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      // TaskDocGenerated.nameSprintId,
      TaskDocGenerated.nameTaskStatusId,
      // TaskDocGenerated.nameAuthorId,
      TaskDocGenerated.nameAssigneeId
    ];
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = NsgDataRequestParams();
    var projectController = Get.find<ProjectController>();
    var taskBoardController = Get.find<TaskBoardController>();
    // var cmp = NsgCompare();
    var finalTasks = NsgCompare();
    var notfinalTask = NsgCompare();
    List<String> notfinalStatusId = [];
    List<String> statusId = [];
    var selectFinalStatus = taskBoardController.currentItem.statusTable.rows
        .where((element) => element.status.isDone)
        .toList()
        .forEach((element) {
      statusId.add(element.statusId);
    });

    var notfinalStatus = taskBoardController.currentItem.statusTable.rows
        .where((element) => !element.status.isDone)
        .toList()
        .forEach((element) {
      notfinalStatusId.add(element.statusId);
    });
    notfinalTask.add(
        name: TaskDocGenerated.nameTaskStatusId,
        value: notfinalStatusId,
        comparisonOperator: NsgComparisonOperator.inList);
    finalTasks.add(
        name: TaskDocGenerated.nameDate,
        value: DateTime.now().add(Duration(days: -31)),
        comparisonOperator: NsgComparisonOperator.greater);
    finalTasks.add(
        name: TaskDocGenerated.nameTaskStatusId,
        value: statusId,
        comparisonOperator: NsgComparisonOperator.inList);

    var taskCondtion = NsgCompare();
    taskCondtion.logicalOperator = NsgLogicalOperator.or;
    taskCondtion.add(name: 'one', value: notfinalTask);

    taskCondtion.add(name: 'two', value: finalTasks);

    filter.compare.add(name: 'three', value: taskCondtion);

    var serviceC = Get.find<ServiceObjectController>();

    // Если указан ID пользователя, то фильтруем заявки по пользователю
    if (serviceC.currentItem.userAccountId.isNotEmpty) {
      filter.compare.add(
          name: TaskDocGenerated.nameAssigneeId,
          value: serviceC.currentItem.userAccountId);
    }

    if (projectController.currentItem.id != "") {
      if (taskBoardController.currentItem.sortBy == ESorting.dateAsc) {
        filter.compare.add(
            name: TaskDocGenerated.nameProjectId,
            value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.nameDate}+";
        //  sort = NsgSortingParam(
        //     parameterName: TaskDocGenerated.nameDate,
        //     direction: NsgSortingDirection.ascending);
        // return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      if (taskBoardController.currentItem.sortBy == ESorting.dateDesc) {
        filter.compare.add(
            name: TaskDocGenerated.nameProjectId,
            value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.nameDate}-";
        //  sort = NsgSortingParam(
        //     parameterName: TaskDocGenerated.nameDate,
        //     direction: NsgSortingDirection.descending);
        //  return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      if (taskBoardController.currentItem.sortBy == ESorting.priorityAsc) {
        filter.compare.add(
            name: TaskDocGenerated.nameProjectId,
            value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.namePriority}-";
        //  sort = NsgSortingParam(
        //     parameterName: TaskDocGenerated.namePriority,
        //     direction: NsgSortingDirection.ascending);
        //  return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      if (taskBoardController.currentItem.sortBy == ESorting.priorityDesc) {
        filter.compare.add(
            name: TaskDocGenerated.nameProjectId,
            value: projectController.currentItem.id);
        filter.sorting = "${TaskDocGenerated.namePriority}+";
        //filter.sorting=NsgSortingParam(
        //     parameterName: TaskDocGenerated.namePriority,
        //   direction: NsgSortingDirection.descending);
        //  return NsgDataRequestParams(compare: filter.compare, sorting: sort.toString());
      }
      filter.compare.add(
          name: TaskDocGenerated.nameProjectId,
          value: projectController.currentItem.id);
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
    element.dateDeadline = DateTime(2023, 01, 01);
    element.dateRemind = DateTime(2023, 01, 01);

    return element;
  }

  @override
  Future createAndSetSelectedItem() async {
    await super.createAndSetSelectedItem();
    await Get.find<TaskImageController>().refreshData();
  }

  @override
  Future<bool> itemPagePost(
      {bool goBack = false, bool useValidation = false}) async {
    var imageController = Get.find<TaskImageController>();
    //if (imageController.images.firstWhereOrNull((e) => e.id == '') != null) {
    await imageController.saveImages();
    //}
    return await super
        .itemPagePost(goBack: false, useValidation: useValidation);
  }

  @override
  Future setAndRefreshSelectedItem(
      NsgDataItem item, List<String>? referenceList) async {
    await super.setAndRefreshSelectedItem(item, referenceList);
    await Get.find<TaskImageController>().refreshData();
  }
}

class CommentTableTasksController
    extends NsgDataTableController<TaskDocCommentsTable> {
  CommentTableTasksController()
      : super(
            masterController: Get.find<TasksController>(),
            tableFieldName: TaskDocGenerated.nameTableComments) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }
  @override
  Future<TaskDocCommentsTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();
    item.date = DateTime.now();

    return item;
  }
}

class FilesTableTasksController
    extends NsgDataTableController<TaskDocFilesTable> {
  FilesTableTasksController()
      : super(
            masterController: Get.find<TasksController>(),
            tableFieldName: TaskDocGenerated.nameFiles) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }
  @override
  Future<TaskDocFilesTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();
    return item;
  }
}
