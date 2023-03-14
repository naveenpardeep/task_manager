// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class CreateInvitationUserPage extends GetView<UserAccountController> {
  const CreateInvitationUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
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
                    color: Colors.black,
                    backColor: Colors.white,
                    text: controller.currentItem.isEmpty ? 'Новый пользователь'.toUpperCase() : controller.currentItem.name.toUpperCase(),
                    icon: Icons.arrow_back_ios_new,
                    colorsInverted: true,
                    bottomCircular: true,
                    onPressed: () {
                      controller.itemPageCancel();
                    },
                    icon2: Icons.check,
                    onPressed2: () async {
                      if (controller.currentItem.phoneNumber.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите номер мобильного телефона ')));
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
                              // NsgInput(
                              //   selectionController:
                              //       Get.find<OrganizationController>(),
                              //   dataItem: controller.currentItem,
                              //   fieldName:
                              //       UserAccountGenerated.nameOrganizationId,
                              //   label: 'Организация',
                              // ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  'Поскольку пользователь еще не зарегестрирован, необходимо для него создать предварительный аккаунт',
                                  style: TextStyle(color: Color(0xff529FBF)),
                                )),
                              ),
                              TTNsgInput(
                                selectionController: Get.find<ProjectController>(),
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameInviteProjectId,
                                label: 'Проект',
                                infoString: 'Добавить к участию в проекте ',
                              ),

                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameInviteInstantAdd,
                                label: 'добавить пользователя без приглашения',
                              ),
                              TTNsgInput(
                                maskType: NsgInputMaskType.phone,
                                keyboard: TextInputType.phone,
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.namePhoneNumber,
                                label: 'Номер телефона',
                                infoString: '+7',
                              ),
                              TTNsgInput(
                                keyboard: TextInputType.emailAddress,
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameEmail,
                                label: 'Электронная почта',
                                infoString: 'e-mail@mail.org',
                              ),
                              // TTNsgInput(
                              //   dataItem: controller.currentItem,
                              //   fieldName: UserAccountGenerated.nameName,
                              //   label: 'User Name',
                              //   infoString: 'Set user name for user',
                              // ),
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameFirstName,
                                label: 'Имя',
                                infoString: 'Укажите имя пользователя',
                              ),
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameLastName,
                                label: 'Фамилия',
                                infoString: 'Укажите фамилию пользователя',
                              ),
                            ],
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TaskButton(
                        text: 'Отменить',
                        style: TaskButtonStyle.light,
                        onTap: () {
                          Get.back();
                        },
                      )),
                      Expanded(
                          child: TaskButton(
                        text: 'Пригласить',
                        onTap: () async {
                          if (controller.currentItem.phoneNumber.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите номер мобильного телефона ')));
                          } else {
                            await controller.itemPagePost();

                            Get.back();
                          }
                        },
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
