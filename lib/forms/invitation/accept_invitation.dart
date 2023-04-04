import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';
import 'package:task_manager_app/model/data_controller.dart';

import '../organization/organization_controller.dart';
import '../user_account/user_account_controller.dart';
import '../widgets/task_tuner_button.dart';

class AcceptInvitationPage extends GetView<InvitationController> {
  const AcceptInvitationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }

    return BodyWrap(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TTAppBar(
                  title: 'Проекты',
                  rightIcons: [
                    TTAppBarIcon(
                      icon: Icons.person,
                      onTap: () {
                        Get.find<UserAccountController>().itemPageOpen(Get.find<DataController>().mainProfile, Routes.firstTimeUserAccountPage);
                      },
                    ),
                    TTAppBarIcon(
                      icon: Icons.add,
                      onTap: () {
                        Get.find<OrganizationController>().newItemPageOpen(pageName: Routes.createOrganizationPage);
                      },
                    )
                  ],
                ),
                if (controller.items.isEmpty) Expanded(child: createFirstOrganization()),
                if (controller.items.isNotEmpty)
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              invitationList(),
                            ],
                          ),
                        )),
                  ),
                const BottomMenu()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget invitationList() {
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];

    var invitations = controller.items.reversed;

    {
      for (var invitation in invitations) {
        {
          list.add(GestureDetector(
            child: Container(
              color: const Color(0xff3ea8ab),
              child: Row(
                children: [
                  if (Get.find<DataController>().currentUser == invitation.invitedUser.mainUserAccount)
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
                                    borderColor: ControlOptions.instance.colorBlue,
                                    backColor: Colors.transparent,
                                    color: Colors.black,
                                    text: 'Отклонить приглашение',
                                    onPressed: () async {
                                      Get.find<InvitationController>().currentItem = invitation;
                                      var dataController = Get.find<DataController>();
                                      var invitationController = Get.find<InvitationController>();
                                      await dataController.respondToInvitation(
                                        invitationController.currentItem.id,
                                        false,
                                      );
                                      Get.find<ProjectController>().newItemPageOpen(pageName: Routes.projectListPage);
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
                                      Get.find<InvitationController>().currentItem = invitation;
                                      var dataController = Get.find<DataController>();
                                      var invitationController = Get.find<InvitationController>();

                                      await dataController.respondToInvitation(
                                        invitationController.currentItem.id,
                                        true,
                                      );
                                      Get.find<ProjectController>().newItemPageOpen(pageName: Routes.projectListPage);
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

  Widget createFirstOrganization() {
    return IntrinsicWidth(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          'Хм... Кажется, у вас еще нет ни одного проекта🤔',
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: ControlOptions.instance.sizeH4, fontFamily: 'Inter'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text('Создайте новый или получите приглашение',
            textAlign: TextAlign.start, style: TextStyle(fontSize: ControlOptions.instance.sizeH4, fontFamily: 'Inter')),
      ),
      TaskButton(
        text: 'Создать проект',
        onTap: () async {
          Get.find<OrganizationController>().newItemPageOpen(pageName: Routes.createOrganizationPage);
        },
      )
    ]));
  }
}
