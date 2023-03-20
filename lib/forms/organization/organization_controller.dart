import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/generated/organization_item.g.dart';
import 'package:task_manager_app/model/organization_item.dart';
import 'package:task_manager_app/model/organization_item_user_table.dart';

class OrganizationController extends NsgDataController<OrganizationItem> {
  OrganizationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      OrganizationItemGenerated.nameId,
      OrganizationItemGenerated.nameName,
      OrganizationItemGenerated.nameTableUsers
    ];
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem();

    element.id = Guid.newGuid();

    return element;
  }

  @override
  Future<OrganizationItem> createNewItemAsync() async {
    var element = await super.createNewItemAsync();
    return element;
  }
}

class OrganizationItemUserTableController
    extends NsgDataTableController<OrganizationItemUserTable> {
  OrganizationItemUserTableController()
      : super(
          masterController: Get.find<OrganizationController>(),
          tableFieldName: OrganizationItemGenerated.nameTableUsers,
        );



         List<OrganizationItemUserTable> orgUsersList = [];
  void prepapreOrgUsers() {
    orgUsersList.clear();
    // for (var row in Get.find<OrganizationController>().currentItem.tableUsers.rows) {
    //   var newRow = OrganizationItemUserTable();
    //   newRow.userAccount = row.userAccount;
    //   newRow.isChecked = true;
    //   orgUsersList.add(newRow);
    // }

    for (var row in Get.find<UserAccountController>().items) {
      if (orgUsersList.where((element) => element.userAccount == row).isNotEmpty) continue;

      var newRow = OrganizationItemUserTable();
      newRow.userAccount = row;
      newRow.isChecked = false;
      orgUsersList.add(newRow);
    }
  }

  void usersSaved() {
    for (var userrow in orgUsersList) {
      var row = Get.find<OrganizationController>().currentItem.tableUsers.rows.where((element) => element.userAccount == userrow.userAccount);
      if (row.isEmpty && userrow.isChecked == false) continue;
      if (row.isEmpty && userrow.isChecked == true) {
        Get.find<OrganizationController>().currentItem.tableUsers.addRow(userrow);
      }

      if (row.isNotEmpty && userrow.isChecked == false) {
        Get.find<OrganizationController>().currentItem.tableUsers.removeRow(row.first);
      }
    }
    Get.find<OrganizationController>().itemPagePost(goBack: false);
  }
}
