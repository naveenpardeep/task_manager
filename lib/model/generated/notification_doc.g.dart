//This is autogenerated file. All changes will be lost after code generation.
import 'package:nsg_data/nsg_data.dart';
// ignore: unused_import
import 'dart:typed_data';
import '../data_controller_model.dart';
import '../enums.dart';

/// Уведомление
class NotificationDocGenerated extends NsgDataItem {
  static const nameId = 'id';
  static const nameDate = 'date';
  static const nameDateRead = 'dateRead';
  static const nameComment = 'comment';
  static const nameTaskId = 'taskId';
  static const nameTaskOldStatusId = 'taskOldStatusId';
  static const nameTaskNewStatusId = 'taskNewStatusId';
  static const nameAssigneeId = 'assigneeId';
  static const nameProjectId = 'projectId';
  static const nameOrganizationId = 'organizationId';
  static const nameInvitationId = 'invitationId';
  static const nameNotificationType = 'notificationType';
  static const nameChatNumberOfUnreadMessages = 'chatNumberOfUnreadMessages';
  static const nameChatDateUnread1 = 'chatDateUnread1';
  static const nameChatDateUnread2 = 'chatDateUnread2';
  static const nameIsSent = 'isSent';
  static const nameNumberOfAttemptsToSend = 'numberOfAttemptsToSend';
  static const nameUserAccountId = 'userAccountId';

  static final Map<String, String> fieldNameDict = {
    nameDate: 'Дата документа',
    nameDateRead: 'Дата просмотра',
    nameComment: 'Комментарий',
  };

