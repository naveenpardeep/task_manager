//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// ИсторияИзменений
class BackupDocGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameDate = 'date';
  static const nameDocNumber = 'docNumber';
  static const nameObjectId = 'objectId';
  static const nameAuthorId = 'authorId';
  static const nameCallstack = 'callstack';
  static const nameFootnote = 'footnote';
  static const nameObjectValues = 'objectValues';

  static final Map<String, String> fieldNameDict = {
  };

  @override
  String get typeName => 'BackupDoc';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataDateField(nameDate), primaryKey: false);
    addField(NsgDataStringField(nameDocNumber), primaryKey: false);
    addField(NsgDataStringField(nameObjectId), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameAuthorId), primaryKey: false);
    addField(NsgDataStringField(nameCallstack), primaryKey: false);
    addField(NsgDataStringField(nameFootnote), primaryKey: false);
    addField(NsgDataReferenceListField<BackupDocValuesTable>(nameObjectValues), primaryKey: false);
  }

  @override
  NsgDataItem getNewObject() => BackupDoc();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// ДатаДокумента
  DateTime get date => getFieldValue(nameDate) as DateTime;

  set date(DateTime value) => setFieldValue(nameDate, value);

  /// НомерДокумента
  String get docNumber => getFieldValue(nameDocNumber).toString();

  set docNumber(String value) => setFieldValue(nameDocNumber, value);

  /// Объект
  String get objectId => getFieldValue(nameObjectId).toString();

  set objectId(String value) => setFieldValue(nameObjectId, value);

  /// АвторИзмененийАккаунт
  String get authorId => getFieldValue(nameAuthorId).toString();
  UserAccount get author => getReferent<UserAccount>(nameAuthorId);
  Future<UserAccount> authorAsync() async {
   return await getReferentAsync<UserAccount>(nameAuthorId);
  }

  set authorId(String value) => setFieldValue(nameAuthorId, value);
  set author(UserAccount value) =>
    setFieldValue(nameAuthorId, value.id);

  /// СтекВызовов
  String get callstack => getFieldValue(nameCallstack).toString();

  set callstack(String value) => setFieldValue(nameCallstack, value);

  /// Комментарий
  String get footnote => getFieldValue(nameFootnote).toString();

  set footnote(String value) => setFieldValue(nameFootnote, value);

  /// Значения
  NsgDataTable<BackupDocValuesTable> get objectValues => NsgDataTable<BackupDocValuesTable>(owner: this, fieldName: nameObjectValues);

  @override
  String get apiRequestItems {
    return '/Data/BackupDoc';
  }
}
