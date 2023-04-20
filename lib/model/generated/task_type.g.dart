//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// ТипЗадачи
class TaskTypeGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameOwnerId = 'ownerId';
  static const nameName = 'name';

  static final Map<String, String> fieldNameDict = {
  };

  @override
  String get typeName => 'TaskType';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataReferenceField<ProjectItem>(nameOwnerId), primaryKey: false);
    addField(NsgDataStringField(nameName), primaryKey: false);
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => TaskType();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Владелец
  @override
  String get ownerId => getFieldValue(nameOwnerId).toString();
  ProjectItem get owner => getReferent<ProjectItem>(nameOwnerId);
  Future<ProjectItem> ownerAsync() async {
   return await getReferentAsync<ProjectItem>(nameOwnerId);
  }

  @override
  set ownerId(String value) => setFieldValue(nameOwnerId, value);
  set owner(ProjectItem value) =>
    setFieldValue(nameOwnerId, value.id);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  @override
  String get apiRequestItems {
    return '/Data/TaskType';
  }
}