  @override
  String get typeName => 'NotificationDoc';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataDateField(nameDate), primaryKey: false);
    addField(NsgDataDateField(nameDateRead), primaryKey: false);
    addField(NsgDataStringField(nameComment), primaryKey: false);
    addField(NsgDataReferenceField<TaskDoc>(nameTaskId), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameTaskOldStatusId), primaryKey: false);
    addField(NsgDataReferenceField<TaskStatus>(nameTaskNewStatusId), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameAssigneeId), primaryKey: false);
    addField(NsgDataReferenceField<ProjectItem>(nameProjectId), primaryKey: false);
    addField(NsgDataReferenceField<OrganizationItem>(nameOrganizationId), primaryKey: false);
    addField(NsgDataReferenceField<Invitation>(nameInvitationId), primaryKey: false);
    addField(NsgDataEnumReferenceField<ENotificationType>(nameNotificationType), primaryKey: false);
    addField(NsgDataIntField(nameChatNumberOfUnreadMessages), primaryKey: false);
    addField(NsgDataDateField(nameChatDateUnread1), primaryKey: false);
    addField(NsgDataDateField(nameChatDateUnread2), primaryKey: false);
    addField(NsgDataBoolField(nameIsSent), primaryKey: false);
    addField(NsgDataIntField(nameNumberOfAttemptsToSend), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameUserAccountId), primaryKey: false);
    fieldList.fields[nameDate]?.presentation = 'Дата документа';
    fieldList.fields[nameDateRead]?.presentation = 'Дата просмотра';
    fieldList.fields[nameComment]?.presentation = 'Комментарий';
  }

  @override
  NsgDataItem getNewObject() => NotificationDoc();

  /// Идентификатор
  @override
  String get id => getFieldValue(nameId).toString();

  @override
  set id(String value) => setFieldValue(nameId, value);

  /// ДатаДокумента
  DateTime get date => getFieldValue(nameDate) as DateTime;

  set date(DateTime value) => setFieldValue(nameDate, value);

  /// ДатаПросмотра
  DateTime get dateRead => getFieldValue(nameDateRead) as DateTime;

  set dateRead(DateTime value) => setFieldValue(nameDateRead, value);

  /// Комментарий
  String get comment => getFieldValue(nameComment).toString();

  set comment(String value) => setFieldValue(nameComment, value);

  /// Задача
  String get taskId => getFieldValue(nameTaskId).toString();
  TaskDoc get task => getReferent<TaskDoc>(nameTaskId);
  Future<TaskDoc> taskAsync() async {
   return await getReferentAsync<TaskDoc>(nameTaskId);
  }

  set taskId(String value) => setFieldValue(nameTaskId, value);
  set task(TaskDoc value) =>
    setFieldValue(nameTaskId, value.id);

  /// СтарыйСтатус
  String get taskOldStatusId => getFieldValue(nameTaskOldStatusId).toString();
  TaskStatus get taskOldStatus => getReferent<TaskStatus>(nameTaskOldStatusId);
  Future<TaskStatus> taskOldStatusAsync() async {
   return await getReferentAsync<TaskStatus>(nameTaskOldStatusId);
  }

  set taskOldStatusId(String value) => setFieldValue(nameTaskOldStatusId, value);
  set taskOldStatus(TaskStatus value) =>
    setFieldValue(nameTaskOldStatusId, value.id);

  /// НовыйСтатус
  String get taskNewStatusId => getFieldValue(nameTaskNewStatusId).toString();
  TaskStatus get taskNewStatus => getReferent<TaskStatus>(nameTaskNewStatusId);
  Future<TaskStatus> taskNewStatusAsync() async {
   return await getReferentAsync<TaskStatus>(nameTaskNewStatusId);
  }

  set taskNewStatusId(String value) => setFieldValue(nameTaskNewStatusId, value);
  set taskNewStatus(TaskStatus value) =>
    setFieldValue(nameTaskNewStatusId, value.id);

  /// Исполнитель
  String get assigneeId => getFieldValue(nameAssigneeId).toString();
  UserAccount get assignee => getReferent<UserAccount>(nameAssigneeId);
  Future<UserAccount> assigneeAsync() async {
   return await getReferentAsync<UserAccount>(nameAssigneeId);
  }

  set assigneeId(String value) => setFieldValue(nameAssigneeId, value);
  set assignee(UserAccount value) =>
    setFieldValue(nameAssigneeId, value.id);

  /// Проект
  String get projectId => getFieldValue(nameProjectId).toString();
  ProjectItem get project => getReferent<ProjectItem>(nameProjectId);
  Future<ProjectItem> projectAsync() async {
   return await getReferentAsync<ProjectItem>(nameProjectId);
  }

  set projectId(String value) => setFieldValue(nameProjectId, value);
  set project(ProjectItem value) =>
    setFieldValue(nameProjectId, value.id);

  /// Организация
  String get organizationId => getFieldValue(nameOrganizationId).toString();
  OrganizationItem get organization => getReferent<OrganizationItem>(nameOrganizationId);
  Future<OrganizationItem> organizationAsync() async {
   return await getReferentAsync<OrganizationItem>(nameOrganizationId);
  }

  set organizationId(String value) => setFieldValue(nameOrganizationId, value);
  set organization(OrganizationItem value) =>
    setFieldValue(nameOrganizationId, value.id);

  /// Приглашение
  String get invitationId => getFieldValue(nameInvitationId).toString();
  Invitation get invitation => getReferent<Invitation>(nameInvitationId);
  Future<Invitation> invitationAsync() async {
   return await getReferentAsync<Invitation>(nameInvitationId);
  }

  set invitationId(String value) => setFieldValue(nameInvitationId, value);
  set invitation(Invitation value) =>
    setFieldValue(nameInvitationId, value.id);

  /// ТипУведомления
  ENotificationType get notificationType => NsgEnum.fromValue(ENotificationType, getFieldValue(nameNotificationType)) as ENotificationType;

  set notificationType(ENotificationType value) => setFieldValue(nameNotificationType, value);

  /// ЧатКоличествоНепрочитанных
  int get chatNumberOfUnreadMessages => getFieldValue(nameChatNumberOfUnreadMessages) as int;

  set chatNumberOfUnreadMessages(int value) => setFieldValue(nameChatNumberOfUnreadMessages, value);

  /// ЧатДатаНепрочитанного1
  DateTime get chatDateUnread1 => getFieldValue(nameChatDateUnread1) as DateTime;

  set chatDateUnread1(DateTime value) => setFieldValue(nameChatDateUnread1, value);

  /// ЧатДатаНепрочитанного2
  DateTime get chatDateUnread2 => getFieldValue(nameChatDateUnread2) as DateTime;

  set chatDateUnread2(DateTime value) => setFieldValue(nameChatDateUnread2, value);

  /// Отправлено
  bool get isSent => getFieldValue(nameIsSent) as bool;

  set isSent(bool value) => setFieldValue(nameIsSent, value);

  /// ПопытокОтправки
  int get numberOfAttemptsToSend => getFieldValue(nameNumberOfAttemptsToSend) as int;

  set numberOfAttemptsToSend(int value) => setFieldValue(nameNumberOfAttemptsToSend, value);

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
    return '/Data/Notification';
  }
}
