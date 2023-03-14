// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/mobile_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';

class OrganizationListMobileView extends GetView<OrganizationController> {
  const OrganizationListMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BodyWrap(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: controller.obx((state) => Container(
                // key: GlobalKey(),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                  TTAppBar(
                    title: 'Компании',
                    leftIcons: [
                      TTAppBarIcon(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                    rightIcons: [
                      TTAppBarIcon(
                        icon: Icons.add,
                        onTap: () {
                          controller.itemNewPageOpen(Routes.createOrganizationPage);
                        },
                      )
                    ],
                  ),
                  // Expanded(
                  //   child: Container(
                  //     padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                  //     child: SingleChildScrollView(
                  //       child: Column(children: [
                  //         NsgTable(
                  //             showIconFalse: false,
                  //             controller: Get.find<OrganizationController>(),
                  //             elementEditPageName: Routes.organizationPage,
                  //             availableButtons: const [
                  //               NsgTableMenuButtonType.createNewElement,
                  //               NsgTableMenuButtonType.editElement,
                  //               NsgTableMenuButtonType.removeElement
                  //             ],
                  //             columns: [
                  //               NsgTableColumn(name: OrganizationItemGenerated.nameName, expanded: true, presentation: 'Organization'),
                  //             ])
                  //       ]),
                  //     ),
                  //   ),
                  // ),

                  Expanded(child: getOrganizationList()),
                  if (width < 700)
                  // const BottomMenu(),
                   const TmMobileMenu()
                ])))));
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
              Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: organizations.photoFile.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                  width: 32,
                                  height: 32,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 20,
                                    color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                  ),
                                )
                              : Image.memory(
                                  Uint8List.fromList(organizations.photoFile),
                                  fit: BoxFit.cover,
                                  width: 32,
                                  height: 32,
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
                            Text(
                              organizations.ceo.toString(),
                              style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
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
