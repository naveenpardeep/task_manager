import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/invitation.dart';

class InvitationController extends NsgDataController<Invitation> {
  InvitationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  // @override
  // NsgDataRequestParams get getRequestFilter {
  //   var cmp = NsgCompare();
  //   var invitationController = Get.find<InvitationController>();

  //   List acceptedInvitaions = [];

  //   invitationController.items
  //       .where((element) => element.isAccepted)
  //       .toList()
  //       .forEach((element) {
  //     acceptedInvitaions.add(element.isAccepted);
  //   });

  //   cmp.add(name: InvitationGenerated.nameAuthorId, value: acceptedInvitaions);

  //   return NsgDataRequestParams(compare: cmp);
  // }
}
