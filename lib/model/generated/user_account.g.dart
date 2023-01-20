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
  static const namePhoneNumber = 'phoneNumber';
  static const nameEmail = 'email';
  static const namePosition = 'position';
  static const nameSettingNotifyByEmail = 'settingNotifyByEmail';
  static const nameSettingNotifyByPush = 'settingNotifyByPush';
  static const nameLastChange = 'lastChange';
  static const namePictureId = 'pictureId';
  static const nameOrganizationId = 'organizationId';
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
  };

  @override
  String get typeName => 'UserAccount';

  @override
  void initialize() {
    addField(NsgDataStringField(nameId), primaryKey: true);
    addField(NsgDataStringField(nameName), primaryKey: false);
    addField(NsgDataStringField(nameFirstName), primaryKey: false);
    addField(NsgDataStringField(nameLastName), primaryKey: false);
    addField(NsgDataStringField(namePhoneNumber), primaryKey: false);
    addField(NsgDataStringField(nameEmail), primaryKey: false);
    addField(NsgDataStringField(namePosition), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyByEmail), primaryKey: false);
    addField(NsgDataBoolField(nameSettingNotifyByPush), primaryKey: false);
    addField(NsgDataDateField(nameLastChange), primaryKey: false);
    addField(NsgDataReferenceField<Picture>(namePictureId), primaryKey: false);
    addField(NsgDataReferenceField<OrganizationItem>(nameOrganizationId), primaryKey: false);
    addField(NsgDataReferenceField<UserAccount>(nameMainUserAccountId), primaryKey: false);
    fieldList.fields[nameName]?.presentation = 'Наименование';
    fieldList.fields[nameFirstName]?.presentation = 'Имя';
    fieldList.fields[nameLastName]?.presentation = 'Фамилия';
    fieldList.fields[namePhoneNumber]?.presentation = 'Номер телефона';
    fieldList.fields[nameEmail]?.presentation = 'Email';
    fieldList.fields[namePosition]?.presentation = 'Должность';
    fieldList.fields[nameSettingNotifyByEmail]?.presentation = 'Включены уведомления email';
    fieldList.fields[nameSettingNotifyByPush]?.presentation = 'Включены уведомления push';
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

  /// НомерТелефона
  String get phoneNumber => getFieldValue(namePhoneNumber).toString();

  set phoneNumber(String value) => setFieldValue(namePhoneNumber, value);

  /// Email
  String get email => getFieldValue(nameEmail).toString();

  set email(String value) => setFieldValue(nameEmail, value);

  /// Должность
  String get position => getFieldValue(namePosition).toString();

  set position(String value) => setFieldValue(namePosition, value);

  /// ВключеныУведомленияEmail
  bool get settingNotifyByEmail => getFieldValue(nameSettingNotifyByEmail) as bool;

  set settingNotifyByEmail(bool value) => setFieldValue(nameSettingNotifyByEmail, value);

  /// ВключеныУведомленияPush
  bool get settingNotifyByPush => getFieldValue(nameSettingNotifyByPush) as bool;

  set settingNotifyByPush(bool value) => setFieldValue(nameSettingNotifyByPush, value);

  /// ПоследнееИзменение
  DateTime get lastChange => getFieldValue(nameLastChange) as DateTime;

  set lastChange(DateTime value) => setFieldValue(nameLastChange, value);

  /// Картинка
  String get pictureId => getFieldValue(namePictureId).toString();
  Picture get picture => getReferent<Picture>(namePictureId);
  Future<Picture> pictureAsync() async {
   return await getReferentAsync<Picture>(namePictureId);
  }

  set pictureId(String value) => setFieldValue(namePictureId, value);
  set picture(Picture value) =>
    setFieldValue(namePictureId, value.id);

  /// Организация
  String get organizationId => getFieldValue(nameOrganizationId).toString();
  OrganizationItem get organization => getReferent<OrganizationItem>(nameOrganizationId);
  Future<OrganizationItem> organizationAsync() async {
   return await getReferentAsync<OrganizationItem>(nameOrganizationId);
  }

  set organizationId(String value) => setFieldValue(nameOrganizationId, value);
  set organization(OrganizationItem value) =>
    setFieldValue(nameOrganizationId, value.id);

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
