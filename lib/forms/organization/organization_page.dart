import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import 'package:task_manager_app/model/generated/organization_item.g.dart';

import 'package:task_manager_app/model/generated/user_account.g.dart';

class OrganizationPage extends GetView<OrganizationController> {
  const OrganizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    return BodyWrap(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: controller.obx((state) => Container(
                key: GlobalKey(),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      NsgAppBar(
                        color: Colors.white,
                        backColor: const Color(0xff7876D9),
                        text: 'Welcome To Task Manager'.toUpperCase(),
                        icon: Icons.arrow_back_ios_new,
                        colorsInverted: true,
                        bottomCircular: true,
                        onPressed: () {
                          controller.itemPageCancel();
                        },
                        // icon2: Icons.check,
                        // onPressed2: () async {
                        //   await controller.itemPagePost();
                        // },
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              NsgTable(
                                  controller:
                                      Get.find<OrganizationController>(),
                                  elementEditPageName:
                                      Routes.createOrganizationPage,
                                  availableButtons: const [
                                    NsgTableMenuButtonType.createNewElement,
                                    NsgTableMenuButtonType.editElement,
                                    NsgTableMenuButtonType.removeElement
                                  ],
                                  columns: [
                                    NsgTableColumn(
                                        name:
                                            OrganizationItemGenerated.nameName,
                                        expanded: true,
                                        presentation: 'Organization'),
                                  ]),
                              NsgTable(
                                  showIconFalse: false,
                                  controller: Get.find<UserAccountController>(),
                                  elementEditPageName:
                                      Routes.createInvitationUser,
                                  availableButtons: const [
                                    NsgTableMenuButtonType.createNewElement,
                                    NsgTableMenuButtonType.editElement,
                                    NsgTableMenuButtonType.removeElement
                                  ],
                                  columns: [
                                    NsgTableColumn(
                                        name: UserAccountGenerated.nameName,
                                        expanded: true,
                                        presentation: 'User'),
                                    NsgTableColumn(
                                        name:
                                            UserAccountGenerated.nameFirstName,
                                        expanded: true,
                                        presentation: 'Имя'),
                                    NsgTableColumn(
                                        name: UserAccountGenerated
                                            .namePhoneNumber,
                                        expanded: true,
                                        presentation: 'Phone Number'),
                                    NsgTableColumn(
                                        name: UserAccountGenerated.nameEmail,
                                        expanded: true,
                                        presentation: 'EMail'),
                                  ]),
                              // Center(
                              //   child: NsgButton(
                              //     borderRadius: 20,
                              //     text: 'Invite User',
                              //     onPressed: () {
                              //       Get.find<InvitationController>()
                              //           .newItemPageOpen(
                              //               pageName: Routes.invitationPage);
                              //  },
                              //  ),
                              // )
                            ]),
                          ),
                        ),
                      ),
                    ])))));
  }
}
