//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// СтатусыЗадач.СтатусыПерехода
class TaskStatusTransitionTableGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameOwnerId = 'ownerId';
  static const nameStatusId = 'statusId';

  static final Map<String, String> fieldNameDict = {
 };

  @override
  String get typeName => 'TaskStatusTransitionTable';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataReferenceField<TaskStatus>(nameOwnerId), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameStatusId), primaryKey: false);
  }

  @override
  NsgDataItem getNewObject() => TaskStatusTransitionTable();

  /// Guid - идентификатор объета
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Guid - идентификатор владельца
  @override
  String get ownerId => getFieldValue(nameOwnerId).toString();
  TaskStatus get owner => getReferent<TaskStatus>(nameOwnerId);
  Future<TaskStatus> ownerAsync() async {
   return await getReferentAsync<TaskStatus>(nameOwnerId);
  }

  @override
  set ownerId(String value) => setFieldValue(nameOwnerId, value);
  set owner(TaskStatus value) =>
    setFieldValue(nameOwnerId, value.id);

  /// Статус
  String get statusId => getFieldValue(nameStatusId).toString();
  TaskStatus get status => getReferent<TaskStatus>(nameStatusId);
  Future<TaskStatus> statusAsync() async {
   return await getReferentAsync<TaskStatus>(nameStatusId);
  }

  set statusId(String value) => setFieldValue(nameStatusId, value);
  set status(TaskStatus value) =>
    setFieldValue(nameStatusId, value.id);

  @override
  String get apiRequestItems {
    return '/Data/TaskStatusTransitionTable';
  }
}
