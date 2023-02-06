import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/task_board.dart';

import '../../model/generated/task_board.g.dart';

import '../project/project_controller.dart';

class TaskBoardController extends NsgDataController<TaskBoard> {
  TaskBoardController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<ProjectController>();
  }
  
  @override
  Future afterRequestItems(List<NsgDataItem> newItemsList) async {
   if (!newItemsList.contains(currentItem) && newItemsList.isNotEmpty) {
      currentItem = newItemsList.first as TaskBoard;
   }
     Get.find<TasksController>().refreshData();
     Get.find<ProjectController>().sendNotify();
    return await super.afterRequestItems(newItemsList);
    
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskBoard;
    element.id = Guid.newGuid();
    element.project = Get.find<ProjectController>().currentItem;

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var projectController = Get.find<ProjectController>();

    cmp.add(
        name: TaskBoardGenerated.nameProjectId,
        value: projectController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }

}
