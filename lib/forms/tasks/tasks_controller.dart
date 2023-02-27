import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_error_widget.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';

import 'task_image_controller.dart';

class TasksController extends NsgDataController<TaskDoc> {
  TasksController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      // TaskDocGenerated.nameSprintId,
      TaskDocGenerated.nameTaskStatusId,
      // TaskDocGenerated.nameAuthorId,
      TaskDocGenerated.nameAssigneeId,
      //  TaskDocGenerated.nameTableComments,
      //  TaskDocGenerated.nameCheckList,
      //  TaskDocGenerated.nameFiles
    ];
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
          name: TaskDocGenerated.nameDate, value: DateTime.now().add(const Duration(days: -1)), comparisonOperator: NsgComparisonOperator.greaterOrEqual);
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
          name: TaskDocGenerated.nameDate, value: DateTime.now().add(const Duration(days: -7)), comparisonOperator: NsgComparisonOperator.greaterOrEqual);
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
          name: TaskDocGenerated.nameDate, value: DateTime.now().add(const Duration(days: -31)), comparisonOperator: NsgComparisonOperator.greaterOrEqual);
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
          name: TaskDocGenerated.nameDate, value: DateTime.now().add(const Duration(days: -365)), comparisonOperator: NsgComparisonOperator.greaterOrEqual);
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
      filter.compare.add(name: TaskDocGenerated.nameAssigneeId, value: serviceC.currentItem.userAccountId);
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
  Future<bool> itemPagePost({bool goBack = false, bool useValidation = false}) async {
    var imageController = Get.find<TaskImageController>();
    //if (imageController.images.firstWhereOrNull((e) => e.id == '') != null) {
    await imageController.checkImagesInRichText();
    await imageController.saveImages();
    //}
    return await super.itemPagePost(goBack: false, useValidation: useValidation);
  }

  @override
  Future setAndRefreshSelectedItem(NsgDataItem item, List<String>? referenceList) async {
    await super.setAndRefreshSelectedItem(item, referenceList);
    await Get.find<TaskImageController>().refreshData();
  }
}

class CommentTableTasksController extends NsgDataTableController<TaskDocCommentsTable> {
  CommentTableTasksController() : super(masterController: Get.find<TasksController>(), tableFieldName: TaskDocGenerated.nameTableComments) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys}) async {
    await super.requestItems(keys: keys);

    if (masterController!.selectedItem != null && currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<TaskDocCommentsTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();
    item.date = DateTime.now();
    return item;
  }
}

class TaskCheckListController extends NsgDataTableController<TaskDocCheckListTable> {
  TaskCheckListController() : super(masterController: Get.find<TasksController>(), tableFieldName: TaskDocGenerated.nameCheckList) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys}) async {
    await super.requestItems(keys: keys);

    if (masterController!.selectedItem != null && currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<TaskDocCheckListTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();

    return item;
  }
}

class TaskFilesController extends NsgDataTableController<TaskDocFilesTable> {
  TaskFilesController() : super(masterController: Get.find<TasksController>(), tableFieldName: TaskDocGenerated.nameFiles) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }
  var files = <NsgFilePickerObject>[];

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var taskController = Get.find<TasksController>();

    cmp.add(name: TaskDocFilesTableGenerated.nameOwnerId, value: taskController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }

  Future<bool> saveFiles() async {
    var progress = NsgProgressDialog(textDialog: 'Сохранение File');
    progress.show();
    var ids = <String>[];
    try {
      for (var file in files) {
        if (file.file == null) continue;
        if (file.id == '') {
          var filename = TaskDocFilesTable();
          filename.name = filename.name;
          filename.ownerId = Get.find<TasksController>().currentItem.id;

          if (kIsWeb) {
            File filesupload = File.fromUri(Uri(path: file.filePath));
            filename.file = await filesupload.readAsBytes();
          } else {
            File filesUpload = File(file.filePath);
            filename.file = await filesUpload.readAsBytes();
          }
          await filename.post();
        }
        ids.add(file.id);
      }

      var itemsToDelete = items.where((e) => !ids.contains(e.id)).toList();
      if (itemsToDelete.isNotEmpty) {
        deleteItems(itemsToDelete);
      }
      progress.hide();
    } on Exception catch (ex) {
      progress.hide();
      NsgErrorWidget.showError(ex);
      rethrow;
    }
    return true;
  }

  @override
  Future refreshData({List<NsgUpdateKey>? keys}) async {
    await super.refreshData(keys: keys);
    files.clear();

    for (var element in items) {
      files.add(NsgFilePickerObject(
          isNew: false,
          file: File.fromRawPath(Uint8List.fromList(element.file)),
          image: Image.memory(Uint8List.fromList(element.file)),
          description: element.name,
          fileType: 'jpg',
          //  fileType: extension(File.fromRawPath(Uint8List.fromList(element.file)) as String).replaceAll('.', ''),
          id: element.id));
    }
    return;
  }
}
