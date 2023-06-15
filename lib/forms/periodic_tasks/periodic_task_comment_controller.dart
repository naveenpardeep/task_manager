import 'package:get/get.dart';

import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_tasks_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class PeriodicTaskCommentsController extends NsgDataController<TaskComment> {
  PeriodicTaskCommentsController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<PeriodicTasksController>();
  }
  
 @override
  Future requestItems({List<NsgUpdateKey>? keys}) async {
    await super.requestItems(keys: keys);

    if (currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskComment;
    element.id = Guid.newGuid();
    element.ownerId = Get.find<PeriodicTasksController>().currentItem.id;

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var taskController = Get.find<PeriodicTasksController>();

    cmp.add(
        name: TaskCommentGenerated.nameOwnerId,
        value: taskController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }

}
