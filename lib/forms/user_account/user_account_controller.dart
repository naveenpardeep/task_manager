import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class UserAccountController extends NsgDataController<UserAccount> {
  UserAccountController()
      : super(requestOnInit: false, autoRepeate: true,);
}
