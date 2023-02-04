import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class InvitationController extends NsgDataController<Invitation> {
  InvitationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
   var userC=Get.find<UserAccountController>();
    cmp.add(name: InvitationGenerated.nameIsAccepted, value: false);
    cmp.add(name: InvitationGenerated.nameIsRejected, value: false);
    cmp.add(name: InvitationGenerated.nameInvitedUserId, value: userC.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }
}
