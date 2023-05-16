import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class NotificationController extends NsgDataController<NotificationDoc> {
  NotificationController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem();

    element.id = Guid.newGuid();

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var filter = NsgDataRequestParams();

    filter.sorting = "${NotificationDocGenerated.nameDate}-";
    return filter;
  }

  @override
  Future<NotificationDoc> createNewItemAsync() async {
    var element = await super.createNewItemAsync();

    element.date = DateTime.now();
    return element;
  }
}
