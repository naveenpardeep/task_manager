// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/invitation_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

class InvitationAcceptNew extends GetView<InvitationController> {
  const InvitationAcceptNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    double width = MediaQuery.of(context).size.width;

    return BodyWrap(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (width > 700)
                  NsgAppBar(
                    backColor: Colors.white,
                    color: Colors.black,
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
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            invitationList(),
                          ],
                        ),
                      )),
                ),
                //const TmMobileMenu()
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
              color: const Color.fromARGB(239, 248, 250, 252),
              child: Row(
                children: [
              //   if (Get.find<DataController>().currentUser == invitation.invitedUser.mainUserAccount)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipOval(
                      child: invitation.project.photoPath.isEmpty
                          ? Container(
                              decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                              width: 120,
                              height: 120,
                              child: Icon(
                                Icons.account_circle,
                                size: 20,
                                color: ControlOptions.instance.colorMain.withOpacity(0.4),
                              ),
                            )
                          : Image.network(
                              TaskFilesController.getFilePath(invitation.project.photoPath),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            )),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${invitation.organization}', style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF))),
                                        Text('${invitation.project}', style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.black)),
                                     const SizedBox(height: 10,),
                                      const  Text('Пригласил',
                                            style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF))),
                                      
                                        Text('${invitation.author}',
                                            style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Text(
                            //   'создано: ${formateddate.format(invitation.date)}',
                            //   maxLines: 1,
                            //   textScaleFactor: 0.8,
                            //   style: const TextStyle(color: Color(0xff10051C)),
                            // ),
                            Row(
                              children: [
                                Flexible(
                                  child: NsgButton(
                                    height: 40,
                                    width: 200,
                                    borderRadius: 20,
                                    borderColor: ControlOptions.instance.colorBlue,
                                    backColor: Colors.transparent,
                                    color: Colors.black,
                                    text: 'Отклонить',
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
                                    width: 200,
                                    text: 'Принять',
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
}
