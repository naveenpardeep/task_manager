import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/notification_doc.dart';

class NotificationController extends NsgDataController<NotificationDoc> {
  NotificationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);
     
      @override
  Future<NotificationDoc> createNewItemAsync() {
    
    return super.createNewItemAsync();
  }

  @override
  Future<NsgDataItem> doCreateNewItem() {
    
    return super.doCreateNewItem();
  }
}
