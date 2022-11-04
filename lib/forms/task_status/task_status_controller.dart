import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class TaskStatusController extends NsgDataController<TaskStatus> {
  TaskStatusController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);
}
