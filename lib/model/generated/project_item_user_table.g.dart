//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// Таблица
class ProjectItemUserTableGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameOwnerId = 'ownerId';
  static const nameUserAccountId = 'userAccountId';
  static const nameUserEmail = 'userEmail';
  static const nameUserPhone = 'userPhone';
  static const nameRoleId = 'roleId';
  static const nameIsAdmin = 'isAdmin';

  static final Map<String, String> fieldNameDict = {
  };

  @override
  String get typeName => 'ProjectItemUserTable';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataReferenceField<ProjectItem>(nameOwnerId), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameUserAccountId), primaryKey: false);
    addField(NsgDataStringField(nameUserEmail), primaryKey: false);
    addField(NsgDataStringField(nameUserPhone), primaryKey: false);
    addField(NsgDataReferenceField<UserRole>(nameRoleId), primaryKey: false);
    addField(NsgDataBoolField(nameIsAdmin), primaryKey: false);
  }

  @override
  NsgDataItem getNewObject() => ProjectItemUserTable();

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

  /// АккаунтПользователя
  String get userAccountId => getFieldValue(nameUserAccountId).toString();
  UserAccount get userAccount => getReferent<UserAccount>(nameUserAccountId);
  Future<UserAccount> userAccountAsync() async {
   return await getReferentAsync<UserAccount>(nameUserAccountId);
  }

  set userAccountId(String value) => setFieldValue(nameUserAccountId, value);
  set userAccount(UserAccount value) =>
    setFieldValue(nameUserAccountId, value.id);

  /// АккаунтПользователя.Email
  String get userEmail => getFieldValue(nameUserEmail).toString();

  set userEmail(String value) => setFieldValue(nameUserEmail, value);

  /// АккаунтПользователя.НомерТелефона
  String get userPhone => getFieldValue(nameUserPhone).toString();

  set userPhone(String value) => setFieldValue(nameUserPhone, value);

  /// Роль
  String get roleId => getFieldValue(nameRoleId).toString();
  UserRole get role => getReferent<UserRole>(nameRoleId);
  Future<UserRole> roleAsync() async {
   return await getReferentAsync<UserRole>(nameRoleId);
  }

  set roleId(String value) => setFieldValue(nameRoleId, value);
  set role(UserRole value) =>
    setFieldValue(nameRoleId, value.id);

  /// ЭтоАдминистратор
  bool get isAdmin => getFieldValue(nameIsAdmin) as bool;

  set isAdmin(bool value) => setFieldValue(nameIsAdmin, value);

  @override
  String get apiRequestItems {
    return '/Data/ProjectItemUserTable';
  }
}
