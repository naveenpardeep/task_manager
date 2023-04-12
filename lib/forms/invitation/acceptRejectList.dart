// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/forms/invitation/acceptController.dart';

class AcceptRejectListPage extends GetView<AccpetController> {
  const AcceptRejectListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    var scrollController = ScrollController();
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
                NsgAppBar(
                  backColor: Colors.white,
                  color: Colors.black,

                  text: 'Invited Users List',
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
                      child: RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: scrollController,
                        thickness: width>700? 10: 0,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            child: Column(
                              children: [
                                acceptRejectList(),
                              ],
                            )),
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
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];

    var invitations = controller.items.reversed;
//if(dataController.respondToInvitation.isBlank==false)
    {
      for (var invitation in invitations) {
        {
          list.add(GestureDetector(
            child: Row(
            
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      color: const Color.fromARGB(255, 235, 238, 238),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Project Name:  ${invitation.project}',
                            ),
                            Text('Author Name:  ${invitation.author}'),
                            Text('Invited User:  ${invitation.invitedUser} ',
                            ),
                            Text('Mobile: ${invitation.invitedPhoneNumber}'),
                            Text('Accept  : ${invitation.isAccepted}'),
                            Text('Reject  :  ${invitation.isRejected}',
                            ),
                            Text(
                              'Organization Name:  ${invitation.organization}',
                            ),
                            Text(
                              'создано: ${formateddate.format(invitation.date)}',
                              maxLines: 1,
                              textScaleFactor: 0.8,
                            ),
                            if (invitation.isAccepted == false && invitation.isRejected == false)
                              Center(
                                child: NsgButton(
                                  borderRadius: 50,
                                  width: 100,
                                  text: 'Cancel',
                                  onPressed: () async {
                                    controller.currentItem = invitation;
                                    await controller.deleteItems([controller.currentItem]);
                                    controller.sendNotify();
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
