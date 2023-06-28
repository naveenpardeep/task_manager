import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/data_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../project/project_controller.dart';

class BusinessProcessController extends NsgDataController<BusinessProcess> {
  BusinessProcessController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<ProjectController>();
  }

   
 
  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as BusinessProcess;
    element.projectId = Get.find<ProjectController>().currentItem.id;

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var projectController = Get.find<ProjectController>();

    cmp.add(name: BusinessProcessGenerated.nameProjectId, value: projectController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }
}

class BusinessProcessTransitionTableController extends NsgDataTableController<BusinessProcessTransitionTable> {
  BusinessProcessTransitionTableController()
      : super(masterController: Get.find<BusinessProcessController>(), tableFieldName: BusinessProcessGenerated.nameTransitionTable) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys}) async {
    await super.requestItems(keys: keys);

    if (masterController!.selectedItem != null && currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<BusinessProcessTransitionTable> doCreateNewItem() async {
    var item = await super.doCreateNewItem();

    return item;
  }
}
