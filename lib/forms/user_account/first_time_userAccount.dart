import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

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
                      await controller.itemPagePost();
                      Get.find<InvitationController>()
                          .itemNewPageOpen(Routes.acceptInvitationPage);

                      // Get.back();
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

                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameName,
                                label: 'nick',
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
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: UserAccountGenerated.nameEmail,
                                label: 'Email',
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
                              Center(child: userImage()),
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
        border: Border.all(
            color: Colors.green, width: 5.0, style: BorderStyle.solid),
      ),
      child: const Center(child: Text('no image')),
    );
  }
}
