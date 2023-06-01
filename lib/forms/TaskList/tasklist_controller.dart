import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_control_options.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums/e_sorting.dart';

class TaskListController extends NsgDataController<TaskDoc> {
  TaskListController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      TaskDocGenerated.nameTaskStatusId,
      TaskDocGenerated.nameAssigneeId,
     
    ];
  }
  var totalcounttask = 100;
  int currentPage = 0;

  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = super.getRequestFilter;
    filter.count = totalcounttask;

    var serviceC = Get.find<ServiceObjectController>();
   // filter.sorting = "${TaskDocGenerated.nameDate}-";
    if (serviceC.currentItem.projectId.isNotEmpty) {
      filter.compare.add(name: TaskDocGenerated.nameProjectId, value: serviceC.currentItem.projectId);
    }
   
    if (serviceC.currentItem.userAccountId.isNotEmpty) {
      filter.compare.add(name: '${TaskDocGenerated.nameAssigneeId}.${UserAccountGenerated.nameMainUserAccountId}', value: serviceC.currentItem.userAccount.mainUserAccountId);
    }
    if (serviceC.currentItem.taskTypeId.isNotEmpty) {
      filter.compare.add(name: TaskDocGenerated.nameTaskTypeId, value: serviceC.currentItem.taskTypeId);
    }    
    if (serviceC.currentItem.sortTasksBy == ESorting.dateAsc) {
        filter.sorting = "${TaskDocGenerated.nameDate}+";
      }
      if (serviceC.currentItem.sortTasksBy == ESorting.dateDesc) {
        filter.sorting = "${TaskDocGenerated.nameDate}-";
      }
      if (serviceC.currentItem.sortTasksBy == ESorting.priorityAsc) {
        filter.sorting = "${TaskDocGenerated.namePriority}+";
      }
      if (serviceC.currentItem.sortTasksBy == ESorting.priorityDesc) {
        filter.sorting = "${TaskDocGenerated.namePriority}-";
      }
   
    
    return filter;
  }

  Widget pagination() {
    List<Widget> list = [];

    int pagesCount = totalCount! ~/ totalcounttask;
    int startPage = pagesCount > 10 && currentPage > 5 ? currentPage - 5 : 0;
    int count = 0;
    for (var i = startPage; i <= pagesCount; i++) {
      list.add(
        InkWell(
          onTap: () async {
            currentPage = i;
            top = currentPage * totalcounttask;
            //    pageScrollController.jumpTo(0);
            await refreshData();
          },
          child: Container(
            width: 40,
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(color: currentPage != i ? Colors.transparent : ControlOptions.instance.colorMain, borderRadius: BorderRadius.circular(3)),
            child: Center(
              child: Text(
                (i + 1).toString(),
                style: TextStyle(
                    color: currentPage != i ? ControlOptions.instance.colorText : ControlOptions.instance.colorMainText,
                    fontSize: ControlOptions.instance.sizeXL),
              ),
            ),
          ),
        ),
      );
      if (count++ > 8) {
        break;
      }
    }
    return pagesCount <= 1
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    prevDataPage();
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.keyboard_arrow_left),
                  ),
                ),
                Row(
                  children: list,
                ),
                InkWell(
                  onTap: () {
                    nextDataPage();
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ],
            ),
          );
  }

  void prevDataPage() async {
    totalCount ??= 0;
    if (totalCount! <= totalcounttask) return;
    if (currentPage == 0) return;
    currentPage--;
    top = currentPage * totalcounttask;
    // pageScrollController.jumpTo(0);
    await refreshData();
  }

  void nextDataPage() async {
    totalCount ??= 0;
    if (totalCount! <= totalcounttask) return;
    var totalPages = (totalCount! / totalcounttask).ceil();
    if (currentPage >= totalPages) return;
    currentPage++;
    top = currentPage * totalcounttask;
    // pageScrollController.jumpTo(0);
    await refreshData();
  }

  
}

class TasklistTaskCheckListController extends NsgDataTableController<TaskDocCheckListTable> {
  TasklistTaskCheckListController() : super(masterController: Get.find<TaskListController>(), tableFieldName: TaskDocGenerated.nameCheckList) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys}) async {
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
