import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../../model/generated/invitation.g.dart';

class InvitationPage extends StatefulWidget {
  const InvitationPage({Key? key}) : super(key: key);
  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  var controller = Get.find<InvitationController>();

  @override
  void initState() {
    super.initState();
    // if (controller.lateInit) {
    //   controller.requestItems();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
        child: Scaffold(
            key: scaffoldKey,
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
                        text: controller.currentItem.isEmpty
                            ? 'Invitation'.toUpperCase()
                            : controller.currentItem.invitedUser.name,
                        icon: Icons.arrow_back_ios_new,
                        colorsInverted: true,
                        bottomCircular: true,
                        onPressed: () {
                          controller.itemPageCancel();
                        },
                        icon2: Icons.check,
                        onPressed2: () async {
                          if (controller
                              .currentItem.invitedPhoneNumber.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Пожалуйста, введите номер мобильного телефона ')));
                          } else {
                            await controller.itemPagePost();

                            Get.back();
                          }
                        },
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              NsgInput(
                                selectionController:
                                    Get.find<UserAccountController>(),
                                dataItem: controller.currentItem,
                                fieldName:
                                    InvitationGenerated.nameInvitedUserId,
                                label: 'Select User',
                              ),
                              NsgInput(
                                selectionController:
                                    Get.find<OrganizationController>(),
                                dataItem: controller.currentItem,
                                fieldName:
                                    InvitationGenerated.nameOrganizationId,
                                label: 'Select Organization',
                              ),
                              NsgInput(
                                maskType: NsgInputMaskType.phone,
                                dataItem: controller.currentItem,
                                fieldName:
                                    InvitationGenerated.nameInvitedPhoneNumber,
                                label: 'Mobile Number',
                              ),
                              // NsgInput(
                              //   dataItem: controller.currentItem,
                              //   fieldName: InvitationGenerated.nameAuthorId,
                              //   label: 'Author',
                              // ),
                              // NsgInput(
                              //   dataItem: controller.currentItem,
                              //   fieldName: InvitationGenerated.nameComment,
                              //   label: 'Comment',
                              // ),
                              // NsgInput(
                              //   dataItem: controller.currentItem,
                              //   fieldName: InvitationGenerated.nameIsAccepted,
                              //   label: 'Accept',
                              // ),
                            ]),
                          ),
                        ),
                      ),
                    ])))));
  }
}
