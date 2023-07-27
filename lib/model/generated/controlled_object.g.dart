//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// ОбъектыКонтроля
class ControlledObjectGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameConditionCountdown = 'conditionCountdown';

  static final Map<String, String> fieldNameDict = {
    nameName: 'Наименование',
    nameConditionCountdown: 'Обратный отсчет состояния',
  };

  @override
  String get typeName => 'ControlledObject';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataBoolField(nameConditionCountdown), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
    fieldList.fields[nameConditionCountdown]?.presentation = 'Обратный отсчет состояния';
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => ControlledObject();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// ОбратныйОтсчетСостояния
  bool get conditionCountdown => getFieldValue(nameConditionCountdown) as bool;

  set conditionCountdown(bool value) => setFieldValue(nameConditionCountdown, value);

  @override
  String get apiRequestItems {
    return '/Data/ControlledObject';
  }
}
