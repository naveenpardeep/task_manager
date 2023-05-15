//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';
import '../enums.dart';

/// Служебный объект
class ServiceObjectGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameProjectId = 'projectId';
  static const nameSprintId = 'sprintId';
  static const nameTaskStatusId = 'taskStatusId';
  static const nameTableComments = 'tableComments';
  static const nameCheckList = 'checkList';
  static const nameFiles = 'files';
  static const namePriority = 'priority';
  static const nameBoardId = 'boardId';
  static const nameTaskTypeId = 'taskTypeId';
  static const nameUserAccountId = 'userAccountId';

  static final Map<String, String> fieldNameDict = {
  };

  @override
  String get typeName => 'ServiceObject';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataReferenceField<ProjectItem>(nameProjectId), primaryKey: false);
    addField(NsgDataReferenceField<SprintDoc>(nameSprintId), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameTaskStatusId), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocCommentsTable>(nameTableComments), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocCheckListTable>(nameCheckList), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocFilesTable>(nameFiles), primaryKey: false);
    addField(NsgDataEnumReferenceField<EPriority>(namePriority), primaryKey: false);
    addField(NsgDataReferenceField<TaskBoard>(nameBoardId), primaryKey: false);
    addField(NsgDataReferenceField<TaskType>(nameTaskTypeId), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameUserAccountId), primaryKey: false);
  }

  @override
  NsgDataItem getNewObject() => ServiceObject();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Проект
  String get projectId => getFieldValue(nameProjectId).toString();
  ProjectItem get project => getReferent<ProjectItem>(nameProjectId);
  Future<ProjectItem> projectAsync() async {
   return await getReferentAsync<ProjectItem>(nameProjectId);
  }

  set projectId(String value) => setFieldValue(nameProjectId, value);
  set project(ProjectItem value) =>
    setFieldValue(nameProjectId, value.id);

  /// Спринт
  String get sprintId => getFieldValue(nameSprintId).toString();
  SprintDoc get sprint => getReferent<SprintDoc>(nameSprintId);
  Future<SprintDoc> sprintAsync() async {
   return await getReferentAsync<SprintDoc>(nameSprintId);
  }

  set sprintId(String value) => setFieldValue(nameSprintId, value);
  set sprint(SprintDoc value) =>
    setFieldValue(nameSprintId, value.id);

  /// СтатусЗадачи
  String get taskStatusId => getFieldValue(nameTaskStatusId).toString();
  TaskStatus get taskStatus => getReferent<TaskStatus>(nameTaskStatusId);
  Future<TaskStatus> taskStatusAsync() async {
   return await getReferentAsync<TaskStatus>(nameTaskStatusId);
  }

  set taskStatusId(String value) => setFieldValue(nameTaskStatusId, value);
  set taskStatus(TaskStatus value) =>
    setFieldValue(nameTaskStatusId, value.id);

  /// ТаблицаКомментарии
  NsgDataTable<TaskDocCommentsTable> get tableComments => NsgDataTable<TaskDocCommentsTable>(owner: this, fieldName: nameTableComments);


  /// ЧекЛист
  NsgDataTable<TaskDocCheckListTable> get checkList => NsgDataTable<TaskDocCheckListTable>(owner: this, fieldName: nameCheckList);


  /// ТаблицаФайлы
  NsgDataTable<TaskDocFilesTable> get files => NsgDataTable<TaskDocFilesTable>(owner: this, fieldName: nameFiles);


  /// Приоритет
  EPriority get priority => NsgEnum.fromValue(EPriority, getFieldValue(namePriority)) as EPriority;

  set priority(EPriority value) => setFieldValue(namePriority, value);

  /// Доска
  String get boardId => getFieldValue(nameBoardId).toString();
  TaskBoard get board => getReferent<TaskBoard>(nameBoardId);
  Future<TaskBoard> boardAsync() async {
   return await getReferentAsync<TaskBoard>(nameBoardId);
  }

  set boardId(String value) => setFieldValue(nameBoardId, value);
  set board(TaskBoard value) =>
    setFieldValue(nameBoardId, value.id);

  /// Доска
  String get taskTypeId => getFieldValue(nameTaskTypeId).toString();
  TaskType get taskType => getReferent<TaskType>(nameTaskTypeId);
  Future<TaskType> taskTypeAsync() async {
   return await getReferentAsync<TaskType>(nameTaskTypeId);
  }

  set taskTypeId(String value) => setFieldValue(nameTaskTypeId, value);
  set taskType(TaskType value) =>
    setFieldValue(nameTaskTypeId, value.id);

  /// АккаунтПользователя
  String get userAccountId => getFieldValue(nameUserAccountId).toString();
  UserAccount get userAccount => getReferent<UserAccount>(nameUserAccountId);
  Future<UserAccount> userAccountAsync() async {
   return await getReferentAsync<UserAccount>(nameUserAccountId);
  }

  set userAccountId(String value) => setFieldValue(nameUserAccountId, value);
  set userAccount(UserAccount value) =>
    setFieldValue(nameUserAccountId, value.id);

  @override
  String get apiRequestItems {
    return '/Data/ServiceObject';
  }
}
