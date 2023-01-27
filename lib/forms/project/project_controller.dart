import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/generated/project_item.g.dart';

import '../../model/project_item.dart';
import '../../model/project_item_user_table.dart';

class ProjectController extends NsgDataController<ProjectItem> {
  ProjectController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100){
        referenceList=[
          ProjectItemGenerated.nameNumberOfTasksOpen,
          ProjectItemGenerated.nameOrganizationId,
          ProjectItemGenerated.nameLeaderId,
          
        ];
      }

  //       @override
  // NsgDataRequestParams get getRequestFilter {
  //   var cmp = NsgCompare();
  //   var projectController = Get.find<ProjectController>();

  //   cmp.add(
  //       name: ProjectItemGenerated.nameName,
  //       value: projectController.currentItem.ownerId);

  //   return NsgDataRequestParams(compare: cmp);
  // }


  @override
  Future itemRemove({bool goBack = true}) {
    return super.itemRemove();
  }

  @override
  Future itemsRemove(List<NsgDataItem> itemsToRemove) {
    return super.itemsRemove(itemsToRemove);
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem();

    // element.id = Guid.newGuid();

    element.id = Guid.newGuid();

    return element;
  }

  @override
  Future<ProjectItem> createNewItemAsync() async {
    var element = await super.createNewItemAsync();

    // element.date = DateTime.now();
    return element;
  }
}


class ProjectItemUserTableController
    extends NsgDataTableController<ProjectItemUserTable> {
  ProjectItemUserTableController()
      : super(
          masterController: Get.find<ProjectController>(),
          tableFieldName: ProjectItemGenerated.nameTableUsers,
        );
        }