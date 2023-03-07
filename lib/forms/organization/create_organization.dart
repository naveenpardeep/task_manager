import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/generated/organization_item.g.dart';

import '../project/project_controller.dart';
import '../user_account/user_account_controller.dart';

class CreateOrganizationPage extends GetView<OrganizationController> {
  const CreateOrganizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (controller.lateInit) {
    //   controller.requestItems();
    // }
    return BodyWrap(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: controller.obx((state) => Container(
                key: GlobalKey(),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  NsgAppBar(
                    color: Colors.black,
                    backColor: Colors.white,
                    text: 'Организация'.toUpperCase(),
                    icon: Icons.arrow_back_ios_new,
                    colorsInverted: true,
                    bottomCircular: true,
                    onPressed: () {
                      controller.itemPageCancel();
                    },
                    icon2: Icons.check,
                    onPressed2: () async {
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
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
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
                        ]),
                      ),
                    ),
                  ),
                ])))));
  }
}
