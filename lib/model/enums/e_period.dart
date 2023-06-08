import 'package:nsg_data/nsg_data.dart';

/// Период
class EPeriod extends NsgEnum {
  static EPeriod all = EPeriod(0, 'Все');
  static EPeriod day = EPeriod(2, 'День');
  static EPeriod week = EPeriod(3, 'Неделя');
  static EPeriod month = EPeriod(4, 'Месяц');
  static EPeriod year = EPeriod(5, 'Год');

  EPeriod(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, EPeriod>{
      0: all,
      2: day,
      3: week,
      4: month,
      5: year,
    };
  }
}
