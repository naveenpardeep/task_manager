// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../user_account/user_account_controller.dart';

class OrganizationUserRowPage extends GetView<OrganizationItemUserTableController> {
  const OrganizationUserRowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
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
                  text: controller.currentItem.isEmpty ? 'Oragnization User '.toUpperCase() : controller.currentItem.owner.name,
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () {
                    controller.itemPagePost();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            NsgInput(
                              selectionController: Get.find<UserAccountController>(),
                              dataItem: controller.currentItem,
                              fieldName: OrganizationItemUserTableGenerated.nameUserAccountId,
                              label: 'User ',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: OrganizationItemUserTableGenerated.nameIsAdmin,
                              label: 'Admin',
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
    );
  }
}
