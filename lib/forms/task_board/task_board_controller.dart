import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/task_board.dart';

import '../../model/project_item.dart';

class TaskBoardController extends NsgDataController<TaskBoard> {
  TaskBoardController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);
  

}
