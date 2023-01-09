//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// Задача.ТаблицаКомментарии
class TaskDocCommentsTableGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameOwnerId = 'ownerId';
  static const nameText = 'text';
  static const nameDate = 'date';
  static const nameAuthorId = 'authorId';

  static final Map<String, String> fieldNameDict = {
    nameText: 'Текст',
    nameDate: 'Дата комментария',
  };

  @override
  String get typeName => 'TaskDocCommentsTable';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataReferenceField<TaskDoc>(nameOwnerId), primaryKey: false);
    addField(NsgDataStringField(nameText, maxLength: 200), primaryKey: false);
    addField(NsgDataDateField(nameDate), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameAuthorId), primaryKey: false);
    fieldList.fields[nameText]?.presentation = 'Текст';
    fieldList.fields[nameDate]?.presentation = 'Дата комментария';
  }

  @override
  NsgDataItem getNewObject() => TaskDocCommentsTable();

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

  /// Комментарий
  String get text => getFieldValue(nameText).toString();

  set text(String value) => setFieldValue(nameText, value);

  /// ДатаКомментария
  DateTime get date => getFieldValue(nameDate) as DateTime;

  set date(DateTime value) => setFieldValue(nameDate, value);

  /// Автор
  String get authorId => getFieldValue(nameAuthorId).toString();
  UserAccount get author => getReferent<UserAccount>(nameAuthorId);
  Future<UserAccount> authorAsync() async {
   return await getReferentAsync<UserAccount>(nameAuthorId);
  }

  set authorId(String value) => setFieldValue(nameAuthorId, value);
  set author(UserAccount value) =>
    setFieldValue(nameAuthorId, value.id);

  @override
  String get apiRequestItems {
    return '/Data/TaskDocCommentsTable';
  }
}
