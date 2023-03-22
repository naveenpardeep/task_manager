import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/enums.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var controller = Get.find<NotificationController>();
 var taskc= Get.find<TasksController>();
  DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");

  @override
  void initState() {
    super.initState();
    if (controller.lateInit) {
      controller.requestItems();
    }
     if (taskc.lateInit) {
      taskc.requestItems();
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
                      getNotificationList(),
                     
                    ]),
                  ))))),
    );
  }

  Widget getNotificationList() {
    List<Widget> list = [];
    var scrollController = ScrollController();
    var tasksList = controller.items.reversed;

    for (var tasks in tasksList) {
      {
        list.add(GestureDetector(
          onTap: () {
            if (tasks.notificationType == ENotificationType.invitationAccepted) {
              controller.itemPageOpen(
                tasks,
                Routes.acceptRejectListPage,
              );
            }

            if (tasks.notificationType == ENotificationType.invitationRejected) {
              controller.itemPageOpen(
                tasks,
                Routes.acceptRejectListPage,
              );
            }
            if (tasks.notificationType == ENotificationType.editedTask) {
              Get.find<TasksController>().itemPageOpen(
                tasks.task,
                Routes.newTaskPage,
              );
            }
            if (tasks.notificationType == ENotificationType.newTask) {
               Get.find<TasksController>().itemPageOpen(tasks.task, Routes.newTaskPage,needRefreshSelectedItem: true);
            }
            if (tasks.notificationType == ENotificationType.recievedTask) {
               Get.find<TasksController>().itemPageOpen(
                tasks.task,
                Routes.newTaskPage,needRefreshSelectedItem: true
              );
            }
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
                              
                              if (tasks.notificationType == ENotificationType.invitationAccepted)
                                Text(
                                  'Invitation Accepted by: ${tasks.invitation.invitedUser}',
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.invitationRejected)
                                Text(
                                  'Invitation Rejected by: ${tasks.invitation.invitedUser}',
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.editedTask)
                                Text(
                                  'Edited Task:  ${tasks.task}',
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.newTask)
                                Text(
                                  'New Task:  ${tasks.task.name}',
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.recievedTask)
                                Text(
                                  'Recieved Task:  ${tasks.task}',
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.userAdded)
                                Text(
                                  'User Added:  ${tasks.userAccount}',
                                  maxLines: 1,
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
