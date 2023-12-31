import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../../view/task_load_controller.dart';
import '../task_status/task_status_controller.dart';
import 'task_file_controller.dart';

class TasksController extends NsgDataController<TaskDoc> {
  TasksController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    referenceList = [
      TaskDocGenerated.nameProjectId,
      // TaskDocGenerated.nameSprintId,
      TaskDocGenerated.nameTaskStatusId,
      // TaskDocGenerated.nameAuthorId,
      TaskDocGenerated.nameAssigneeId,
      //  TaskDocGenerated.nameTableComments,
      //TODO: Дочитывать эти поля только при необходимости
      // TaskDocGenerated.nameCheckList,
      // TaskDocGenerated.nameFiles
    ];
  }
  var transitionstatusList = <TaskStatus>[];
  @override
  Future<NsgDataItem> refreshItem(NsgDataItem item, List<String>? referenceList) async {
    var res = await super.refreshItem(item, referenceList) as TaskDoc;
    transitionstatusList = await Get.find<DataController>().getAccessibleStatuses(res.taskStatusId);

    return res;
  }

  bool isPeriodicController = false;

  List<TaskLoadController> tasksControllersList = [];

  void refreshAllTasksControllers() {
    if (tasksControllersList.isNotEmpty) {
      for (var taskLoadC in tasksControllersList) {
        taskLoadC.getTasks(0);
      }
    }
  }

  @override
  Future refreshData({List<NsgUpdateKey>? keys, NsgDataRequestParams? filter}) {
    refreshAllTasksControllers();
    return super.refreshData(keys: keys, filter: filter);
  }

  @override
  Future<List<NsgDataItem>> doRequestItems({NsgDataRequestParams? filter}) async {
    //Запрос данных через этот контроллер потерял смысл: так как запрос задач идет через контроллеры статусов
    return [];
  }

  void getTasksControllers() async {
    //var taskController = Get.find<TasksController>();
    //var taskBoardController = Get.find<TaskBoardController>();
    var taskStatusTableController = Get.find<TaskStatusTableController>();
    //await taskBoardController.refreshData();
    tasksControllersList = [];
    for (var status in taskStatusTableController.items) {
      var taskC = TaskLoadController(currentTasksStatus: status.status);

      tasksControllersList.add(taskC);
      taskC.getTasks(0);
    }
    sendNotify();
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskDoc;
    element.project = Get.find<ProjectController>().currentItem;
    element.date = DateTime.now();
    element.dateUpdated = DateTime.now();
    element.taskStatus = Get.find<TaskBoardController>().currentItem.statusTable.rows.first.status;

    return element;
  }

  @override
  Future<bool> itemPagePost({bool goBack = false, bool useValidation = false}) async {
    var imageController = Get.find<TaskFilesController>();
    //if (imageController.images.firstWhereOrNull((e) => e.id == '') != null) {
    await imageController.checkImagesInRichText();
    await imageController.saveImages();
    //}
    return await super.itemPagePost(goBack: false, useValidation: useValidation);
  }
}

class CommentTableTasksController extends NsgDataTableController<TaskDocCommentsTable> {
  CommentTableTasksController() : super(masterController: Get.find<TasksController>(), tableFieldName: TaskDocGenerated.nameTableComments) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys, NsgDataRequestParams? filter}) async {
    await super.requestItems(keys: keys, filter: filter);

    if (masterController!.selectedItem != null && currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<TaskDocCommentsTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();
    item.date = DateTime.now();
    return item;
  }
}

class TaskCheckListController extends NsgDataTableController<TaskDocCheckListTable> {
  TaskCheckListController() : super(masterController: Get.find<TasksController>(), tableFieldName: TaskDocGenerated.nameCheckList) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys, NsgDataRequestParams? filter}) async {
    await super.requestItems(keys: keys, filter: filter);

    if (masterController!.selectedItem != null && currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<TaskDocCheckListTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();

    return item;
  }
}
