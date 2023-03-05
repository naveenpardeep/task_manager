import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../app_pages.dart';
import '../forms/invitation/invitation_controller.dart';
import '../login/login_page.dart';
import '../login/registration_page.dart';
import '../login/verification_page.dart';
import 'generated/data_controller.g.dart';
import 'user_account.dart';

class DataController extends DataControllerGenerated {
  //NsgPushNotificationService? nsgFirebase;

  DataController() : super() {
    requestOnInit = false;
    autoRepeate = true;
    autoRepeateCount = 1000;
  }

  UserAccount currentUser = UserAccount();

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

    //  await Get.find<OrganizationController>().refreshData();
    await Get.find<UserAccountController>().refreshData();
    await Get.find<OrganizationController>().refreshData();
    isLoadFinished = true;
    gotoDone = false;
    _gotoMainPage();
  }

  bool _animationFinished = false;
  void splashAnimationFinished() {
    _animationFinished = true;
    _gotoMainPage();
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
      if (userC.items.length == 1) {
        //Если у пользователя есть только один аккаунт (основной), то значит он еще не создал
        //ни одной организации и не принял ни одного приглашения.
        //без выбора хотя бы одной организации, дальнейшее участие становится достаточно бесмысленным

        if (userC.items.first.firstName.isEmpty ||
            userC.items.first.phoneNumber.isEmpty ||
            userC.items.first.lastName.isEmpty ||
            userC.items.first.email.isEmpty) {
          Get.toNamed(Routes.startPage);
        } else {
          await Get.find<InvitationController>().requestItems();
          Get.find<InvitationController>().itemNewPageOpen(Routes.acceptInvitationPage);
        }
      } else {
        // Get.offAndToNamed(Routes.tasksListPage);
        //Get.offAndToNamed(Routes.homePage);
        // Get.offAndToNamed(Routes.taskStatusListPage);
        //   Get.offAndToNamed(Routes.projectListPage);
        //Get.offAndToNamed(Routes.userAccountListPage);
        //Get.offAndToNamed(Routes.invitationPage);
        Get.find<ProjectController>().itemPageOpen(Get.find<ProjectController>().currentItem, Routes.projectListPage);
      }
    }
  }
}
