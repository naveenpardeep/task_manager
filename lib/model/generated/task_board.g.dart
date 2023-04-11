//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';
import '../enums.dart';

/// Доски
class TaskBoardGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameProjectId = 'projectId';
  static const nameSortBy = 'sortBy';
  static const namePeriodOfFinishedTasks = 'periodOfFinishedTasks';
  static const nameStatusTable = 'statusTable';
  static const nameTypeTable = 'typeTable';

  static final Map<String, String> fieldNameDict = {
    nameName: 'Наименование',
  };

  @override
  String get typeName => 'TaskBoard';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataReferenceField<ProjectItem>(nameProjectId), primaryKey: false);
    addField(NsgDataEnumReferenceField<ESorting>(nameSortBy), primaryKey: false);
    addField(NsgDataEnumReferenceField<EPeriod>(namePeriodOfFinishedTasks), primaryKey: false);
    addField(NsgDataReferenceListField<TaskBoardStatusTable>(nameStatusTable), primaryKey: false);
    addField(NsgDataReferenceListField<TaskBoardTypeTable>(nameTypeTable), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => TaskBoard();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// Проект
  String get projectId => getFieldValue(nameProjectId).toString();
  ProjectItem get project => getReferent<ProjectItem>(nameProjectId);
  Future<ProjectItem> projectAsync() async {
   return await getReferentAsync<ProjectItem>(nameProjectId);
  }

  set projectId(String value) => setFieldValue(nameProjectId, value);
  set project(ProjectItem value) =>
    setFieldValue(nameProjectId, value.id);

  /// Сортировка
  ESorting get sortBy => NsgEnum.fromValue(ESorting, getFieldValue(nameSortBy)) as ESorting;

  set sortBy(ESorting value) => setFieldValue(nameSortBy, value);

  /// ПериодВидимостиЗавершенныхЗадач
  EPeriod get periodOfFinishedTasks => NsgEnum.fromValue(EPeriod, getFieldValue(namePeriodOfFinishedTasks)) as EPeriod;

  set periodOfFinishedTasks(EPeriod value) => setFieldValue(namePeriodOfFinishedTasks, value);

  /// Статусы
  NsgDataTable<TaskBoardStatusTable> get statusTable => NsgDataTable<TaskBoardStatusTable>(owner: this, fieldName: nameStatusTable);


  /// ТипыЗадач
  NsgDataTable<TaskBoardTypeTable> get typeTable => NsgDataTable<TaskBoardTypeTable>(owner: this, fieldName: nameTypeTable);


  @override
  String get apiRequestItems {
    return '/Data/TaskBoard';
  }
}
