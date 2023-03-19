import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/generated/project_item.g.dart';

import '../../model/project_item.dart';
import '../../model/project_item_user_table.dart';

class ProjectController extends NsgDataController<ProjectItem> {
  ProjectController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      ProjectItemGenerated.nameNumberOfTasksOpen,
      ProjectItemGenerated.nameOrganizationId,
      ProjectItemGenerated.nameLeaderId,
      ProjectItemGenerated.nameTableUsers,
    ];
  }

  //       @override
  // NsgDataRequestParams get getRequestFilter {
  //   var cmp = NsgCompare();
  //   var projectController = Get.find<ProjectController>();

  //   cmp.add(
  //       name: ProjectItemGenerated.nameName,
  //       value: projectController.currentItem.ownerId);

  //   return NsgDataRequestParams(compare: cmp);
  // }

  @override
  Future itemRemove({bool goBack = true}) {
    return super.itemRemove();
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as ProjectItem;

    // element.id = Guid.newGuid();

    element.id = Guid.newGuid();
    var orgController = Get.find<OrganizationController>();
    if (orgController.items.length == 1) {
      element.organization = orgController.firstItem;
      element.leader = Get.find<UserAccountController>().items.firstWhere((e) => e.organization == element.organization);
    }

    return element;
  }

  @override
  Future<ProjectItem> createNewItemAsync() async {
    var element = await super.createNewItemAsync();

    // element.date = DateTime.now();
    return element;
  }
}

class ProjectItemUserTableController extends NsgDataTableController<ProjectItemUserTable> {
  ProjectItemUserTableController()
      : super(
          masterController: Get.find<ProjectController>(),
          tableFieldName: ProjectItemGenerated.nameTableUsers,
        );

  List<ProjectItemUserTable> projectUsersList = [];
  // List<ProjectItemUserTable> projectUsersShowList = [];
  void prepapreProjectUsers() {
    projectUsersList.clear();
    //  projectUsersShowList.clear();
    //  for (var row in Get.find<ProjectController>().currentItem.tableUsers.rows) {
    //   var newRow = ProjectItemUserTable();
    //   newRow.userAccount = row.userAccount;
    //   newRow.isChecked = true;
    //   projectUsersShowList.add(newRow);
    // }

    for (var row in Get.find<ProjectUserController>().items) {
      if (projectUsersList.where((element) => element.userAccount == row).isNotEmpty) continue;

      var newRow = ProjectItemUserTable();
      newRow.userAccount = row;
      newRow.isChecked = false;
      projectUsersList.add(newRow);
    }
  }

  void usersSaved() {
    for (var userrow in projectUsersList) {
      var row = Get.find<ProjectController>().currentItem.tableUsers.rows.where((element) => element.userAccount == userrow.userAccount);
      if (row.isEmpty && userrow.isChecked == false) continue;
      if (row.isEmpty && userrow.isChecked == true) {
        Get.find<ProjectController>().currentItem.tableUsers.addRow(userrow);
      }

      if (row.isNotEmpty && userrow.isChecked == false) {
        Get.find<ProjectController>().currentItem.tableUsers.removeRow(row.first);
      }
    }
    Get.find<ProjectController>().itemPagePost();
  }
}
