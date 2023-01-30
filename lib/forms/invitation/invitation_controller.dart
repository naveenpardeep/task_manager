import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/invitation.dart';

class InvitationController extends NsgDataController<Invitation> {
  InvitationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  // @override
  // Future<List<NsgDataItem>> doRequestItems() async {
  //   var dataController = Get.find<DataController>();
  //   var invitationController = Get.find<InvitationController>();
  //   var acceptInvitation = await dataController.respondToInvitation(
  //       invitationController.currentItem.id, true  , filter: getRequestFilter) ;
  //   return acceptInvitation;
  // }
}
