//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// Спринт
class SprintDocGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameOrganizationId = 'organizationId';
  static const nameTaskTable = 'taskTable';

  static final Map<String, String> fieldNameDict = {
    nameName: 'Комментарий',
  };

  @override
  String get typeName => 'SprintDoc';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataReferenceField<OrganizationItem>(nameOrganizationId), primaryKey: false);
    addField(NsgDataReferenceListField<SprintDocTaskTable>(nameTaskTable), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Комментарий';
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => SprintDoc();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Комментарий
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// Организация
  String get organizationId => getFieldValue(nameOrganizationId).toString();
  OrganizationItem get organization => getReferent<OrganizationItem>(nameOrganizationId);
  Future<OrganizationItem> organizationAsync() async {
   return await getReferentAsync<OrganizationItem>(nameOrganizationId);
  }

  set organizationId(String value) => setFieldValue(nameOrganizationId, value);
  set organization(OrganizationItem value) =>
    setFieldValue(nameOrganizationId, value.id);

  /// ТаблицаЗадач
  NsgDataTable<SprintDocTaskTable> get taskTable => NsgDataTable<SprintDocTaskTable>(owner: this, fieldName: nameTaskTable);

  @override
  String get apiRequestItems {
    return '/Data/SprintDoc';
  }
}
