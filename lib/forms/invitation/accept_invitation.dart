import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

class AcceptInvitationPage extends GetView<InvitationController> {
  const AcceptInvitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    double height = MediaQuery.of(context).size.height;
    return BodyWrap(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  backColor: ControlOptions.instance.colorWhite,
                  text: 'Invitations List',
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  // icon2: Icons.check,
                  // onPressed2: () {
                  //   controller.itemPagePost();
                  // },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            commentList(),
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

  Widget commentList() {
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];

    var comments = controller.items;

    for (var comment in comments) {
      {
        list.add(GestureDetector(
          child: Container(
            color: ControlOptions.instance.colorGreyLight,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         'Author Name:  ${comment.author}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor: 1.2,
                        ),
                        Text('Organization Name:  ${comment.organization}'),
                        Text(
                          'создано: ${formateddate.format(comment.date)}',
                          maxLines: 1,
                          textScaleFactor: 0.8,
                          style: const TextStyle(color: Color(0xff10051C)),
                        ),
                        Row(
                          children: [
                                 Expanded(
                              child: NsgButton(
                                borderRadius: 20,
                                borderColor: ControlOptions.instance.colorBlue,
                                backColor: Colors.transparent,
                                color: Colors.black,
                                text: 'Отклонить приглашение',
                                onPressed: () async {
                                  var dataController =
                                      Get.find<DataController>();
                                  var invitationController =
                                      Get.find<InvitationController>();
                                  var DecInvitation =
                                      await dataController.respondToInvitation(
                                    invitationController.currentItem.id,
                                    false,
                                  );
                                  Get.find<ProjectController>().newItemPageOpen(
                                      pageName: Routes.projectListPage);
                                },
                              ),
                            ),
                            Expanded(
                              child: NsgButton(
                                borderRadius: 20,
                                text: 'Принять приглашение',
                                onPressed: () async {
                                  var dataController =
                                      Get.find<DataController>();
                                  var invitationController =
                                      Get.find<InvitationController>();
                                  var acceptInvitation =
                                      await dataController.respondToInvitation(
                                    invitationController.currentItem.id,
                                    true,
                                  );
                                  Get.find<ProjectController>().newItemPageOpen(
                                      pageName: Routes.projectListPage);
                                },
                              ),
                            ),
                       
                          ],
                        ),

                        Divider()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: list,
      ),
    ));
  }
}
