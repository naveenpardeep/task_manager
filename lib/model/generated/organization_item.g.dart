//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// Организации
class OrganizationItemGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameTableUsers = 'tableUsers';

  static final Map<String, String> fieldNameDict = {
    nameName: 'Наименование',
  };

  @override
  String get typeName => 'OrganizationItem';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataReferenceListField<OrganizationItemUserTable>(nameTableUsers), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
  }

  @override
  String toString() => name;

  @override
  bool get createOnServer => true;

  @override
  NsgDataItem getNewObject() => OrganizationItem();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// Сотрудники
  NsgDataTable<OrganizationItemUserTable> get tableUsers => NsgDataTable<OrganizationItemUserTable>(owner: this, fieldName: nameTableUsers);


  @override
  String get apiRequestItems {
    return '/Data/Organization';
  }
}
