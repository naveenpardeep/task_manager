// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_light_app_bar.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';

class OrganizationListMobileView extends GetView<OrganizationController> {
  const OrganizationListMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BodyWrap(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                NsgLightAppBar(
                  title: 'Компании',
                  leftIcons: [
                    NsgLigthAppBarIcon(
                      color: Colors.black,
                      icon: Icons.arrow_back_ios_new,
                      onTap: () {
                        Get.toNamed(Routes.projectListPage);
                      },
                    ),
                  ],
                  rightIcons: [
                    NsgLigthAppBarIcon(
                      color: Colors.black,
                      icon: Icons.add,
                      onTap: () {
                        controller.itemNewPageOpen(Routes.createOrganizationPage);
                      },
                    )
                  ],
                ),
                Expanded(child: controller.obx((state) => getOrganizationList())),
                if (width < 700) const BottomMenu(),
              ],
            )));
  }

  Widget getOrganizationList() {
    List<Widget> list = [];
    var organizationList = controller.items;

    for (var organizations in organizationList) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            Get.find<OrganizationController>().currentItem = organizations;
            Get.find<OrganizationController>().itemPageOpen(organizations, Routes.organizationViewPageMobile, needRefreshSelectedItem: true);
            // Get.toNamed(Routes.organizationPage);
          },
          onLongPress: () {},
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: ClipOval(
                        child: organizations.photoPath.isEmpty
                            ? Container(
                                decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                width: 48,
                                height: 48,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 48,
                                  color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                ),
                              )
                            : Image.network(
                                TaskFilesController.getFilePath(organizations.photoPath),
                                fit: BoxFit.cover,
                                width: 48,
                                height: 48,
                              ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            organizations.name,
                            style: TextStyle(
                              fontSize: ControlOptions.instance.sizeL,
                            ),
                          ),
                          // for CEO of the Company need to change
                          // Text(
                          //   organizations.ceo.toString(),
                          //   style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                          // ),
                        ],
                      ),
                    ),
                    // const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return SingleChildScrollView(child: Column(children: list));
  }
}
