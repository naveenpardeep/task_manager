import 'package:get/get.dart';

import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';
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
    if (taskStatusController.currentItem.isNotEmpty) {
      var projectStatuses = <String>[];
      for (var e in taskStatusController.currentItem.statusTable.rows) {
        projectStatuses.add(e.statusId);
      }

      cmp.add(
          //  name: TaskStatusGenerated.nameProjectId,
          //value: projectController.currentItem.id);
          name: TaskStatusGenerated.nameId,
          value: projectStatuses,
          comparisonOperator: NsgComparisonOperator.inList);
    }
else{
   cmp.add(
           name: TaskStatusGenerated.nameProjectId,
          value: projectController.currentItem.id);
         // name: TaskStatusGenerated.nameId,
         // value: projectStatuses,
         // comparisonOperator: NsgComparisonOperator.inList);
}
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
  List<TaskBoardStatusTable> taskboardstatus=[];
  void prepapreProjectStatus(){
    taskboardstatus.clear();
    for(var row in Get.find<TaskBoardController>().currentItem.statusTable.rows){
      var newRow= TaskBoardStatusTable();
      newRow.status=row.status;
      newRow.isChecked=true;
      taskboardstatus.add(newRow);
    }

    for(var row in Get.find<ProjectStatusController>().items){
      if(taskboardstatus.where((element) => element.status==row).isNotEmpty) continue;

      var newRow= TaskBoardStatusTable();
      newRow.status=row;
      newRow.isChecked=false;
      taskboardstatus.add(newRow);
    }
   
  }
  void statusSaved(){
    for(var statusrow in taskboardstatus){
     var row=  Get.find<TaskBoardController>().currentItem.statusTable.rows.where((element) => element.status==statusrow.status);
     if(row.isEmpty&& statusrow.isChecked==false) continue;
     if(row.isEmpty&& statusrow.isChecked==true){
      Get.find<TaskBoardController>().currentItem.statusTable.addRow(statusrow);
      Get.find<TaskBoardController>().itemPagePost(goBack: false);
     }

     if(row.isNotEmpty&& statusrow.isChecked==false){
      Get.find<TaskBoardController>().currentItem.statusTable.removeRow(row.first);
        Get.find<TaskBoardController>().itemPagePost(goBack: false);
     }
    }
  }

  // @override
  // NsgDataRequestParams get getRequestFilter {
  //   var cmp = NsgCompare();
  //   var projectController = Get.find<ProjectController>();
  //       var taskStatusController = Get.find<TaskBoardController>();
  //    var projectStatuses = <String>[];
  //   for (var e in taskStatusController.currentItem.statusTable.rows) {
  //     projectStatuses.add(e.statusId);
  //   }

  //   cmp.add(
  //    //  name: TaskBoardGenerated.nameProjectId,
  //      // value: projectController.currentItem.id);
  //         name: TaskStatusGenerated.nameId,
  //      value: projectStatuses,
  //     comparisonOperator: NsgComparisonOperator.inList);
  //   return NsgDataRequestParams(compare: cmp);
  // }
}
