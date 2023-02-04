import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class AccpetController extends NsgDataController<Invitation> {
  AccpetController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
  var userC=Get.find<UserAccountController>();
    cmp.add(
        name: InvitationGenerated.nameAuthorId, value: userC.items,comparisonOperator: NsgComparisonOperator.inList);
    return NsgDataRequestParams(compare: cmp);
  }
}
