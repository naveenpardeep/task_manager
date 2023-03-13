import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
// ignore: depend_on_referenced_packages
import 'package:package_info_plus/package_info_plus.dart';
import '../options/server_options.dart';
import '../enums.dart';
import '../data_controller_model.dart';

class DataControllerGenerated extends NsgBaseController {
  NsgDataProvider? provider;
  @override
  Future onInit() async {
    final info = await PackageInfo.fromPlatform();
    NsgMetrica.activate();
    NsgMetrica.reportAppStart();
    provider ??= NsgDataProvider(applicationName: 'task_manager_app', applicationVersion: info.version, firebaseToken: '');
    provider!.serverUri = NsgServerOptions.serverUriDataController;

    NsgDataClient.client
        .registerDataItem(ProjectItem(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(ProjectItemUserTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskDoc(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskDocCommentsTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskDocCheckListTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskDocFilesTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskStatus(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskStatusTransitionTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskBoard(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(TaskBoardStatusTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(ProjectDirections(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(SprintDoc(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(SprintDocTaskTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(Invitation(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(NotificationDoc(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(Picture(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(OrganizationItem(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(OrganizationItemUserTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(UserNotificationSettings(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(UserNotificationSettingsStatusTable(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(UserAccount(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(UserSettings(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(ServiceObject(), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(EPriority(0, ''), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(ENotificationType(0, ''), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(ESorting(0, ''), remoteProvider: provider);
    NsgDataClient.client
        .registerDataItem(EPeriod(0, ''), remoteProvider: provider);
    await NsgLocalDb.instance.init(provider!.applicationName);
    provider!.useNsgAuthorization = true;
    var db = NsgLocalDb.instance;
    await db.init('task_manager_app');
    await provider!.connect(this);

    super.onInit();
  }

  @override
  Future loadProviderData() async {
    currentStatus = GetStatus.success(NsgBaseController.emptyData);
    sendNotify();
  }

  /// Ответить на приглашение
  Future<List<String>> respondToInvitation(String invitationId, bool accept, {NsgDataRequestParams? filter, bool showProgress = false, bool isStoppable = false, String? textDialog}) async {
    var progress = NsgProgressDialogHelper(showProgress: showProgress, isStoppable: isStoppable, textDialog: textDialog);
    try {
      var params = <String, dynamic>{};
      params['invitationId'] = invitationId;
      params['accept'] = accept.toString();
      filter ??= NsgDataRequestParams();
      filter.params?.addAll(params);
      filter.params ??= params;
      var res = await NsgSimpleRequest<String>().requestItems(
          provider: provider!,
          function: '/Data/RespondToInvitation',
          method: 'POST',
          filter: filter,
          autoRepeate: true,
          autoRepeateCount: 3,
          cancelToken: progress.cancelToken);
      return res;
    } finally {
      progress.hide();
    }
  }

  /// Дата последнего редактирования задачи по проекту
  Future<List<DateTime>> getLastTaskEditedByProject(String projectId, {NsgDataRequestParams? filter, bool showProgress = false, bool isStoppable = false, String? textDialog}) async {
    var progress = NsgProgressDialogHelper(showProgress: showProgress, isStoppable: isStoppable, textDialog: textDialog);
    try {
      var params = <String, dynamic>{};
      params['projectId'] = projectId;
      filter ??= NsgDataRequestParams();
      filter.params?.addAll(params);
      filter.params ??= params;
      var res = await NsgSimpleRequest<DateTime>().requestItems(
          provider: provider!,
          function: '/Data/GetLastTaskEditedByProject',
          method: 'POST',
          filter: filter,
          autoRepeate: true,
          autoRepeateCount: 3,
          cancelToken: progress.cancelToken);
      return res;
    } finally {
      progress.hide();
    }
  }
}
