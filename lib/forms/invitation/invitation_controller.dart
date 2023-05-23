import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../../model/data_controller.dart';

class InvitationController extends NsgDataController<Invitation> {
  InvitationController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    cmp.add(name: InvitationGenerated.nameIsAccepted, value: false);
    cmp.add(name: InvitationGenerated.nameIsRejected, value: false);
    var user = Get.find<DataController>().currentUser;
    var cmpOr = NsgCompare();
    cmpOr.logicalOperator = NsgLogicalOperator.or;
    cmpOr.add(name: InvitationGenerated.nameInvitedUserId, value: user);
    cmpOr.add(name: '${InvitationGenerated.nameInvitedUserId}.${UserAccountGenerated.nameMainUserAccountId}', value: user);
    cmp.add(name: '', value: cmpOr);
    return NsgDataRequestParams(compare: cmp);
  }
}
