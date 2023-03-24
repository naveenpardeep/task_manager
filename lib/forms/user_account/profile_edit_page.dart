// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../model/data_controller.dart';
import '../widgets/tt_app_bar.dart';
import '../widgets/tt_nsg_input.dart';

// ignore: must_be_immutable
class ProfileEditPage extends GetView<UserAccountController> {
  ProfileEditPage({Key? key}) : super(key: key);
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
                  TTAppBar(
                    title: 'Настройка профиля',
                    leftIcons: [
                      TTAppBarIcon(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          controller.itemPagePost(goBack: true);
                          //Get.back();
                        },
                      )
                    ],
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
                              // NsgInput(
                              //   selectionController:
                              //       Get.find<OrganizationController>(),
                              //   dataItem: controller.currentItem,
                              //   fieldName:
                              //       UserAccountGenerated.nameOrganizationId,
                              //   label: 'Организация',
                              // ),

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
                              //Должность тоже нужна только внутри организации
                              // NsgInput(
                              //   dataItem: controller.currentItem,
                              //   fieldName: UserAccountGenerated.namePosition,
                              //   label: 'Должность',
                              // ),
                              //Думаю, что при первоначальном заполнении профиля не нужны настройки уведомлений
                              /*NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated
                                    .nameSettingNotifyByPush,
                                label: 'Показывать push-уведомления',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated
                                    .nameSettingNotifyByEmail,
                                label: 'Отправлять уведомления на почту',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated
                                    .nameSettingNotifyNewTasks,
                                label: 'Создана задача с моим участием',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated
                                    .nameSettingNotifyEditedTasks,
                                label:
                                    'Все изменения в задачах с моим участием',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated
                                    .nameSettingNotifyNewTasksInProjects,
                                label: 'Новая задача в проекте',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated
                                    .nameSettingNotifyEditedTasksInProjects,
                                label: 'Все изменения в задачах проектов',
                              ),*/

                              // NsgButton(
                              //   text: 'Список пользователей',
                              //   color: Colors.white,
                              //   onPressed: () {
                              //     Get.toNamed(Routes.userAccountListPage);
                              //   },
                              // )
                            ],
                          ),
                        )),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TaskButton(
                          style: TaskButtonStyle.light,
                          text: 'Назад',
                          onTap: () async {
                            Get.back();
                          },
                        ),
                      ),
                      Expanded(
                        child: TaskButton(
                          style: TaskButtonStyle.dark,
                          text: 'Сохранить',
                          onTap: () async {
                            controller.itemPagePost(goBack: true);
                            //Get.back();
                          },
                        ),
                      ),
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
    if (userAccountController.currentItem.photoFile.isNotEmpty) {
      return Image.memory(
        Uint8List.fromList(
          userAccountController.currentItem.photoFile,
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

  //TODO: show image "no image"

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
