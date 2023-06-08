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
  static const nameDocNumber = 'docNumber';
  static const nameTaskNumber = 'taskNumber';
  static const nameDateClosed = 'dateClosed';
  static const nameDateUpdated = 'dateUpdated';
  static const nameDateRemind = 'dateRemind';
  static const nameDateDeadline = 'dateDeadline';
  static const nameDescription = 'description';
  static const nameName = 'name';
  static const nameFootnote = 'footnote';
  static const nameProjectId = 'projectId';
  static const nameSprintId = 'sprintId';
  static const nameTaskTypeId = 'taskTypeId';
  static const nameTaskStatusId = 'taskStatusId';
  static const nameTableComments = 'tableComments';
  static const nameCheckList = 'checkList';
  static const nameFiles = 'files';
  static const nameAuthorId = 'authorId';
  static const nameAssigneeId = 'assigneeId';
  static const nameIsReadByAssignee = 'isReadByAssignee';
  static const namePriority = 'priority';
  static const nameTotalComments = 'totalComments';
  static const nameBaseDocumentId = 'baseDocumentId';
  static const nameIsPeriodic = 'isPeriodic';
  static const namePeriodicInterval = 'periodicInterval';
  static const namePeriodicIntervalUnit = 'periodicIntervalUnit';
  static const namePeriodicNumberOfIterations = 'periodicNumberOfIterations';
  static const namePeriodicActualUntil = 'periodicActualUntil';
  static const namePeriodicLastClosed = 'periodicLastClosed';
  static const namePeriodicTimeLimit = 'periodicTimeLimit';
  static const namePeriodicTimeLimitlUnit = 'periodicTimeLimitlUnit';

  static final Map<String, String> fieldNameDict = {
    nameDate: 'Дата документа',
    nameDocNumber: 'Номер документа',
    nameTaskNumber: 'Номер задачи',
    nameDateClosed: 'Дата закрытия',
    nameDateUpdated: 'Дата обновления',
    nameDateRemind: 'Дата напоминания',
    nameDateDeadline: 'Срок выполнения',
    nameDescription: 'Описание задачи',
    nameName: 'Наименование',
    nameFootnote: 'Комментарий',
  };

  @override
  String get typeName => 'TaskDoc';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataDateField(nameDate), primaryKey: false);
    addField(NsgDataStringField(nameDocNumber), primaryKey: false);
    addField(NsgDataIntField(nameTaskNumber), primaryKey: false);
    addField(NsgDataDateField(nameDateClosed), primaryKey: false);
    addField(NsgDataDateField(nameDateUpdated), primaryKey: false);
    addField(NsgDataDateField(nameDateRemind), primaryKey: false);
    addField(NsgDataDateField(nameDateDeadline), primaryKey: false);
    addField(NsgDataStringField(nameDescription), primaryKey: false);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataStringField(nameFootnote), primaryKey: false);
    addField(NsgDataReferenceField<ProjectItem>(nameProjectId), primaryKey: false);
    addField(NsgDataReferenceField<SprintDoc>(nameSprintId), primaryKey: false);
    addField(NsgDataReferenceField<TaskType>(nameTaskTypeId), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameTaskStatusId), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocCommentsTable>(nameTableComments), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocCheckListTable>(nameCheckList), primaryKey: false);
    addField(NsgDataReferenceListField<TaskDocFilesTable>(nameFiles), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameAuthorId), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameAssigneeId), primaryKey: false);
    addField(NsgDataBoolField(nameIsReadByAssignee), primaryKey: false);
    addField(NsgDataEnumReferenceField<EPriority>(namePriority), primaryKey: false);
    addField(NsgDataIntField(nameTotalComments), primaryKey: false);
    addField(NsgDataReferenceField<TaskDoc>(nameBaseDocumentId), primaryKey: false);
    addField(NsgDataBoolField(nameIsPeriodic), primaryKey: false);
    addField(NsgDataIntField(namePeriodicInterval), primaryKey: false);
    addField(NsgDataEnumReferenceField<ETaskPeriodicity>(namePeriodicIntervalUnit), primaryKey: false);
    addField(NsgDataIntField(namePeriodicNumberOfIterations), primaryKey: false);
    addField(NsgDataDateField(namePeriodicActualUntil), primaryKey: false);
    addField(NsgDataDateField(namePeriodicLastClosed), primaryKey: false);
    addField(NsgDataIntField(namePeriodicTimeLimit), primaryKey: false);
    addField(NsgDataEnumReferenceField<ETaskPeriodicity>(namePeriodicTimeLimitlUnit), primaryKey: false);
    fieldList.fields[nameDate]?.presentation = 'Дата документа';
    fieldList.fields[nameDocNumber]?.presentation = 'Номер документа';
    fieldList.fields[nameTaskNumber]?.presentation = 'Номер задачи';
    fieldList.fields[nameDateClosed]?.presentation = 'Дата закрытия';
    fieldList.fields[nameDateUpdated]?.presentation = 'Дата обновления';
    fieldList.fields[nameDateRemind]?.presentation = 'Дата напоминания';
    fieldList.fields[nameDateDeadline]?.presentation = 'Срок выполнения';
    fieldList.fields[nameDescription]?.presentation = 'Описание задачи';
    fieldList.fields[nameName]?.presentation = 'Наименование';
    fieldList.fields[nameFootnote]?.presentation = 'Комментарий';
  }

  @override
  String toString() => '$docNumber. $name';

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

  /// НомерДокумента
  String get docNumber => getFieldValue(nameDocNumber).toString();

  set docNumber(String value) => setFieldValue(nameDocNumber, value);

  /// Номер задачи
  int get taskNumber => getFieldValue(nameTaskNumber) as int;

  set taskNumber(int value) => setFieldValue(nameTaskNumber, value);

  /// ДатаЗакрытия
  DateTime get dateClosed => getFieldValue(nameDateClosed) as DateTime;

  set dateClosed(DateTime value) => setFieldValue(nameDateClosed, value);

  /// ДатаОбновления
  DateTime get dateUpdated => getFieldValue(nameDateUpdated) as DateTime;

  set dateUpdated(DateTime value) => setFieldValue(nameDateUpdated, value);

  /// ДатаНапоминания
  DateTime get dateRemind => getFieldValue(nameDateRemind) as DateTime;

  set dateRemind(DateTime value) => setFieldValue(nameDateRemind, value);

  /// СрокВыполнения
  DateTime get dateDeadline => getFieldValue(nameDateDeadline) as DateTime;

  set dateDeadline(DateTime value) => setFieldValue(nameDateDeadline, value);

  /// ОписаниеЗадачи
  String get description => getFieldValue(nameDescription).toString();

  set description(String value) => setFieldValue(nameDescription, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// Комментарий
  String get footnote => getFieldValue(nameFootnote).toString();

  set footnote(String value) => setFieldValue(nameFootnote, value);

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

  /// ТипЗадачи
  String get taskTypeId => getFieldValue(nameTaskTypeId).toString();
  TaskType get taskType => getReferent<TaskType>(nameTaskTypeId);
  Future<TaskType> taskTypeAsync() async {
   return await getReferentAsync<TaskType>(nameTaskTypeId);
  }

  set taskTypeId(String value) => setFieldValue(nameTaskTypeId, value);
  set taskType(TaskType value) =>
    setFieldValue(nameTaskTypeId, value.id);

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

  /// ПрочитанаИсполнителем
  bool get isReadByAssignee => getFieldValue(nameIsReadByAssignee) as bool;

  set isReadByAssignee(bool value) => setFieldValue(nameIsReadByAssignee, value);

  /// Приоритет
  EPriority get priority => NsgEnum.fromValue(EPriority, getFieldValue(namePriority)) as EPriority;

  set priority(EPriority value) => setFieldValue(namePriority, value);

  /// Всего комментариев
  int get totalComments => getFieldValue(nameTotalComments) as int;

  set totalComments(int value) => setFieldValue(nameTotalComments, value);

  /// Если задача - часть периодической, ссылка на периодическую
  String get baseDocumentId => getFieldValue(nameBaseDocumentId).toString();
  TaskDoc get baseDocument => getReferent<TaskDoc>(nameBaseDocumentId);
  Future<TaskDoc> baseDocumentAsync() async {
   return await getReferentAsync<TaskDoc>(nameBaseDocumentId);
  }

  set baseDocumentId(String value) => setFieldValue(nameBaseDocumentId, value);
  set baseDocument(TaskDoc value) =>
    setFieldValue(nameBaseDocumentId, value.id);

  /// Периодическая
  bool get isPeriodic => getFieldValue(nameIsPeriodic) as bool;

  set isPeriodic(bool value) => setFieldValue(nameIsPeriodic, value);

  /// ПериодическаяИнтервал
  int get periodicInterval => getFieldValue(namePeriodicInterval) as int;

  set periodicInterval(int value) => setFieldValue(namePeriodicInterval, value);

  /// ПериодическаяИнтервалЕдиница
  ETaskPeriodicity get periodicIntervalUnit => NsgEnum.fromValue(ETaskPeriodicity, getFieldValue(namePeriodicIntervalUnit)) as ETaskPeriodicity;

  set periodicIntervalUnit(ETaskPeriodicity value) => setFieldValue(namePeriodicIntervalUnit, value);

  /// ПериодическаяКоличествоПовторений
  int get periodicNumberOfIterations => getFieldValue(namePeriodicNumberOfIterations) as int;

  set periodicNumberOfIterations(int value) => setFieldValue(namePeriodicNumberOfIterations, value);

  /// ПериодическаяАктуальнаДо
  DateTime get periodicActualUntil => getFieldValue(namePeriodicActualUntil) as DateTime;

  set periodicActualUntil(DateTime value) => setFieldValue(namePeriodicActualUntil, value);

  /// ПериодическаяДатаПоследнегоЗакрытия
  DateTime get periodicLastClosed => getFieldValue(namePeriodicLastClosed) as DateTime;

  set periodicLastClosed(DateTime value) => setFieldValue(namePeriodicLastClosed, value);

  /// ПериодическаяОтведенноеВремяМакс
  int get periodicTimeLimit => getFieldValue(namePeriodicTimeLimit) as int;

  set periodicTimeLimit(int value) => setFieldValue(namePeriodicTimeLimit, value);

  /// ПериодическаяОтведенноеВремяМаксЕдиница
  ETaskPeriodicity get periodicTimeLimitlUnit => NsgEnum.fromValue(ETaskPeriodicity, getFieldValue(namePeriodicTimeLimitlUnit)) as ETaskPeriodicity;

  set periodicTimeLimitlUnit(ETaskPeriodicity value) => setFieldValue(namePeriodicTimeLimitlUnit, value);

  @override
  String get apiRequestItems {
    return '/Data/Task';
  }
}
