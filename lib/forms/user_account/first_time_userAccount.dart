// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../model/data_controller.dart';
import '../invitation/invitation_controller.dart';
import '../widgets/tt_app_bar.dart';
import '../widgets/tt_nsg_input.dart';

// ignore: must_be_immutable
class FirstTimeUserAccountPage extends GetView<UserAccountController> {
  FirstTimeUserAccountPage({Key? key}) : super(key: key);
  late NsgFilePicker picker;
  var userAccountController = Get.find<UserAccountController>();
  var userImageController = Get.find<UserImageController>();

  @override
  Widget build(BuildContext context) {
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
            // File imageFile = File(value[0].filePath);
            //  List<int> imagebytes = await imageFile.readAsBytes();
            Get.find<DataController>().currentUser.photoFile = imagefile; //????????
            userAccountController.currentItem.photoFile = imagefile;
            await userAccountController.postItems([Get.find<DataController>().currentUser]); //???????
            await userAccountController.postItems([userAccountController.currentItem]);
            await userAccountController.refreshData();
          }
          //userAccountController.sendNotify();
          Navigator.of(Get.context!).pop();
        },
        // ignore: prefer_const_literals_to_create_immutables
        objectsList: []);
    if (controller.lateInit) {
      controller.requestItems();
    }
    if (Get.find<UserImageController>().lateInit) {
      Get.find<UserImageController>().requestItems();
    }

    if (Get.find<OrganizationController>().lateInit) {
      Get.find<OrganizationController>().requestItems();
    }
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
                  const TTAppBar(
                    title: 'Настройка профиля',
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 20, 15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(children: [
                                Get.width < 700 ? getHeader() : getHeader(),
                                Column(
                                  children: [
                                    Text(
                                      'Код профиля',
                                      style: TextStyle(
                                          fontSize: ControlOptions.instance.sizeS, fontFamily: 'Inter', color: ControlOptions.instance.colorMainLight),
                                    )
                                  ],
                                )
                              ]),
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameName,
                                label: 'Ваш ник',
                                infoString: 'Введите ник',
                              ),
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameFirstName,
                                label: 'Ваше имя',
                                infoString: 'Введите имя',
                              ),
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameLastName,
                                label: 'Ваша фамилия',
                                infoString: 'Введите фамилию',
                              ),
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameBirthDate,
                                label: 'Ваша Дата рождения',
                                infoString: 'Введите Дата рождения',
                              ),
                              TTNsgInput(
                                maskType: NsgInputMaskType.phone,
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.namePhoneNumber,
                                label: 'Телефон',
                                infoString: '+7',
                              ),
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameEmail,
                                label: 'Электронная почта',
                                infoString: 'e-mail@mail.org',
                              ),
                            ],
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TaskButton(
                        style: TaskButtonStyle.warning,
                        text: 'Выйти',
                        onTap: () async {
                          await Get.find<DataController>().provider!.logout(Get.find<DataController>());
                          //await Get.find<DataController>().onInit();\
                          //await Get.find<DataController>().provider!.resetUserToken();
                          await Get.find<DataController>().provider!.connect(Get.find<DataController>());
                          //NsgNavigator.instance.offAndToPage(Routes.firstStartPage);
                        },
                      )),
                      Expanded(
                          child: TaskButton(
                        text: 'Далее',
                        onTap: () async {
                          if (controller.currentItem.name.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите ник')));
                          } else if (controller.currentItem.firstName.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите имя')));
                          } else if (controller.currentItem.lastName.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите фамилию')));
                          } else if (controller.currentItem.phoneNumber.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите телефон')));
                          } else if (controller.currentItem.email.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите Email')));
                          } else {
                            if (!controller.currentItem.isFilled) {
                              controller.currentItem.isFilled = true;
                              await controller.itemPagePost();
                              Get.toNamed(Routes.loginConfirmPage);
                            } else {
                              await Get.find<InvitationController>().requestItems();
                              Get.find<InvitationController>().itemNewPageOpen(Routes.acceptInvitationPage);
                            }
                          }

                          // Get.back();
                        },
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userImage() {
    if (userAccountController.currentItem.photoName.isNotEmpty) {
      return Image.network(
        TaskFilesController.getFilePath(
          userAccountController.currentItem.photoName,
        ),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green, width: 5.0, style: BorderStyle.solid),
        ),
        child: const Center(child: Text('no image')),
      );
    }
    /*NsgImage(
      controller: uac,
      fieldName: PictureGenerated.nameImage,
      item: uac.currentItem,
      noImage: _noImageWidget(),
    );*/
    // NsgFilePicker(
    //   showAsWidget: true,
    //   callback: (value) {},
    //   objectsList: Get.find<UserImageController>().images,
    //   allowedFileFormats: const [],
    //   maxFilesCount: 1,
    // ),
    //);
  }

  Widget getHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
      child: Stack(clipBehavior: Clip.none, alignment: Alignment.bottomRight, children: [
        ClipOval(
          child: userImage(),
        ),
        Positioned(
            bottom: -5,
            right: -5,
            child: InkWell(
              onTap: () {
                Get.dialog(picker, barrierDismissible: true);
              },
              child: ClipOval(
                  child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(color: ControlOptions.instance.colorMainLighter),
                child: Center(
                    child: Icon(
                  Icons.photo_camera_outlined,
                  color: ControlOptions.instance.colorMainLight,
                )),
              )),
            )),
      ]),
    );
  }
}
