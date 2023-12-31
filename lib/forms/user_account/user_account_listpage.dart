import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/controllers/nsg_controller_regime.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/top_menu.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';

class UserAccountListPage extends GetView<UserAccountController> {
  const UserAccountListPage({Key? key}) : super(key: key);

  final _elementPage = Routes.createInvitationUser;

  @override
  Widget build(BuildContext context) {
    return BodyWrap(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          var width = constraints.maxWidth;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Get.find<UserAccountController>().regime != NsgControllerRegime.selection && width > 700) const TmTopMenu(),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Text(
                  Get.find<UserAccountController>().regime != NsgControllerRegime.selection ? 'Все пользователи' : 'Выберите пользователя',
                  style: TextStyle(fontSize: ControlOptions.instance.sizeXL),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: NsgListPage(
                      appBar: Get.find<UserAccountController>().regime != NsgControllerRegime.selection ? const SizedBox() : null,
                      appBarColor: Colors.white,
                      type: NsgListPageMode.table,
                      controller: controller,
                      title: '',
                      textNoItems: '',
                      appBarIcon: Icons.arrow_back_ios_new,
                      appBarOnPressed: () {
                        controller.regime = NsgControllerRegime.view;
                        Get.back();
                      },
                      appBarIcon2: null,
                      // appBarOnPressed2: () {
                      //   controller.itemPagePost();
                      // },
                      elementEditPage: _elementPage,
                      availableButtons: [
                        if (Get.find<UserAccountController>().regime != NsgControllerRegime.selection) NsgTableMenuButtonType.createNewElement,
                        if (Get.find<UserAccountController>().regime != NsgControllerRegime.selection) NsgTableMenuButtonType.editElement,
                        if (Get.find<UserAccountController>().regime != NsgControllerRegime.selection) NsgTableMenuButtonType.removeElement
                      ],
                      columns: [
                        NsgTableColumn(name: UserAccountGenerated.nameName, expanded: true, presentation: 'Наименование'),
                        NsgTableColumn(name: UserAccountGenerated.nameOrganizationId, expanded: true, presentation: 'Организация'),
                      ]),
                ),
              ),
              if (width < 700) const BottomMenu(),
            ],
          );
        }),
      ),
    );
  }
}
