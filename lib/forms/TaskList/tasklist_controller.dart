import 'package:nsg_data/nsg_data.dart';


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
      TaskDocGenerated.nameCheckList,
      TaskDocGenerated.nameFiles
    ];
  }

}