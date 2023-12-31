//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';

/// АккаунтПользователя
class UserAccountGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameName = 'name';
  static const nameFirstName = 'firstName';
  static const nameLastName = 'lastName';
  static const nameBirthDate = 'birthDate';
  static const namePhoneNumber = 'phoneNumber';
  static const nameEmail = 'email';
  static const namePosition = 'position';
  static const nameDescription = 'description';
  static const nameIsFilled = 'isFilled';
  static const nameSettingNotifyByEmail = 'settingNotifyByEmail';
  static const nameSettingNotifyByPush = 'settingNotifyByPush';
  static const nameSettingNotifyNewTasks = 'settingNotifyNewTasks';
  static const nameSettingNotifyEditedTasks = 'settingNotifyEditedTasks';
  static const nameSettingNotifyNewTasksInProjects = 'settingNotifyNewTasksInProjects';
  static const nameSettingNotifyEditedTasksInProjects = 'settingNotifyEditedTasksInProjects';
  static const nameLastChange = 'lastChange';
  static const namePhotoName = 'photoName';
  static const namePhotoFile = 'photoFile';
  static const nameOrganizationId = 'organizationId';
  static const nameInviteProjectId = 'inviteProjectId';
  static const nameInviteInstantAdd = 'inviteInstantAdd';
  static const nameMainUserAccountId = 'mainUserAccountId';

  static final Map<String, String> fieldNameDict = {
    nameName: 'Наименование',
    nameFirstName: 'Имя',
    nameLastName: 'Фамилия',
    namePhoneNumber: 'Номер телефона',
    nameEmail: 'Email',
    namePosition: 'Должность',
    nameSettingNotifyByEmail: 'Включены уведомления email',
    nameSettingNotifyByPush: 'Включены уведомления push',
    namePhotoName: 'Наименование картинки',
  };

  @override
  String get typeName => 'UserAccount';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataStringField(nameFirstName), primaryKey: false);
    addField(NsgDataStringField(nameLastName), primaryKey: false);
    addField(NsgDataDateField(nameBirthDate), primaryKey: false);
    addField(NsgDataStringField(namePhoneNumber), primaryKey: false);
    addField(NsgDataStringField(nameEmail), primaryKey: false);
    addField(NsgDataStringField(namePosition), primaryKey: false);
    addField(NsgDataStringField(nameDescription), primaryKey: false);
    addField(NsgDataBoolField(nameIsFilled), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyByEmail), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyByPush), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyNewTasks), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyEditedTasks), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyNewTasksInProjects), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyEditedTasksInProjects), primaryKey: false);
    addField(NsgDataDateField(nameLastChange), primaryKey: false);
    addField(NsgDataStringField(namePhotoName), primaryKey: false);
    addField(NsgDataBinaryField(namePhotoFile), primaryKey: false);
    addField(NsgDataReferenceField<OrganizationItem>(nameOrganizationId), primaryKey: false);
    addField(NsgDataReferenceField<ProjectItem>(nameInviteProjectId), primaryKey: false);
    addField(NsgDataBoolField(nameInviteInstantAdd), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameMainUserAccountId), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
    fieldList.fields[nameFirstName]?.presentation = 'Имя';
    fieldList.fields[nameLastName]?.presentation = 'Фамилия';
    fieldList.fields[namePhoneNumber]?.presentation = 'Номер телефона';
    fieldList.fields[nameEmail]?.presentation = 'Email';
    fieldList.fields[namePosition]?.presentation = 'Должность';
    fieldList.fields[nameSettingNotifyByEmail]?.presentation = 'Включены уведомления email';
    fieldList.fields[nameSettingNotifyByPush]?.presentation = 'Включены уведомления push';
    fieldList.fields[namePhotoName]?.presentation = 'Наименование картинки';
  }

  @override
  String toString() => name;

  @override
  NsgDataItem getNewObject() => UserAccount();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// Наименование
  String get name => getFieldValue(nameName).toString();

  set name(String value) => setFieldValue(nameName, value);

  /// Имя
  String get firstName => getFieldValue(nameFirstName).toString();

  set firstName(String value) => setFieldValue(nameFirstName, value);

  /// Фамилия
  String get lastName => getFieldValue(nameLastName).toString();

  set lastName(String value) => setFieldValue(nameLastName, value);

  /// ДатаРождения
  DateTime get birthDate => getFieldValue(nameBirthDate) as DateTime;

  set birthDate(DateTime value) => setFieldValue(nameBirthDate, value);

  /// НомерТелефона
  String get phoneNumber => getFieldValue(namePhoneNumber).toString();

  set phoneNumber(String value) => setFieldValue(namePhoneNumber, value);

  /// Email
  String get email => getFieldValue(nameEmail).toString();

  set email(String value) => setFieldValue(nameEmail, value);

  /// Должность
  String get position => getFieldValue(namePosition).toString();

  set position(String value) => setFieldValue(namePosition, value);

  /// Комментарий
  String get description => getFieldValue(nameDescription).toString();

  set description(String value) => setFieldValue(nameDescription, value);

  /// Заполнен
  bool get isFilled => getFieldValue(nameIsFilled) as bool;

  set isFilled(bool value) => setFieldValue(nameIsFilled, value);

  /// ВключеныУведомленияEmail
  bool get settingNotifyByEmail => getFieldValue(nameSettingNotifyByEmail) as bool;

  set settingNotifyByEmail(bool value) => setFieldValue(nameSettingNotifyByEmail, value);

  /// ВключеныУведомленияPush
  bool get settingNotifyByPush => getFieldValue(nameSettingNotifyByPush) as bool;

  set settingNotifyByPush(bool value) => setFieldValue(nameSettingNotifyByPush, value);

  /// ВключеныУведомленияОНовыхЗадачах
  bool get settingNotifyNewTasks => getFieldValue(nameSettingNotifyNewTasks) as bool;

  set settingNotifyNewTasks(bool value) => setFieldValue(nameSettingNotifyNewTasks, value);

  /// ВключеныУведомленияОбИзмененияхЗадач
  bool get settingNotifyEditedTasks => getFieldValue(nameSettingNotifyEditedTasks) as bool;

  set settingNotifyEditedTasks(bool value) => setFieldValue(nameSettingNotifyEditedTasks, value);

  /// ВключеныУведомленияОНовыхЗадачахВПроектах
  bool get settingNotifyNewTasksInProjects => getFieldValue(nameSettingNotifyNewTasksInProjects) as bool;

  set settingNotifyNewTasksInProjects(bool value) => setFieldValue(nameSettingNotifyNewTasksInProjects, value);

  /// ВключеныУведомленияОбИзмененияхЗадачВПроектах
  bool get settingNotifyEditedTasksInProjects => getFieldValue(nameSettingNotifyEditedTasksInProjects) as bool;

  set settingNotifyEditedTasksInProjects(bool value) => setFieldValue(nameSettingNotifyEditedTasksInProjects, value);

  /// ПоследнееИзменение
  DateTime get lastChange => getFieldValue(nameLastChange) as DateTime;

  set lastChange(DateTime value) => setFieldValue(nameLastChange, value);

  /// НаименованиеКартинки
  String get photoName => getFieldValue(namePhotoName).toString();

  set photoName(String value) => setFieldValue(namePhotoName, value);

  /// Картинка
  List<int> get photoFile {
    return getFieldValue(namePhotoFile) as List<int>;
  }

  set photoFile(List<int> value) => setFieldValue(namePhotoFile, value);

  /// Организация
  String get organizationId => getFieldValue(nameOrganizationId).toString();
  OrganizationItem get organization => getReferent<OrganizationItem>(nameOrganizationId);
  Future<OrganizationItem> organizationAsync() async {
   return await getReferentAsync<OrganizationItem>(nameOrganizationId);
  }

  set organizationId(String value) => setFieldValue(nameOrganizationId, value);
  set organization(OrganizationItem value) =>
    setFieldValue(nameOrganizationId, value.id);

  /// Проект (для добавления)
  String get inviteProjectId => getFieldValue(nameInviteProjectId).toString();
  ProjectItem get inviteProject => getReferent<ProjectItem>(nameInviteProjectId);
  Future<ProjectItem> inviteProjectAsync() async {
   return await getReferentAsync<ProjectItem>(nameInviteProjectId);
  }

  set inviteProjectId(String value) => setFieldValue(nameInviteProjectId, value);
  set inviteProject(ProjectItem value) =>
    setFieldValue(nameInviteProjectId, value.id);

  /// Добавить сразу (без приглашений)
  bool get inviteInstantAdd => getFieldValue(nameInviteInstantAdd) as bool;

  set inviteInstantAdd(bool value) => setFieldValue(nameInviteInstantAdd, value);

  /// ОсновнойАккаунт
  String get mainUserAccountId => getFieldValue(nameMainUserAccountId).toString();
  UserAccount get mainUserAccount => getReferent<UserAccount>(nameMainUserAccountId);
  Future<UserAccount> mainUserAccountAsync() async {
   return await getReferentAsync<UserAccount>(nameMainUserAccountId);
  }

  set mainUserAccountId(String value) => setFieldValue(nameMainUserAccountId, value);
  set mainUserAccount(UserAccount value) =>
    setFieldValue(nameMainUserAccountId, value.id);

  @override
  String get apiRequestItems {
    return '/Data/UserAccount';
  }
}
