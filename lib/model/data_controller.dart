import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../app_pages.dart';
import '../login/login_page.dart';
import '../login/verification_page.dart';
import 'generated/data_controller.g.dart';

class DataController extends DataControllerGenerated {
  //NsgPushNotificationService? nsgFirebase;

  DataController() : super() {
    requestOnInit = false;
    autoRepeate = true;
    autoRepeateCount = 1000;
  }

  @override
  Future onInit() async {
    if (provider == null) {
      provider = NsgDataProvider(
          applicationName: 'nsg_task_manager',
          firebaseToken: '',
          applicationVersion: '');
      //firebaseToken: nsgFirebase == null ? '' : nsgFirebase!.firebasetoken);
      provider!.getLoginWidget = (provider) => LoginPage(provider);
      provider!.getVerificationWidget =
          (provider) => VerificationPage(provider);
    }

    await super.onInit();
  }

  @override
  Future loadProviderData() async {
    await super.loadProviderData();
    await Get.find<OrganizationController>().refreshData();
    await Get.find<UserAccountController>().refreshData();
    isLoadFinished = true;
    _gotoMainPage();
  }

  bool _animationFinished = false;
  void splashAnimationFinished() {
    _animationFinished = true;
    _gotoMainPage();
  }

  bool isLoadFinished = false;
  bool gotoDone = false;
  void _gotoMainPage() {
    if (_animationFinished && isLoadFinished && status.isSuccess && !gotoDone) {
      gotoDone = true;
      var accController = Get.find<UserAccountController>();
      assert(accController.items.isNotEmpty);
      // if (accController.items
      //     .firstWhere((element) => element.firstName.isEmpty)
      //     .firstName
      //     .isEmpty) {
      //   Get.find<UserAccountController>().itemNewPageOpen(Routes.userAccount);
      // }
      var userAccount = accController.items.firstWhere(
          (e) => e.organization.isEmpty,
          orElse: () => accController.firstItem);
      if (userAccount.firstName.isEmpty) {
        Get.find<UserAccountController>()
            .itemPageOpen(userAccount, Routes.userAccount);
      } else {
        // Get.offAndToNamed(Routes.tasksListPage);
        //Get.offAndToNamed(Routes.homePage);
        // Get.offAndToNamed(Routes.taskStatusListPage);
        Get.offAndToNamed(Routes.projectListPage);
        //Get.offAndToNamed(Routes.userAccountListPage);
        //Get.offAndToNamed(Routes.invitationPage);
      }
    }
  }
}
