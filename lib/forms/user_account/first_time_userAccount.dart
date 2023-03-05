// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../model/data_controller.dart';
import '../widgets/tt_nsg_input.dart';

class FirstTimeUserAccountPage extends GetView<UserAccountController> {
  const FirstTimeUserAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Настройка профиля',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 20, 15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                                  child: Stack(clipBehavior: Clip.none, alignment: Alignment.bottomRight, children: [
                                    ClipOval(
                                      child: userImage(),
                                    ),
                                    Positioned(
                                        bottom: -5,
                                        right: -5,
                                        child: InkWell(
                                          onTap: () {},
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
                                ),
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
                        style: TaskButtonStyle.warning,
                        text: 'Выйти',
                        onTap: () async {
                          await Get.find<DataController>().provider!.logout();
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
                            if (true /*controller.currentItem.lastChange == DateTime(0)*/) {
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
    var uac = Get.find<UserImageController>();
    return NsgImage(
      controller: uac,
      fieldName: PictureGenerated.nameImage,
      item: uac.currentItem,
      noImage: _noImageWidget(),
    );
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
  _noImageWidget() {
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
}
