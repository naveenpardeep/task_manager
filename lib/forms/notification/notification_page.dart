import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/model/enums.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var controller = Get.find<NotificationController>();
  DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");

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
  
    return SafeArea(
      child: BodyWrap(
          child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.white,
              body: controller.obx((state) => Container(
                  key: GlobalKey(),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
                      NsgAppBar(
                        color: Colors.white,
                        backColor: const Color(0xff7876D9),
                        text: 'Уведомления'.toUpperCase(),
                        icon: Icons.arrow_back_ios_new,
                        colorsInverted: true,
                        bottomCircular: true,
                        onPressed: () {
                          controller.itemPageCancel();
                        },
                      ),
                      getNotificationInvitationList(),
                      getNotificationNewTaskList(),
                      getNotificationEditedTaskList(),
                    ]),
                  ))))),
    );
  }

  Widget getNotificationInvitationList() {
    List<Widget> list = [];
    var scrollController = ScrollController();
    var tasksList = controller.items.reversed.where((element) => element.notificationType == ENotificationType.invitationAccepted);

    for (var tasks in tasksList) {
      {
        list.add(GestureDetector(
          onTap: () {
       

            controller.itemPageOpen(tasks, Routes.invitationAcceptNew, needRefreshSelectedItem: true);
          },
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                    height: 98,
                    child: Card(
                        color: const Color.fromARGB(239, 248, 250, 252),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Project Name:  ${tasks.project.name}',
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Invitation Sent by: ${tasks.invitation.author.name}',
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 12,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'создано: ${formateddate.format(tasks.date)}',
                                    maxLines: 1,
                                    textScaleFactor: 0.8,
                                    style: const TextStyle(color: Color(0xff10051C)),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ))),
              ),
            ],
          ),
        ));
      }
    }

    return RawScrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        controller: scrollController,
        thickness: 10,
        trackBorderColor: ControlOptions.instance.colorGreyLight,
        trackColor: ControlOptions.instance.colorGreyLight,
        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
        radius: const Radius.circular(0),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: list,
              ),
            )));
  }

  Widget getNotificationNewTaskList() {
    List<Widget> list = [];
    var scrollController = ScrollController();
    var newtasksList = controller.items.reversed.where((element) => element.notificationType == ENotificationType.newTask);

    for (var tasks in newtasksList) {
      {
        list.add(GestureDetector(
          onTap: () {
            controller.itemPageOpen(tasks, Routes.notificationTaskPage, needRefreshSelectedItem: true);
          },
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                    height: 98,
                    child: Card(
                        color: const Color.fromARGB(239, 248, 250, 252),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks.task.name,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${tasks.task}',
                                      maxLines: 2,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 12,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'создано: ${formateddate.format(tasks.date)}',
                                    maxLines: 1,
                                    textScaleFactor: 0.8,
                                    style: const TextStyle(color: Color(0xff10051C)),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ))),
              ),
            ],
          ),
        ));
      }
    }

    return RawScrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        controller: scrollController,
        thickness: 10,
        trackBorderColor: ControlOptions.instance.colorGreyLight,
        trackColor: ControlOptions.instance.colorGreyLight,
        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
        radius: const Radius.circular(0),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: list,
              ),
            )));
  }

  Widget getNotificationEditedTaskList() {
    List<Widget> list = [];
    var scrollController = ScrollController();
    var newtasksList = controller.items.reversed.where((element) => element.notificationType == ENotificationType.editedTask);

    for (var tasks in newtasksList) {
      {
        list.add(GestureDetector(
          onTap: () {
            controller.itemPageOpen(tasks, Routes.notificationTaskPage, needRefreshSelectedItem: true);
          },
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                    height: 98,
                    child: Card(
                        color: const Color.fromARGB(239, 248, 250, 252),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks.task.name,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${tasks.task}',
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 12,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'создано: ${formateddate.format(tasks.date)}',
                                    maxLines: 1,
                                    textScaleFactor: 0.8,
                                    style: const TextStyle(color: Color(0xff10051C)),
                                  )),
                                ],
                              )
                            ],
                          ),
                        ))),
              ),
            ],
          ),
        ));
      }
    }

    return RawScrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        controller: scrollController,
        thickness: 10,
        trackBorderColor: ControlOptions.instance.colorGreyLight,
        trackColor: ControlOptions.instance.colorGreyLight,
        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
        radius: const Radius.circular(0),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: list,
              ),
            )));
  }
}
