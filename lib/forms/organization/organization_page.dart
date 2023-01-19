import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/model/generated/organization_item.g.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({Key? key}) : super(key: key);
  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  var controller = Get.find<OrganizationController>();

  @override
  void initState() {
    super.initState();
    if (controller.lateInit) {
      controller.requestItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: controller.obx((state) => Container(
                key: GlobalKey(),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      NsgAppBar(
                        color: Colors.white,
                        backColor: const Color(0xff7876D9),
                        text: controller.currentItem.isEmpty
                            ? 'Organization'.toUpperCase()
                            : controller.currentItem.name,
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
                            child: Column(children: [
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: OrganizationItemGenerated.nameName,
                                label: 'Organization Name',
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ])))));
  }
}
