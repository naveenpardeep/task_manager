import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class TaskListController extends NsgDataController<TaskDoc> {
  TaskListController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      // TaskDocGenerated.nameSprintId,
      TaskDocGenerated.nameTaskStatusId,
      // TaskDocGenerated.nameAuthorId,
      TaskDocGenerated.nameAssigneeId,
      //  TaskDocGenerated.nameTableComments,
    //  TaskDocGenerated.nameCheckList,
      TaskDocGenerated.nameFiles
    ];
  }
  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = super.getRequestFilter;
    var serviceC = Get.find<ServiceObjectController>();

    if (serviceC.currentItem.projectId.isNotEmpty) {
      filter.compare.add(name: TaskDocGenerated.nameProjectId, value: serviceC.currentItem.projectId);
    }

    return filter;
  }
}
