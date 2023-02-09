import 'package:nsg_data/nsg_data.dart';

/// Период
class EPeriod extends NsgEnum {
  static EPeriod day = EPeriod(0, 'День');
  static EPeriod week = EPeriod(1, 'Неделя');
  static EPeriod month = EPeriod(2, 'Месяц');
  static EPeriod year = EPeriod(3, 'Год');
  static EPeriod all = EPeriod(4, 'Все');

  EPeriod(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, EPeriod>{
      0: day,
      1: week,
      2: month,
      3: year,
      4: all,
    };
  }
}
