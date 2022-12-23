import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import '../../model/project_item.dart';

class ProjectController extends NsgDataController<ProjectItem> {
  ProjectController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    // TODO: implement doCreateNewItem
    var element = await super.doCreateNewItem();

    // element.id = Guid.newGuid();

    return element;
  }

  @override
  Future<ProjectItem> createNewItemAsync() async {
    // TODO: implement createNewItemAsync
    var element = await super.createNewItemAsync();

    // element.date = DateTime.now();
    return element;
  }
}
