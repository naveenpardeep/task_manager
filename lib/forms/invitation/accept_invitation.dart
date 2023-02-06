import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

import '../organization/organization_controller.dart';

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
                  text: 'Список приглашений',
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
                            invitationList(),
                            if (controller.items.isEmpty)
                              createNewOrganizationButton(),
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

  Widget invitationList() {
    var dataController = Get.find<DataController>();
    var invitationController = Get.find<InvitationController>();
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];

    var invitations = controller.items.reversed;

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
                            'Организация:  ${invitation.organization}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            'Проект:  ${invitation.project}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor: 1.2,
                          ),
                          Text(
                            'Author Name:  ${invitation.author}',
                            // style: const TextStyle(fontWeight: FontWeight.bold),
                            // textScaleFactor: 1.2,
                          ),
                          Text(
                            'Invited User:  ${invitation.invitedUser}',
                            // style: const TextStyle(fontWeight: FontWeight.bold),
                            // textScaleFactor: 1.2,
                          ),
                          Text(
                            'создано: ${formateddate.format(invitation.date)}',
                            maxLines: 1,
                            textScaleFactor: 0.8,
                            style: const TextStyle(color: Color(0xff10051C)),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: NsgButton(
                                  height: 40,
                                  width: 100,
                                  borderRadius: 20,
                                  borderColor:
                                      ControlOptions.instance.colorBlue,
                                  backColor: Colors.transparent,
                                  color: Colors.black,
                                  text: 'Отклонить приглашение',
                                  onPressed: () async {
                                    Get.find<InvitationController>()
                                        .currentItem = invitation;
                                    var dataController =
                                        Get.find<DataController>();
                                    var invitationController =
                                        Get.find<InvitationController>();
                                    var DecInvitation = await dataController
                                        .respondToInvitation(
                                      invitationController.currentItem.id,
                                      false,
                                    );
                                    Get.find<ProjectController>()
                                        .newItemPageOpen(
                                            pageName: Routes.projectListPage);
                                    Get.find<ProjectController>().refreshData();
                                  },
                                ),
                              ),
                              Flexible(
                                child: NsgButton(
                                  borderRadius: 20,
                                  height: 40,
                                  width: 100,
                                  text: 'Принять приглашение',
                                  onPressed: () async {
                                    Get.find<InvitationController>()
                                        .currentItem = invitation;
                                    var dataController =
                                        Get.find<DataController>();
                                    var invitationController =
                                        Get.find<InvitationController>();
                                    var acceptInvitation = await dataController
                                        .respondToInvitation(
                                      invitationController.currentItem.id,
                                      true,
                                    );
                                    Get.find<ProjectController>()
                                        .newItemPageOpen(
                                            pageName: Routes.projectListPage);
                                    Get.find<ProjectController>().refreshData();
                                  },
                                ),
                              ),
                            ],
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

  Widget createNewOrganizationButton() {
    return NsgButton(
      borderRadius: 20,
      height: 50,
      width: 400,
      text: 'Создать свою группу проектов (организацию)',
      onPressed: () async {
        Get.find<OrganizationController>()
            .newItemPageOpen(pageName: Routes.createOrganizationPage);
      },
    );
  }
}
