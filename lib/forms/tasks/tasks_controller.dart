import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import 'task_image_controller.dart';

class TasksController extends NsgDataController<TaskDoc> {
  TasksController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
    //  TaskDocGenerated.nameProjectId,
      // TaskDocGenerated.nameSprintId,
      TaskDocGenerated.nameTaskStatusId,
      // TaskDocGenerated.nameAuthorId,
      TaskDocGenerated.nameAssigneeId
    ];
  }


  @override
  Future<TaskDoc> createNewItemAsync() async {
    var dataitem = await super.createNewItemAsync();

    dataitem.date = DateTime.now();
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
