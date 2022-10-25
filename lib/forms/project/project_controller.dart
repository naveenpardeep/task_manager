import 'package:nsg_data/nsg_data.dart';

import '../../model/project_item.dart';

class ProjectController extends NsgDataController<ProjectItem> {
  ProjectController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);
}
