import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_control_options.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class ChatTaskListController extends NsgDataController<TaskDoc> {
  ChatTaskListController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      TaskDocGenerated.nameTaskStatusId,
      TaskDocGenerated.nameAssigneeId,
    ];
  }
  var totalcounttask = 100;
  var tasktop=0;
  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = super.getRequestFilter;
    filter.count = totalcounttask;
    filter.top=tasktop;

    filter.sorting = "${TaskDocGenerated.nameDateUpdated}-";
    return filter;
  }
}
