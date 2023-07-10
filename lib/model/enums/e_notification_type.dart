import 'package:nsg_data/nsg_data.dart';

/// Тип уведомления
class ENotificationType extends NsgEnum {
  static ENotificationType recievedTask = ENotificationType(0, 'Получена задача');
  static ENotificationType newTask = ENotificationType(1, 'Новая задача');
  static ENotificationType editedTask = ENotificationType(2, 'Изменена задача');
  static ENotificationType userAdded = ENotificationType(3, 'Пользователь добавлен');
  static ENotificationType invitationAccepted = ENotificationType(4, 'Приглашение принято');
  static ENotificationType invitationRejected = ENotificationType(5, 'Приглашение отклонено');
  static ENotificationType invitationRecieved = ENotificationType(6, 'Получено приглашение');
  static ENotificationType unreadChatMessage = ENotificationType(7, 'Непрочитанное сообщение в чате');

  ENotificationType(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, ENotificationType>{
      0: recievedTask,
      1: newTask,
      2: editedTask,
      3: userAdded,
      4: invitationAccepted,
      5: invitationRejected,
      6: invitationRecieved,
      7: unreadChatMessage,
    };
  }
}
