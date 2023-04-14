import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

import '../model/generated/task_doc.g.dart';
import '../model/task_doc.dart';
import '../model/task_status.dart';

class TaskLoadController extends NsgBaseController {
  TaskLoadController({required this.currentTasksStatus});
  List<TaskDoc> currentStatusTasks = [];
  TaskStatus currentTasksStatus;

  set currentTaskStatus(TaskStatus tStat) {
    currentTasksStatus = tStat;
    getTasks(0, 0);
  }

  TaskStatus get currentTaskStatus => currentTasksStatus;

  Future<List<TaskDoc>> _getTasksFromStatus(TaskStatus status, int top, int count) async {
    var tasks = NsgDataRequest<TaskDoc>(dataItemType: TaskDoc);
    var filter = NsgDataRequestParams(top: top, count: count);
    filter.compare.add(name: TaskDocGenerated.nameTaskStatusId, value: status);
    return await tasks.requestItems(filter: filter);
  }

  getTasks(int top, int count, {TaskStatus? taskStatus}) async {
    taskStatus ??= currentTasksStatus;
    currentStatus = GetStatus<NsgBaseControllerData>.loading();
    sendNotify();
    currentStatusTasks = await _getTasksFromStatus(taskStatus, top, count);
    currentStatus = GetStatus<NsgBaseControllerData>.success(NsgBaseController.emptyData);
    sendNotify();
  }
}
