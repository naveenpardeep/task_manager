import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class UserNotificationController
    extends NsgDataController<UserNotificationSettings> {
  UserNotificationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();

    var userController = Get.find<UserAccountController>();

    cmp.add(
        name: UserNotificationSettingsGenerated.nameUserAccountId,
        value: userController.currentItem.id);
  
    return NsgDataRequestParams(compare: cmp);
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem();

    element.id = Guid.newGuid();

    return element;
  }

  @override
  Future<UserNotificationSettings> createNewItemAsync() async {
    var element = await super.createNewItemAsync();

    return element;
  }
}

class UserNotificationSettingStatusTableController
    extends NsgDataTableController<UserNotificationSettingsStatusTable> {
  UserNotificationSettingStatusTableController()
      : super(
          masterController: Get.find<UserNotificationController>(),
          tableFieldName: UserNotificationSettingsGenerated.nameStatusTable,
        );
}
