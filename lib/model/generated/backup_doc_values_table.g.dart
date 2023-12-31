//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// ИсторияИзменений.Значения
class BackupDocValuesTableGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameOwnerId = 'ownerId';
  static const nameStringValue = 'stringValue';
  static const nameNumericValue = 'numericValue';
  static const nameReferenceValue = 'referenceValue';

  static final Map<String, String> fieldNameDict = {
  };

  @override
  String get typeName => 'BackupDocValuesTable';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataReferenceField<BackupDoc>(nameOwnerId), primaryKey: false);
    addField(NsgDataStringField(nameStringValue), primaryKey: false);
    addField(NsgDataDoubleField(nameNumericValue), primaryKey: false);
    addField(NsgDataStringField(nameReferenceValue), primaryKey: false);
  }

  @override
  NsgDataItem getNewObject() => BackupDocValuesTable();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Владелец
  @override
  String get ownerId => getFieldValue(nameOwnerId).toString();
  BackupDoc get owner => getReferent<BackupDoc>(nameOwnerId);
  Future<BackupDoc> ownerAsync() async {
   return await getReferentAsync<BackupDoc>(nameOwnerId);
  }

  @override
  set ownerId(String value) => setFieldValue(nameOwnerId, value);
  set owner(BackupDoc value) =>
    setFieldValue(nameOwnerId, value.id);

  /// ЗначениеСтрока
  String get stringValue => getFieldValue(nameStringValue).toString();

  set stringValue(String value) => setFieldValue(nameStringValue, value);

  /// ЗначениеЧисло
  double get numericValue => getFieldValue(nameNumericValue) as double;

  set numericValue(double value) => setFieldValue(nameNumericValue, value);

  /// ЗначениеСсылка
  String get referenceValue => getFieldValue(nameReferenceValue).toString();

  set referenceValue(String value) => setFieldValue(nameReferenceValue, value);

  @override
  String get apiRequestItems {
    return '/Data/BackupDocValuesTable';
  }
}
