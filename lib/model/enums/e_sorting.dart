import 'package:nsg_data/nsg_data.dart';

/// Сортировка
class ESorting extends NsgEnum {
  static ESorting dateDesc = ESorting(0, 'По дате от самой новой');
  static ESorting dateAsc = ESorting(1, 'По дате от самой старой');
  static ESorting priorityDesc = ESorting(2, 'По приоритету от самого важного');
  static ESorting priorityAsc = ESorting(3, 'По приоритету от менее важного');

  ESorting(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, ESorting>{
      0: dateDesc,
      1: dateAsc,
      2: priorityDesc,
      3: priorityAsc,
    };
  }
}
