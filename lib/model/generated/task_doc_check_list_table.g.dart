//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// Таблица
class TaskDocCheckListTableGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameOwnerId = 'ownerId';
  static const nameText = 'text';
  static const nameIsDone = 'isDone';

  static final Map<String, String> fieldNameDict = {
    nameText: 'Сделать',
    nameIsDone: 'Выполнено',
  };

  @override
  String get typeName => 'TaskDocCheckListTable';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataReferenceField<TaskDoc>(nameOwnerId), primaryKey: false);
    addField(NsgDataStringField(nameText), primaryKey: false);
    addField(NsgDataBoolField(nameIsDone), primaryKey: false);
    fieldList.fields[nameText]?.presentation = 'Сделать';
    fieldList.fields[nameIsDone]?.presentation = 'Выполнено';
  }

  @override
  NsgDataItem getNewObject() => TaskDocCheckListTable();

  /// Guid - идентификатор объета
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Guid - идентификатор владельца
  @override
  String get ownerId => getFieldValue(nameOwnerId).toString();
  TaskDoc get owner => getReferent<TaskDoc>(nameOwnerId);
  Future<TaskDoc> ownerAsync() async {
   return await getReferentAsync<TaskDoc>(nameOwnerId);
  }

  @override
  set ownerId(String value) => setFieldValue(nameOwnerId, value);
  set owner(TaskDoc value) =>
    setFieldValue(nameOwnerId, value.id);

  /// Сделать
  String get text => getFieldValue(nameText).toString();

  set text(String value) => setFieldValue(nameText, value);

  /// Выполнено
  bool get isDone => getFieldValue(nameIsDone) as bool;

  set isDone(bool value) => setFieldValue(nameIsDone, value);

  @override
  String get apiRequestItems {
    return '/Data/TaskDocCheckListTable';
  }
}
