import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
// ignore: depend_on_referenced_packages
import 'package:package_info_plus/package_info_plus.dart';
import '../_nsg_server_options.dart';
import '../data_controller_model.dart';

class DataControllerGenerated extends NsgBaseController {
  NsgDataProvider? provider;
  @override
  Future onInit() async {
    final info = await PackageInfo.fromPlatform();
    provider ??= NsgDataProvider(
        applicationName: 'task_manager_app',
        applicationVersion: info.version,
        firebaseToken: '');
    provider!.serverUri = NsgServerOptions.serverUriDataController;

    NsgDataClient.client
        .registerDataItem(ProjectItem(), remoteProvider: provider);
    NsgDataClient.client.registerDataItem(TaskDoc(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskDocCommentsTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskDocCheckListTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskStatus(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(ProjectDirections(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(SprintDoc(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(SprintDocTaskTable(), remoteProvider: provider);
    NsgDataClient.client.registerDataItem(Picture(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(UserAccount(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(UserSettings(), remoteProvider: provider);
    provider!.useNsgAuthorization = true;
    await provider!.connect(this);

    super.onInit();
  }

  @override
  Future loadProviderData() async {
    currentStatus = RxStatus.success();
    sendNotify();
  }
}
