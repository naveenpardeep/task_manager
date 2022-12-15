import 'package:nsg_data/nsg_data.dart';

/// Приоритет
class EPriority extends NsgEnum {
  static EPriority none = EPriority(0, 'Не назначен');
  static EPriority low = EPriority(1, 'Низкий');
  static EPriority medium = EPriority(2, 'Средний');
  static EPriority high = EPriority(3, 'Высокий');

  EPriority(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, EPriority>{
      0: none,
      1: low,
      2: medium,
      3: high,
    };
  }
}
