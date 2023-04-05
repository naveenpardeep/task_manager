import 'package:get/get.dart';

import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class NewTaskStatusController extends NsgDataController<TaskStatus> {
  NewTaskStatusController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<ProjectController>();
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskStatus;
    element.id = Guid.newGuid();
    element.project = Get.find<ProjectController>().currentItem;

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();

    var projectController = Get.find<ProjectController>();
     List status=[];
   status.add(projectController.items.where((element) => element.statusDone!=currentItem).toList());
    cmp.add(
      name: TaskStatusGenerated.nameProjectId,
      value: projectController.currentItem.id,
    );

    return NsgDataRequestParams(compare: cmp);
  }
}
