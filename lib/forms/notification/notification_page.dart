import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/helpers/nsg_data_format.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/enums.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var controller = Get.find<NotificationController>();
  var taskc = Get.find<TasksController>();
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
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: controller.obx((state) => Container(
              key: GlobalKey(),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                NsgAppBar(
                  backColor: Colors.white,
                  color: Colors.black,
                  text: 'Уведомления'.toUpperCase(),
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                ),
                Expanded(child: getNotificationList()),
              ])))),
    );
  }

  Widget getNotificationList() {
    List<Widget> list = [];
    var scrollController = ScrollController();
    var tasksList = controller.items.reversed;
    double width = MediaQuery.of(context).size.width;

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
                Routes.taskEditPage,
              );
            }
            if (tasks.notificationType == ENotificationType.newTask) {
              Get.find<TasksController>().itemPageOpen(tasks.task, Routes.taskEditPage, needRefreshSelectedItem: true);
            }
            if (tasks.notificationType == ENotificationType.recievedTask) {
              Get.find<TasksController>().itemPageOpen(tasks.task, Routes.taskEditPage, needRefreshSelectedItem: true);
            }
          },
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                    child: Card(
                        color: const Color.fromARGB(239, 248, 250, 252),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks.project.name,
                                maxLines: 1,
                              ),
                              Text(
                                tasks.comment,
                              ),
                              if (tasks.notificationType == ENotificationType.invitationAccepted)
                                Text(
                                  '${tasks.invitation.invitedUser}',
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.invitationRejected)
                                Text(
                                  '${tasks.invitation.invitedUser}',
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.editedTask)
                                Text(
                                  tasks.task.name,
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.newTask)
                                Text(
                                  tasks.task.name,
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.recievedTask)
                                Text(
                                  tasks.task.name,
                                  maxLines: 1,
                                ),
                              if (tasks.notificationType == ENotificationType.userAdded)
                                Text(
                                  tasks.userAccount.toString(),
                                  maxLines: 1,
                                ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 12,
                                  ),
                                  Expanded(
                                      child: Text(NsgDateFormat.dateFormat(tasks.date, format: "dd.MM.yyyy / HH:mm"),
                                          style: TextStyle(
                                              color: ControlOptions.instance.colorMainLight,
                                              fontSize: ControlOptions.instance.sizeS,
                                              fontFamily: 'Inter')) //01.01.2023 / 9:43
                                      ),
                                  tasks.project.photoPath.isEmpty
                                      ? ClipOval(
                                          child: Container(
                                            decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                            width: 32,
                                            height: 32,
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 20,
                                              color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                            ),
                                          ),
                                        )
                                      : ClipOval(
                                          child: Image.network(
                                            TaskFilesController.getFilePath(tasks.project.photoPath),
                                            fit: BoxFit.cover,
                                            width: 32,
                                            height: 32,
                                          ),
                                        )
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
        thickness: width > 700 ? 10 : 0,
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
