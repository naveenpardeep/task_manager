import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tabs.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/generated/organization_item.g.dart';

import '../project/project_controller.dart';
import '../user_account/user_account_controller.dart';

class CreateOrganizationPage extends GetView<OrganizationController> {
  CreateOrganizationPage({Key? key}) : super(key: key);

  late NsgFilePicker picker;

  @override
  Widget build(BuildContext context) {
    // if (controller.lateInit) {
    //   controller.requestItems();
    // }
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
            //сохранение фото
          }
          Navigator.of(Get.context!).pop();
        },
        // ignore: prefer_const_literals_to_create_immutables
        objectsList: []);
    return BodyWrap(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: controller.obx((state) => Container(
                key: GlobalKey(),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  TTAppBar(
                    title: controller.currentItem.name.isNotEmpty ? controller.currentItem.name : 'Организация',
                    leftIcons: [
                      TTAppBarIcon(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          controller.itemPageCancel();
                        },
                      )
                    ],
                    rightIcons: [
                      TTAppBarIcon(
                        icon: Icons.close,
                        onTap: () {},
                      )
                    ],
                  ),
                  Expanded(child: IconsTabs(tabs: getTabs())),
                  Row(
                    children: [
                      Expanded(
                          child: TaskButton(
                        text: 'Отменить',
                        onTap: () {},
                        style: TaskButtonStyle.light,
                      )),
                      Expanded(
                          child: TaskButton(
                        text: 'Сохранить',
                        onTap: () async {
                          await controller.itemPagePost(goBack: false);
                          //При создании новой организации, должен автоматически создастся профиль для нее
                          //Соотвественно, надо перечитать профили
                          await Get.find<UserAccountController>().requestItems();
                          var projectC = Get.find<ProjectController>();
                          projectC.refreshData();
                          NsgNavigator.instance.offAndToPage(Routes.projectListPage);
                          // projectC.itemPageOpen(
                          //     Get.find<ProjectController>().currentItem,
                          //     Routes.projectListPage);
                        },
                        style: TaskButtonStyle.dark,
                      ))
                    ],
                  ),
                  const BottomMenu()
                ])))));
  }

  List<IconsTabsTab> getTabs() {
    List<IconsTabsTab> list = [];

    list.addAll([IconsTabsTab(page: getOrgSettings(), icon: Icons.apartment), IconsTabsTab(page: getProfileSettings(), icon: Icons.person)]);

    return list;
  }

  Widget getOrgSettings() {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          getHeader(),
          TTNsgInput(
            dataItem: controller.currentItem,
            fieldName: OrganizationItemGenerated.nameName,
            label: 'Название компании',
            infoString: 'Укажите название компании',
          ),
          TTNsgInput(
            controller: controller,
            selectionController: Get.find<UserAccountController>(),
            dataItem: controller.currentItem,
            fieldName: OrganizationItemGenerated.nameCEOId,
            label: 'CEO',
            infoString: 'Укажите генерального директора',
          ),
          TTNsgInput(
            controller: controller,
            selectionController: Get.find<UserAccountController>(),
            dataItem: controller.currentItem,
            fieldName: OrganizationItemGenerated.nameCEOId,
            label: 'Администратор',
            infoString: 'Выберите администратора',
          ),

          // TTNsgInput(
          //   dataItem: controller.currentItem,
          //   fieldName: OrganizationItemGenerated.nameDateCreated,
          //   label: 'Название компании',
          //   infoString: 'Укажите название компании',
          // ),

          // const Align(alignment: Alignment.centerLeft, child: NsgText('Добавление пользователей в эту организацию')),
          // NsgTable(
          //     controller: Get.find<OrganizationItemUserTableController>(),
          //     elementEditPageName: Routes.organizationUserRowPage,
          //     availableButtons: const [
          //       NsgTableMenuButtonType.createNewElement,
          //       NsgTableMenuButtonType.editElement,
          //       NsgTableMenuButtonType.removeElement
          //     ],
          //     columns: [
          //       NsgTableColumn(name: OrganizationItemUserTableGenerated.nameUserAccountId, expanded: true, presentation: 'Users'),
          //       NsgTableColumn(name: OrganizationItemUserTableGenerated.nameIsAdmin, width: 100, presentation: 'Admin'),
          //     ]),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Expanded(child: Divider(color: ControlOptions.instance.colorGrey)),
          ),
          TaskTextButton(
            text: 'Удалить компанию',
            onTap: () {},
          )
        ]),
      ),
    );
  }

  Widget getProfileSettings() {
    return Container();
  }

  Widget getHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
      child: Stack(clipBehavior: Clip.none, alignment: Alignment.bottomRight, children: [
        ClipOval(
          child: companyImage(),
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

  Widget companyImage() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green, width: 5.0, style: BorderStyle.solid),
      ),
      child: const Center(child: Text('no image')),
    );
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
}
