import 'package:nsg_data/nsg_data.dart';

/// Периодичность задач
class ETaskPeriodicity extends NsgEnum {
  static ETaskPeriodicity hour = ETaskPeriodicity(1, 'Час');
  static ETaskPeriodicity day = ETaskPeriodicity(2, 'День');
  static ETaskPeriodicity week = ETaskPeriodicity(3, 'Неделя');
  static ETaskPeriodicity month = ETaskPeriodicity(4, 'Месяц');
  static ETaskPeriodicity year = ETaskPeriodicity(5, 'Год');

  ETaskPeriodicity(dynamic value, String name) : super(value: value, name: name);

  @override
  void initialize() {
    NsgEnum.listAllValues[runtimeType] = <int, ETaskPeriodicity>{
      1: hour,
      2: day,
      3: week,
      4: month,
      5: year,
    };
  }
}
