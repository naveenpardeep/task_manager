import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import '../../model/generated/invitation.g.dart';

class AcceptInvitationPage extends StatefulWidget {
  const AcceptInvitationPage({Key? key}) : super(key: key);
  @override
  State<AcceptInvitationPage> createState() => _AcceptInvitationPageState();
}

class _AcceptInvitationPageState extends State<AcceptInvitationPage> {
  var controller = Get.find<InvitationController>();

  @override
  void initState() {
    super.initState();
    // if (controller.lateInit) {
    //   controller.requestItems();
    // }
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
                            ? 'Invitation'.toUpperCase()
                            : controller.currentItem.invitedUser.name,
                        icon: Icons.arrow_back_ios_new,
                        colorsInverted: true,
                        bottomCircular: true,
                        onPressed: () {
                          controller.itemPageCancel();
                        },
                        icon2: Icons.check,
                        onPressed2: () async {
                          await controller.itemPagePost();

                          Get.find<ProjectController>().newItemPageOpen(
                              pageName: Routes.projectListPage);
                        },
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: InvitationGenerated.nameIsAccepted,
                                label: 'Accept',
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: InvitationGenerated.nameIsRejected,
                                label: 'Reject',
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ])))));
  }
}
