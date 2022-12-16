//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';
import '../enums.dart';

/// Задача
class TaskDocGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameDate = 'date';
  static const nameDateClosed = 'dateClosed';
  static const nameDateUpdated = 'dateUpdated';
  static const nameComment = 'comment';
  static const nameDescription = 'description';
  static const nameText = 'text';
  static const nameProjectId = 'projectId';
  static const nameSprintId = 'sprintId';
  static const nameTaskStatusId = 'taskStatusId';
  static const nameComments = 'comments';
  static const nameCheckList = 'checkList';
  static const nameFiles = 'files';
  static const nameAuthorId = 'authorId';
  static const nameAssigneeId = 'assigneeId';
  static const namePriority = 'priority';

  static final Map<String, String> fieldNameDict = {
   nameDate: 'Дата документа',
   nameDateClosed: 'Дата закрытия',
   nameDateUpdated: 'Дата обновления',
   nameComment: 'Комментарий',
   nameDescription: 'Описание задачи',
   nameText: 'Текст задачи',
 };

  @override
  String get typeName => 'TaskDoc';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataDateField(nameDate), primaryKey: false);
    addField(NsgDataDateField(nameDateClosed), primaryKey: false);
    addField(NsgDataDateField(nameDateUpdated), primaryKey: false);
    addField(NsgDataStringField(nameComment), primaryKey: false);
    addField(NsgDataStringField(nameDescription), primaryKey: false);
    addField(NsgDataStringField(nameText), primaryKey: false);
    addField(NsgDataReferenceField<ProjectItem>(nameProjectId), primaryKey: false);
    addField(NsgDataReferenceField<SprintDoc>(nameSprintId), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameTaskStatusId), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocCommentsTable>(nameComments), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocCheckListTable>(nameCheckList), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocFilesTable>(nameFiles), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameAuthorId), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameAssigneeId), primaryKey: false);
    addField(NsgDataEnumReferenceField<EPriority>(namePriority), primaryKey: false);
    fieldList.fields[nameDate]?.presentation = 'Дата документа';
    fieldList.fields[nameDateClosed]?.presentation = 'Дата закрытия';
    fieldList.fields[nameDateUpdated]?.presentation = 'Дата обновления';
    fieldList.fields[nameComment]?.presentation = 'Комментарий';
    fieldList.fields[nameDescription]?.presentation = 'Описание задачи';
    fieldList.fields[nameText]?.presentation = 'Текст задачи';
  }

  @override
  NsgDataItem getNewObject() => TaskDoc();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// ДатаДокумента
  DateTime get date => getFieldValue(nameDate) as DateTime;

  set date(DateTime value) => setFieldValue(nameDate, value);

  /// ДатаЗакрытия
  DateTime get dateClosed => getFieldValue(nameDateClosed) as DateTime;

  set dateClosed(DateTime value) => setFieldValue(nameDateClosed, value);

  /// ДатаОбновления
  DateTime get dateUpdated => getFieldValue(nameDateUpdated) as DateTime;

  set dateUpdated(DateTime value) => setFieldValue(nameDateUpdated, value);

  /// Комментарий
  String get comment => getFieldValue(nameComment).toString();

  set comment(String value) => setFieldValue(nameComment, value);

  /// ОписаниеЗадачи
  String get description => getFieldValue(nameDescription).toString();

  set description(String value) => setFieldValue(nameDescription, value);

  /// ТекстЗадачи
  String get text => getFieldValue(nameText).toString();

  set text(String value) => setFieldValue(nameText, value);

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

  /// Комментарии
  NsgDataTable<TaskDocCommentsTable> get comments => NsgDataTable<TaskDocCommentsTable>(owner: this, fieldName: nameComments);


  /// ЧекЛист
  NsgDataTable<TaskDocCheckListTable> get checkList => NsgDataTable<TaskDocCheckListTable>(owner: this, fieldName: nameCheckList);


  /// ТаблицаФайлы
  NsgDataTable<TaskDocFilesTable> get files => NsgDataTable<TaskDocFilesTable>(owner: this, fieldName: nameFiles);


  /// Автор
  String get authorId => getFieldValue(nameAuthorId).toString();
  UserAccount get author => getReferent<UserAccount>(nameAuthorId);
  Future<UserAccount> authorAsync() async {
   return await getReferentAsync<UserAccount>(nameAuthorId);
  }

  set authorId(String value) => setFieldValue(nameAuthorId, value);
  set author(UserAccount value) =>
    setFieldValue(nameAuthorId, value.id);

  /// Исполнитель
  String get assigneeId => getFieldValue(nameAssigneeId).toString();
  UserAccount get assignee => getReferent<UserAccount>(nameAssigneeId);
  Future<UserAccount> assigneeAsync() async {
   return await getReferentAsync<UserAccount>(nameAssigneeId);
  }

  set assigneeId(String value) => setFieldValue(nameAssigneeId, value);
  set assignee(UserAccount value) =>
    setFieldValue(nameAssigneeId, value.id);

  /// Приоритет
  EPriority get priority => NsgEnum.fromValue(EPriority, getFieldValue(namePriority)) as EPriority;

  set priority(EPriority value) => setFieldValue(namePriority, value);

  @override
  String get apiRequestItems {
    return '/Data/TaskDoc';
  }
}
