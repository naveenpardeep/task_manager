import 'package:task_manager_app/model/task_status.dart';

import 'generated/task_board_status_table.g.dart';

class TaskBoardStatusTable extends TaskBoardStatusTableGenerated {
    @override 
  String toString() {
    // TODO: implement toString
    return status.name;
  }
}