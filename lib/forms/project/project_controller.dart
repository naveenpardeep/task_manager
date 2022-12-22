import 'package:nsg_data/nsg_data.dart';

import '../../model/project_item.dart';

class ProjectController extends NsgDataController<ProjectItem> {
  ProjectController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);
  @override
  Future<ProjectItem> createNewItemAsync() async {
    var element = await super.createNewItemAsync();

    element.date = DateTime.now();
    return element;
  }
}
