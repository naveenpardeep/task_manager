import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class UserSettingsController extends NsgUserSettingsController<UserSettings> {
  UserSettingsController({super.controllerMode, super.requestOnInit});
  UserFilters nameFilter = UserFilters();

  NsgDataRequestParams get userFilter => nameFilter.filter;
}

class UserFilters extends NsgDataItem {
  static const nameFilter = 'filter';

  static final Map<String, String> fieldNameDict = {
    nameFilter: 'Фильтр',
  };

  @override
  String get typeName => 'UserFilters';

  @override
  void initialize() {
    addField(NsgDataStringField(nameFilter), primaryKey: false);
    fieldList.fields[nameFilter]?.presentation = 'Фильтр';
  }

  set filter(NsgDataRequestParams filters) => setFieldValue(nameFilter, filters.toJson());

  NsgDataRequestParams get filter => getFieldValue(nameFilter).fromJson();
}
