import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../project/project_controller.dart';

class TaskUserAccountController extends NsgDataController<UserAccount> {
  TaskUserAccountController()
      : super(
          requestOnInit: false,
          autoRepeate: true,
        );

  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = super.getRequestFilter;
    var projectController = Get.find<ProjectController>();
    var ids = <String>[];
    if (projectController.currentItem.isNotEmpty) {
      filter.compare.add(name: UserAccountGenerated.nameOrganizationId, value: projectController.currentItem.organizationId);

      for (var row in projectController.currentItem.organization.tableUsers.rows.where((element) => element.isAdmin)) {
        ids.add(row.userAccountId);
      }
      for (var row in projectController.currentItem.tableUsers.rows) {
        ids.add(row.userAccountId);
      }
    }
    return filter;
  }
}
