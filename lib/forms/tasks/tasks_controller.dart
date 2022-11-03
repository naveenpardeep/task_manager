import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import 'task_image_controller.dart';

class TasksController extends NsgDataController<TaskDoc> {
  TasksController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      TaskDocGenerated.nameSprintId,
      TaskDocGenerated.nameTaskStatusId,
      TaskDocGenerated.nameAuthorId,
      TaskDocGenerated.nameAssigneeId
    ];
  }

  @override
  Future<TaskDoc> doCreateNewItem() async {
    var item = await super.doCreateNewItem();
    item.date = DateTime.now();
    return item;
  }

  @override
  Future itemPagePost({bool goBack = true}) async {
    var imageController = Get.find<TaskImageController>();
    if (imageController.images.firstWhereOrNull((e) => e.id == '') != null) {
      await imageController.saveImages();
    }
    await super.itemPagePost(goBack: goBack);
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
            tableFieldName: TaskDocGenerated.nameComments) {
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
