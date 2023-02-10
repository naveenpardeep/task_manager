import 'package:nsg_data/nsg_data.dart';

/// Период
class EPeriod extends NsgEnum {
  static EPeriod all = EPeriod(0, 'Все');
  static EPeriod day = EPeriod(1, 'День');
  static EPeriod week = EPeriod(2, 'Неделя');
  static EPeriod month = EPeriod(3, 'Месяц');
  static EPeriod year = EPeriod(4, 'Год');

  EPeriod(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, EPeriod>{
      0: all,
      1: day,
      2: week,
      3: month,
      4: year,
    };
  }
}
