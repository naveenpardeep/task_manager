import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../project/project_controller.dart';

class UserAccountController extends NsgDataController<UserAccount> {
  UserAccountController()
      : super(
          requestOnInit: false,
          autoRepeate: true,
        );

  @override
  Future createAndSetSelectedItem() async {
    await super.createAndSetSelectedItem();
    await Get.find<UserImageController>().refreshData();
  }

  @override
  Future<bool> itemPagePost(
      {bool goBack = false, bool useValidation = false}) async {
    var imageController = Get.find<UserImageController>();
    //if (imageController.images.firstWhereOrNull((e) => e.id == '') != null) {
    await imageController.saveImages();
    //}
    return await super
        .itemPagePost(goBack: false, useValidation: useValidation);
  }

  @override
  Future setAndRefreshSelectedItem(
      NsgDataItem item, List<String>? referenceList) async {
    await super.setAndRefreshSelectedItem(item, referenceList);
    await Get.find<UserImageController>().refreshData();
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = super.getRequestFilter;
    var projectController = Get.find<ProjectController>();
    var ids = <String>[];
    if (projectController.currentItem.isNotEmpty) {
      filter.compare.add(
          name: UserAccountGenerated.nameOrganizationId,
          value: projectController.currentItem.organizationId);
      for (var row
          in projectController.currentItem.organization.tableUsers.rows) {
        ids.add(row.userAccountId);
      }

      // for (var row in projectController.currentItem.organization.tableUsers.rows
      //     .where((element) => element.isAdmin)) {
      //   ids.add(row.userAccountId);
      // }
      // for (var row in projectController.currentItem.tableUsers.rows) {
      //   ids.add(row.userAccountId);
      // }
    }
    return filter;
  }
}
