import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';


class UserNotificationNewTaskController extends NsgDataController<UserNotificationSettings> {
  UserNotificationNewTaskController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem();

    // element.id = Guid.newGuid();

    element.id = Guid.newGuid();

    return element;
  }

 
}


class UserNotificationSettingStatusTableController
    extends NsgDataTableController<UserNotificationSettingsStatusTable> {
  UserNotificationSettingStatusTableController()
      : super(
          masterController: Get.find<UserNotificationNewTaskController>(),
          tableFieldName: UserNotificationSettingsGenerated.nameStatusTable,
        );
        }