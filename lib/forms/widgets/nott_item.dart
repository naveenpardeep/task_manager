import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/widgets/nsg_context_menu.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/enums/e_notification_type.dart';

import '../../model/notification_doc.dart';

class NottItem extends StatelessWidget {
  const NottItem({super.key, required this.notification});
  final NotificationDoc notification;

  @override
  Widget build(BuildContext context) {
    //var notifC = Get.find<NotificationController>();
    return ContextMenuListener(
      contextMenu: ContextMenu(
        menuItems: [ContextMenuItem(text: 'Проверка', onTap: () {}), ContextMenuItem(onTap: () {})],
      ),
      child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ControlOptions.instance.colorGreyLight),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getName(), style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontFamily: 'Inter')), //ОС
                  InkWell(
                    onTap: () {
                      _dialogBuilder(context);
                    },
                    child: Icon(Icons.more_vert, color: ControlOptions.instance.colorMainLight),
                  ),
                ],
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(children: [Flexible(child: Text(getData(), style: TextStyle(fontSize: ControlOptions.instance.sizeM, fontFamily: 'Inter')))]),
                //Вы были добавлены в новый проект
              )),
              IntrinsicHeight(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        getAuthor(),
                        style: TextStyle(color: ControlOptions.instance.colorMainLight, fontSize: ControlOptions.instance.sizeS, fontFamily: 'Inter'),
                      ), //Леонид Павлов
                      Text(NsgDateFormat.dateFormat(notification.date, format: "dd.MM.yyyy / HH:mm"),
                          style: TextStyle(
                              color: ControlOptions.instance.colorMainLight, fontSize: ControlOptions.instance.sizeS, fontFamily: 'Inter')) //01.01.2023 / 9:43
                    ],
                  ),
                  //TODO: Фото
                  ClipOval(
                    child: Material(child: getPhoto()),
                  )
                ],
              ))
            ],
          )),
    );
  }

  void goToPage() {
    if (notification.notificationType == ENotificationType.editedTask) {
      //
    } else if (notification.notificationType == ENotificationType.invitationAccepted) {
      //
    } else if (notification.notificationType == ENotificationType.invitationRejected) {
      //
    } else if (notification.notificationType == ENotificationType.newTask) {
      //
    } else if (notification.notificationType == ENotificationType.recievedTask) {
      //
    } else if (notification.notificationType == ENotificationType.userAdded) {
      //
    } else {
      //TODO: показывать AlertDialog!
    }
  }

  String getName() {
    if (notification.notificationType == ENotificationType.editedTask) {
      return notification.task.name;
    } else if (notification.notificationType == ENotificationType.invitationAccepted) {
      //notification.invitation.
      return notification.project.name;
    } else if (notification.notificationType == ENotificationType.invitationRejected) {
      return notification.project.name;
    } else if (notification.notificationType == ENotificationType.newTask) {
      return notification.task.name;
    } else if (notification.notificationType == ENotificationType.recievedTask) {
      return notification.task.name;
    } else if (notification.notificationType == ENotificationType.userAdded) {
      return notification.project.name;
    } else {
      return 'Ошибка';
    }
  }

  String getData() {
    return notification.comment;
  }

  String getAuthor() {
    if (notification.notificationType == ENotificationType.editedTask) {
      return notification.task.name;
    } else if (notification.notificationType == ENotificationType.invitationAccepted) {
      return '${notification.invitation.author.name} ${notification.invitation.author.lastName}';
    } else if (notification.notificationType == ENotificationType.invitationRejected) {
      return notification.invitation.author.name;
    } else if (notification.notificationType == ENotificationType.newTask) {
      return 'name';
    } else if (notification.notificationType == ENotificationType.recievedTask) {
      return 'name';
    } else if (notification.notificationType == ENotificationType.userAdded) {
      return '${notification.userAccount.name} ${notification.userAccount.lastName}';
    } else {
      return 'Ошибка';
    }
  }

  Widget getPhoto() {
    return Container(
      decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
      width: 40,
      height: 40,
      child: Icon(
        Icons.add_a_photo,
        size: 20,
        color: ControlOptions.instance.colorMain.withOpacity(0.4),
      ),
    );
    /*notification.project
                      ? Container(
                          decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                          width: 70,
                          height: 70,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 32,
                            color: ControlOptions.instance.colorMain.withOpacity(0.4),
                          ),
                        )
                      : Image.memory(
                          Uint8List.fromList(notification.project.photoFile),
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        );*/
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TaskButton(
              text: 'text1',
              onTap: () {},
            ),
            TaskButton(
              text: 'text2',
              onTap: () {},
            )
          ],
        );
      },
    );
  }
}
