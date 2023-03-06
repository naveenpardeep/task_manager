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
    var projCon = Get.find<ProjectController>();
    var ids = <UserAccount>[];
    var proIds = <UserAccount>[];
    for (var element in proItemuserCon.items) {
      proIds.add(element.userAccount);
    }
    ids.addAll(userC.items.where(
        (element) => element.organization == projCon.currentItem.organization));
    ids.removeWhere((element) => proIds.contains(element));

    cmp.add(
        name: UserAccountGenerated.nameId,
        value: ids,
        comparisonOperator: NsgComparisonOperator.inList);
    return NsgDataRequestParams(compare: cmp);
  }
 @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem();
    element.id = Guid.newGuid();
  

    return element;
  }
  
}
