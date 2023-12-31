//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// НастройкиПроектов
class UserProjectSettingsGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameUserAccountId = 'userAccountId';
  static const nameProjectId = 'projectId';
  static const nameIsPinned = 'isPinned';
  static const namePriority = 'priority';

  static final Map<String, String> fieldNameDict = {
    nameName: 'Наименование',
  };

  @override
  String get typeName => 'UserProjectSettings';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameUserAccountId), primaryKey: false);
    addField(NsgDataReferenceField<ProjectItem>(nameProjectId), primaryKey: false);
    addField(NsgDataBoolField(nameIsPinned), primaryKey: false);
    addField(NsgDataIntField(namePriority), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => UserProjectSettings();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// АккаунтПользователя
  String get userAccountId => getFieldValue(nameUserAccountId).toString();
  UserAccount get userAccount => getReferent<UserAccount>(nameUserAccountId);
  Future<UserAccount> userAccountAsync() async {
   return await getReferentAsync<UserAccount>(nameUserAccountId);
  }

  set userAccountId(String value) => setFieldValue(nameUserAccountId, value);
  set userAccount(UserAccount value) =>
    setFieldValue(nameUserAccountId, value.id);

  /// Проект
  String get projectId => getFieldValue(nameProjectId).toString();
  ProjectItem get project => getReferent<ProjectItem>(nameProjectId);
  Future<ProjectItem> projectAsync() async {
   return await getReferentAsync<ProjectItem>(nameProjectId);
  }

  set projectId(String value) => setFieldValue(nameProjectId, value);
  set project(ProjectItem value) =>
    setFieldValue(nameProjectId, value.id);

  /// Закреплен
  bool get isPinned => getFieldValue(nameIsPinned) as bool;

  set isPinned(bool value) => setFieldValue(nameIsPinned, value);

  /// Приоритет
  int get priority => getFieldValue(namePriority) as int;

  set priority(int value) => setFieldValue(namePriority, value);

  @override
  String get apiRequestItems {
    return '/Data/UserProjectSettings';
  }
}
