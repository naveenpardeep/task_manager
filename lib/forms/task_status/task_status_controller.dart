import 'package:get/get.dart';

import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class TaskStatusController extends NsgDataController<TaskStatus> {
  TaskStatusController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<ProjectController>();
  }
//  @override
//   Future<TaskStatus> createNewItemAsync() {
//
//     var item=super.createNewItemAsync() as TaskStatus;
//     item.name=Guid.newGuid();
//     return item;
//   }

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
    var taskStatusController = Get.find<TaskBoardController>();

    cmp.add(
        //  name: TaskStatusGenerated.nameProjectId,
        // value: projectController.currentItem.id);
        name: TaskStatusGenerated.nameProjectId,
        value: taskStatusController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);

    // var filter = super.getRequestFilter;
    // var projectController = Get.find<ProjectController>();
    // filter.compare.add(
    //     name: TaskStatusGenerated.nameId,
    //     value: projectController.currentItem.id);
    // return filter;
  }
}

class TaskStatusTableController
    extends NsgDataTableController<TaskBoardStatusTable> {
  TaskStatusTableController()
      : super(
          masterController: Get.find<TaskBoardController>(),
          tableFieldName: TaskBoardGenerated.nameStatusTable,
        );
  @override
  Future itemRemove({bool goBack = true}) {
    return super.itemRemove();
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
