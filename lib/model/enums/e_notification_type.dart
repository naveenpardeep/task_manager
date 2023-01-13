import 'package:nsg_data/nsg_data.dart';

/// Тип уведомления
class ENotificationType extends NsgEnum {
  static ENotificationType recievedTask = ENotificationType(0, 'Получена задача');
  static ENotificationType newTask = ENotificationType(1, 'Новая задача');
  static ENotificationType editedTask = ENotificationType(2, 'Изменена задача');

  ENotificationType(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, ENotificationType>{
      0: recievedTask,
      1: newTask,
      2: editedTask,
    };
  }
}
