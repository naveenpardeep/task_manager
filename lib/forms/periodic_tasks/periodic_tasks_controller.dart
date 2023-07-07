import 'package:get/get.dart';

import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class PeriodicTasksController extends NsgDataController<TaskDoc> {
  PeriodicTasksController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      TaskDocGenerated.nameTaskStatusId,
      TaskDocGenerated.nameAssigneeId,
      TaskDocGenerated.nameIsPeriodic,
      TaskDocGenerated.nameCheckList
    ];
  }
  var transitionstatusList = <TaskStatus>[];
  @override
  Future<NsgDataItem> refreshItem(NsgDataItem item, List<String>? referenceList) async {
    var res = await super.refreshItem(item, referenceList) as TaskDoc;
    transitionstatusList = await Get.find<DataController>().getAccessibleStatuses(res.taskStatusId);

    return res;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = super.getRequestFilter;
    //  var cont= Get.find<PeriodicTasksController>();
    filter.params ??= <String, dynamic>{};
    // filter.compare.add(name: TaskDocGenerated.nameIsPeriodic, value: cont.currentItem.isPeriodic);
    filter.params!.addAll({'periodic': true});
    var serviceC = Get.find<ServiceObjectController>();
    if (serviceC.currentItem.sortTasksBy.isEmpty) {
      filter.sorting = "${TaskDocGenerated.nameDate}-";
    }
    if (serviceC.currentItem.projectId.isNotEmpty) {
      filter.compare.add(name: TaskDocGenerated.nameProjectId, value: serviceC.currentItem.projectId);
    }

    return filter;
  }
}

class PeriodicTaskCheckListController extends NsgDataTableController<TaskDocCheckListTable> {
  PeriodicTaskCheckListController() : super(masterController: Get.find<PeriodicTasksController>(), tableFieldName: TaskDocGenerated.nameCheckList) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys, NsgDataRequestParams? filter}) async {
    await super.requestItems(keys: keys);

    if (masterController!.selectedItem != null && currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<TaskDocCheckListTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();

    return item;
  }
}
