import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../project/project_controller.dart';

class TaskTypeTaskListController extends NsgDataController<TaskType> {
  TaskTypeTaskListController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) ;

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskType;
    element.ownerId = Get.find<ProjectController>().currentItem.id;

    return element;
  }


}
