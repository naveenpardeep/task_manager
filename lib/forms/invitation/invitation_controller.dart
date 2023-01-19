import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/invitation.dart';

class InvitationController extends NsgDataController<Invitation> {
  InvitationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);
}
