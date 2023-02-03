import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class CreateInvitationUserPage extends GetView<UserAccountController> {
  const CreateInvitationUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (controller.lateInit) {
    //   controller.requestItems();
    // }
    // if (Get.find<UserImageController>().lateInit) {
    //   Get.find<UserImageController>().requestItems();
    // }

    // if (Get.find<OrganizationController>().lateInit) {
    //   Get.find<OrganizationController>().requestItems();
    // }
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: BodyWrap(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: controller.obx(
            (state) => Container(
              key: GlobalKey(),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  NsgAppBar(
                    color: Colors.white,
                    text: controller.currentItem.isEmpty
                        ? 'Новый пользователь'.toUpperCase()
                        : controller.currentItem.name.toUpperCase(),
                    icon: Icons.arrow_back_ios_new,
                    colorsInverted: true,
                    bottomCircular: true,
                    onPressed: () {
                      controller.itemPageCancel();
                    },
                    icon2: Icons.check,
                    onPressed2: () async {
                      if (controller.currentItem.phoneNumber.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                          child: Column(
                            children: [
                              NsgInput(
                                selectionController:
                                    Get.find<OrganizationController>(),
                                dataItem: controller.currentItem,
                                fieldName:
                                    UserAccountGenerated.nameOrganizationId,
                                label: 'Организация',
                              ),
                              NsgInput(
                                selectionController:
                                    Get.find<ProjectController>(),
                                dataItem: controller.currentItem,
                                fieldName:
                                    UserAccountGenerated.nameInviteProjectId,
                                label: 'Select Project',
                              ),
                               NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameInviteInstantAdd,
                                label: 'Instant add user to Project',
                              ),
                               NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameName,
                                label: 'UserName',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameFirstName,
                                label: 'Имя',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameLastName,
                                label: 'Фамилия',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.namePhoneNumber,
                                label: 'Номер телефона',
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
