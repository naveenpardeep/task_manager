import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class TaskStatusController extends NsgDataController<TaskStatus> {
  TaskStatusController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);
      
       @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var projectController = Get.find<ProjectController>();

    cmp.add(
        name: TaskStatusGenerated.nameProjectId,
        value: projectController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);

    // var filter = super.getRequestFilter;
    // var projectController = Get.find<ProjectController>();
    // filter.compare.add(
    //     name: TaskStatusGenerated.nameId,
    //     value: projectController.currentItem.id);
    // return filter;
  }
}
