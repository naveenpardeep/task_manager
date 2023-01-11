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

    return element;
  }

  @override
  Future<TaskDoc> createNewItemAsync() async {
    var dataitem = await super.createNewItemAsync();

    dataitem.date = DateTime.now();
    dataitem.dateDeadline=DateTime(2023,01,01);
    dataitem.dateRemind=DateTime(2023,01,01);
    return dataitem;
  }

  @override
  Future<bool> itemPagePost(
      {bool goBack = true, bool useValidation = false}) async {
   var imageController = Get.find<TaskImageController>();
   if (imageController.images.firstWhereOrNull((e) => e.id == '') != null) {
     await imageController.saveImages();
   }
    return await super
        .itemPagePost(goBack: goBack, useValidation: useValidation);
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
