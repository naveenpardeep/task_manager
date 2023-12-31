import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../app_pages.dart';
import '../forms/invitation/invitation_controller.dart';
import '../login/login_page.dart';
import '../login/registration_page.dart';
import '../login/verification_page.dart';
import 'generated/data_controller.g.dart';
import 'options/server_options.dart';

class DataController extends DataControllerGenerated {
  //NsgPushNotificationService? nsgFirebase;

  DataController() : super() {
    requestOnInit = false;
    autoRepeate = true;
    autoRepeateCount = 1000;
  }

  UserAccount currentUser = UserAccount();
  UserAccount mainProfile = UserAccount();

  @override
  Future onInit() async {
    if (provider == null) {
      provider = NsgDataProvider(applicationName: 'nsg_task_manager', firebaseToken: '', applicationVersion: '');
      //firebaseToken: nsgFirebase == null ? '' : nsgFirebase!.firebasetoken);
      provider!.getLoginWidget = (provider) => LoginPage(provider);
      provider!.getVerificationWidget = (provider) => VerificationPage(provider);
      provider!.getRegistrationWidget = (provider) => RegistrationPage(provider);
    }

    await super.onInit();
  }

  @override
  Future loadProviderData() async {
    await super.loadProviderData();

    //await Get.find<OrganizationController>().refreshData();
    await Get.find<UserAccountController>().refreshData();
    await Get.find<OrganizationController>().refreshData();
    isLoadFinished = true;
    gotoDone = false;
    NsgUserSettings.controller = NsgUserSettingsController<UserSettings>();
    await NsgUserSettings.controller!.requestItems();
    _gotoMainPage();
  }

  bool _animationFinished = false;
  void splashAnimationFinished() {
    _animationFinished = true;
    _gotoMainPage();
  }

  static String getFilePath(String fileName) {
    return '${NsgServerOptions.serverUriDataController}/Data/GetStream?path=$fileName';
  }

  bool isLoadFinished = false;
  bool gotoDone = false;
  Future _gotoMainPage() async {
    //provider!.logout();
    if (_animationFinished && isLoadFinished && status.isSuccess && !gotoDone) {
      gotoDone = true;
      var userC = Get.find<UserAccountController>();

      //Считаем, что у любого пользователя должен существовать как минимум один аккаунт
      //он создается на сервере автоматически при регистрации пользователя
      //отличается от всех остальных тем, что не задано поле "организация"
      if (userC.items.isEmpty) {
        await Get.find<DataController>().provider!.resetUserToken();
        await Get.find<DataController>().provider!.connect(Get.find<DataController>());
        return;
      }
      for (var profile in userC.items) {
        if (profile.organization.isEmpty) {
          mainProfile = profile;
        }
      }
      //mainProfile = userC.items.firstWhereOrNull((account) => account.organizationId.isEmpty)!;
      if (!mainProfile.isFilled) {
        //Если у пользователя есть только один аккаунт (основной), то значит он еще не создал
        //ни одной организации и не принял ни одного приглашения.
        //без выбора хотя бы одной организации, дальнейшее участие становится достаточно бесмысленным
        Get.toNamed(Routes.startPage);
      } else {
        await Get.find<InvitationController>().requestItems();
        if (Get.find<InvitationController>().items.isEmpty) {
          if (userC.items.length == 1) {
            Get.find<InvitationController>().itemNewPageOpen(Routes.acceptInvitationPage);
          } else {
            Get.find<ProjectController>().itemPageOpen(Get.find<ProjectController>().currentItem, Routes.projectListPage);
          }
        } else {
          Get.find<InvitationController>().itemNewPageOpen(Routes.acceptInvitationPage);
        }
      }
    }
  }
}
