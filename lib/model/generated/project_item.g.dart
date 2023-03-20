//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// Проекты
class ProjectItemGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameDate = 'date';
  static const nameStatusDoneId = 'statusDoneId';
  static const nameStatusCancelledId = 'statusCancelledId';
  static const nameOrganizationId = 'organizationId';
  static const nameProjectPrefix = 'projectPrefix';
  static const nameLeaderId = 'leaderId';
  static const nameContractor = 'contractor';
  static const namePhotoPath = 'photoPath';
  static const namePhotoFile = 'photoFile';
  static const nameNumberOfTasksOpen = 'numberOfTasksOpen';
  static const nameNumberOfTasksUpdatedIn24Hours = 'numberOfTasksUpdatedIn24Hours';
  static const nameNumberOfTasksOverdue = 'numberOfTasksOverdue';
  static const nameNumberOfNotifications = 'numberOfNotifications';
  static const nameIsPinned = 'isPinned';
  static const namePriority = 'priority';
  static const nameTableUsers = 'tableUsers';

  static final Map<String, String> fieldNameDict = {
    nameName: 'Наименование',
    nameDate: 'Дата создания',
  };

  @override
  String get typeName => 'ProjectItem';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataDateField(nameDate), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameStatusDoneId), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameStatusCancelledId), primaryKey: false);
    addField(NsgDataReferenceField<OrganizationItem>(nameOrganizationId), primaryKey: false);
    addField(NsgDataStringField(nameProjectPrefix, maxLength: 15), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameLeaderId), primaryKey: false);
    addField(NsgDataStringField(nameContractor), primaryKey: false);
    addField(NsgDataStringField(namePhotoPath), primaryKey: false);
    addField(NsgDataBinaryField(namePhotoFile), primaryKey: false);
    addField(NsgDataIntField(nameNumberOfTasksOpen), primaryKey: false);
    addField(NsgDataIntField(nameNumberOfTasksUpdatedIn24Hours), primaryKey: false);
    addField(NsgDataIntField(nameNumberOfTasksOverdue), primaryKey: false);
    addField(NsgDataIntField(nameNumberOfNotifications), primaryKey: false);
    addField(NsgDataBoolField(nameIsPinned), primaryKey: false);
    addField(NsgDataIntField(namePriority), primaryKey: false);
    addField(NsgDataReferenceListField<ProjectItemUserTable>(nameTableUsers), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
    fieldList.fields[nameDate]?.presentation = 'Дата создания';
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => ProjectItem();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// ДатаСоздания
  DateTime get date => getFieldValue(nameDate) as DateTime;

  set date(DateTime value) => setFieldValue(nameDate, value);

  /// СтатусЗавершения
  String get statusDoneId => getFieldValue(nameStatusDoneId).toString();
  TaskStatus get statusDone => getReferent<TaskStatus>(nameStatusDoneId);
  Future<TaskStatus> statusDoneAsync() async {
   return await getReferentAsync<TaskStatus>(nameStatusDoneId);
  }

  set statusDoneId(String value) => setFieldValue(nameStatusDoneId, value);
  set statusDone(TaskStatus value) =>
    setFieldValue(nameStatusDoneId, value.id);

  /// СтатусОтмены
  String get statusCancelledId => getFieldValue(nameStatusCancelledId).toString();
  TaskStatus get statusCancelled => getReferent<TaskStatus>(nameStatusCancelledId);
  Future<TaskStatus> statusCancelledAsync() async {
   return await getReferentAsync<TaskStatus>(nameStatusCancelledId);
  }

  set statusCancelledId(String value) => setFieldValue(nameStatusCancelledId, value);
  set statusCancelled(TaskStatus value) =>
    setFieldValue(nameStatusCancelledId, value.id);

  /// Организация
  String get organizationId => getFieldValue(nameOrganizationId).toString();
  OrganizationItem get organization => getReferent<OrganizationItem>(nameOrganizationId);
  Future<OrganizationItem> organizationAsync() async {
   return await getReferentAsync<OrganizationItem>(nameOrganizationId);
  }

  set organizationId(String value) => setFieldValue(nameOrganizationId, value);
  set organization(OrganizationItem value) =>
    setFieldValue(nameOrganizationId, value.id);

  /// ПрефиксПроекта
  String get projectPrefix => getFieldValue(nameProjectPrefix).toString();

  set projectPrefix(String value) => setFieldValue(nameProjectPrefix, value);

  /// Руководитель
  String get leaderId => getFieldValue(nameLeaderId).toString();
  UserAccount get leader => getReferent<UserAccount>(nameLeaderId);
  Future<UserAccount> leaderAsync() async {
   return await getReferentAsync<UserAccount>(nameLeaderId);
  }

  set leaderId(String value) => setFieldValue(nameLeaderId, value);
  set leader(UserAccount value) =>
    setFieldValue(nameLeaderId, value.id);

  /// Заказчик
  String get contractor => getFieldValue(nameContractor).toString();

  set contractor(String value) => setFieldValue(nameContractor, value);

  /// КартинкаПуть
  String get photoPath => getFieldValue(namePhotoPath).toString();

  set photoPath(String value) => setFieldValue(namePhotoPath, value);

  /// Картинка
  List<int> get photoFile {
    return getFieldValue(namePhotoFile) as List<int>;
  }

  set photoFile(List<int> value) => setFieldValue(namePhotoFile, value);

  /// Количество открытых задач пользователя
  int get numberOfTasksOpen => getFieldValue(nameNumberOfTasksOpen) as int;

  set numberOfTasksOpen(int value) => setFieldValue(nameNumberOfTasksOpen, value);

  /// Количество задач пользователя, обновленных за последные сутки
  int get numberOfTasksUpdatedIn24Hours => getFieldValue(nameNumberOfTasksUpdatedIn24Hours) as int;

  set numberOfTasksUpdatedIn24Hours(int value) => setFieldValue(nameNumberOfTasksUpdatedIn24Hours, value);

  /// Количество просроченных задач пользователя
  int get numberOfTasksOverdue => getFieldValue(nameNumberOfTasksOverdue) as int;

  set numberOfTasksOverdue(int value) => setFieldValue(nameNumberOfTasksOverdue, value);

  /// Количество новых уведомлений пользователя по проекту
  int get numberOfNotifications => getFieldValue(nameNumberOfNotifications) as int;

  set numberOfNotifications(int value) => setFieldValue(nameNumberOfNotifications, value);

  /// Закреплен
  bool get isPinned => getFieldValue(nameIsPinned) as bool;

  set isPinned(bool value) => setFieldValue(nameIsPinned, value);

  /// Приоритет
  int get priority => getFieldValue(namePriority) as int;

  set priority(int value) => setFieldValue(namePriority, value);

  /// ТаблицаПользователи
  NsgDataTable<ProjectItemUserTable> get tableUsers => NsgDataTable<ProjectItemUserTable>(owner: this, fieldName: nameTableUsers);


  @override
  String get apiRequestItems {
    return '/Data/Project';
  }
}
