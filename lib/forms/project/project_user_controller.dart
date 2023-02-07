import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../project/project_controller.dart';

class ProjectUserController extends NsgDataController<UserAccount> {
  ProjectUserController()
      : super(
          requestOnInit: false,
          autoRepeate: true,
        );

 @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var userC = Get.find<UserAccountController>();
    var proItemuserCon = Get.find<ProjectItemUserTableController>();
    var ids = userC.items.removeWhere(
        (element) => element.id == proItemuserCon.currentItem.userAccountId);

    cmp.add(
        name: ProjectItemUserTableGenerated.nameUserAccountId,
        value: ids as ProjectItemUserTable,
        comparisonOperator: NsgComparisonOperator.inList);
    return NsgDataRequestParams(compare: cmp);
  }
  
}
