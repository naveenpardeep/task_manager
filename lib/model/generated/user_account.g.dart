//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// АккаунтПользователя
class UserAccountGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameLastChange = 'lastChange';

  static final Map<String, String> fieldNameDict = {
   nameName: 'Наименование',
 };

  @override
  String get typeName => 'UserAccount';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataDateField(nameLastChange), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => UserAccount();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// ПоследнееИзменение
  DateTime get lastChange => getFieldValue(nameLastChange) as DateTime;

  set lastChange(DateTime value) => setFieldValue(nameLastChange, value);

  @override
  String get apiRequestItems {
    return '/Data/UserAccount';
  }
}
