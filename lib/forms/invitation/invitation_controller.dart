import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/invitation.dart';

class InvitationController extends NsgDataController<Invitation> {
  InvitationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();

    cmp.add(name: InvitationGenerated.nameIsAccepted, value: false);
    cmp.add(name: InvitationGenerated.nameIsRejected, value: false);
    return NsgDataRequestParams(compare: cmp);
  }
}
