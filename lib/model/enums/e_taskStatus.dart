import 'package:nsg_data/nsg_data.dart';

/// TaskStatus
class ETaskstatus extends NsgEnum {
  static ETaskstatus newtask = ETaskstatus(0, 'Новые');
  static ETaskstatus suspended = ETaskstatus(1, 'Приостановлено');
  static ETaskstatus forFuture = ETaskstatus(2, 'На будущее');
  static ETaskstatus deleted = ETaskstatus(3, 'К удалению');
  static ETaskstatus atWork = ETaskstatus(4, 'В работе');
  static ETaskstatus onInspection = ETaskstatus(5, 'На проверке');
  static ETaskstatus done = ETaskstatus(6, 'Выполнено ');

  ETaskstatus(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, ETaskstatus>{
      0: newtask,
      1: suspended,
      2: forFuture,
      3: deleted,
      4: atWork,
      5: onInspection,
      6: done
    };
  }
}