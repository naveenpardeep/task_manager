// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class CreateInvitationUserPage extends GetView<UserAccountController> {
  CreateInvitationUserPage({Key? key}) : super(key: key);
  late NsgFilePicker picker;
  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    picker = NsgFilePicker(
        showAsWidget: true,
        skipInterface: true,
        oneFile: true,
        callback: (value) async {
          if (value.isNotEmpty) {
            List<int> imagefile;
            if (kIsWeb) {
              imagefile = await File.fromUri(Uri(path: value[0].filePath)).readAsBytes();
            } else {
              imagefile = await File(value[0].filePath).readAsBytes();
            }

            controller.currentItem.photoFile = imagefile;

            controller.sendNotify();
          }

          Navigator.of(Get.context!).pop();
        },
        objectsList: []);

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
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.dialog(picker, barrierDismissible: true);
                                      },
                                      child: Get.find<UserAccountController>().currentItem.photoFile.isEmpty
                                          ? ClipOval(
                                              child: Container(
                                              height: 100,
                                              width: 100,
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(color: ControlOptions.instance.colorGreyLighter),
                                              child: Center(
                                                  child: Icon(
                                                Icons.add_a_photo,
                                                color: ControlOptions.instance.colorMainLight,
                                                size: 25,
                                              )),
                                            ))
                                          : Image.memory(
                                              Uint8List.fromList(Get.find<UserAccountController>().currentItem.photoFile),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            ),
                                    ),
                                  ),
                                  const Expanded(
                                      child: Text(
                                    'Поскольку пользователь еще не зарегестрирован, необходимо для него создать предварительный аккаунт',
                                    style: TextStyle(color: Color(0xff529FBF)),
                                  )),
                                ],
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
