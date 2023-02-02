import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

class AcceptRejectListPage extends GetView<InvitationController> {
  const AcceptRejectListPage({Key? key}) : super(key: key);

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
                  text: 'Accept Reject Users List',
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
                            acceptRejectList(),
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

  Widget acceptRejectList() {
    var dataController = Get.find<DataController>();
    var invitationController = Get.find<InvitationController>();
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];

    var invitations = controller.items;
//if(dataController.respondToInvitation.isBlank==false)
    {
      for (var invitation in invitations) {
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
                            'Project Name:  ${invitation.project}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            'Author Name:  ${invitation.author}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            'Invited User:  ${invitation.invitedUser} ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                           Text(
                            'Mobile: ${invitation.invitedPhoneNumber}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            'Accept  : ${invitation.isAccepted}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            'Reject  :  ${invitation.isRejected}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                              'Organization Name:  ${invitation.organization}'),
                          Text(
                            'создано: ${formateddate.format(invitation.date)}',
                            maxLines: 1,
                            textScaleFactor: 0.8,
                            style: const TextStyle(color: Color(0xff10051C)),
                          ),
                          const Divider(
                            height: 10,
                          )
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