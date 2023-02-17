// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_controller.dart';
import 'package:task_manager_app/model/generated/project_item.g.dart';

import '../../model/project_item.dart';

class UserProjectNotificationController extends NsgDataController<ProjectItem> {
  UserProjectNotificationController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      ProjectItemGenerated.nameNumberOfTasksOpen,
      ProjectItemGenerated.nameOrganizationId,
      ProjectItemGenerated.nameLeaderId,
      ProjectItemGenerated.nameTableUsers,
    ];
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var userNotificationCon = Get.find<UserNotificationController>();
    var projCon = Get.find<ProjectController>();
    var ids = <ProjectItem>[];
    var proIds = <ProjectItem>[];
    for (var element in userNotificationCon.items) {
      proIds.add(element.project);
    }
    ids.addAll(projCon.items);
    ids.removeWhere((element) => proIds.contains(element));

    cmp.add(name: ProjectItemGenerated.nameId, value: ids, comparisonOperator: NsgComparisonOperator.inList);
    return NsgDataRequestParams(compare: cmp);
  }
}
