import 'generated/task_board_status_table.g.dart';

class TaskBoardStatusTable extends TaskBoardStatusTableGenerated {
    @override 
  String toString() {
    return status.name.toString();
  }

  bool isChecked= false;
}