import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../project/project_controller.dart';

class UserRoleController extends NsgDataController<UserRole> {
  UserRoleController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<ProjectController>();
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as UserRole;
    element.ownerId = Get.find<ProjectController>().currentItem.id;

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var projectController = Get.find<ProjectController>();

    cmp.add(name: UserRoleGenerated.nameOwnerId, value: projectController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }
}
