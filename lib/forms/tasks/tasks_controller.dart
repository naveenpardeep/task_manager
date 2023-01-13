import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

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
  Future itemRemove({bool goBack = true}) {
    return super.itemRemove();
  }

  @override
  Future<List<NsgDataItem>> doRequestItems() async {
    controllerFilter.isOpen = true;
    controllerFilter.isPeriodAllowed = true;
    controllerFilter.periodFieldName = TaskDocGenerated.nameDate;
    return super.doRequestItems();
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskDoc;
    element.id = Guid.newGuid();
    element.project = Get.find<ProjectController>().currentItem;
    element.date = DateTime.now();
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
