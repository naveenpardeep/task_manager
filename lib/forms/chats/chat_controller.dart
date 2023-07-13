import 'package:get/get.dart';

import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/chats/chat_tasklist_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class ChatController extends NsgDataController<TaskComment> {
  ChatController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100) {
    masterController = Get.find<ChatTaskListController>();
  }

  @override
  Future requestItems({List<NsgUpdateKey>? keys, NsgDataRequestParams? filter}) async {
    await super.requestItems(keys: keys, filter: filter);

    if (currentItem.isEmpty) {
      createNewItemAsync();
    }
  }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem() as TaskComment;
    element.id = Guid.newGuid();
    element.ownerId = Get.find<ChatTaskListController>().currentItem.id;

    return element;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var taskController = Get.find<ChatTaskListController>();

    cmp.add(name: TaskCommentGenerated.nameOwnerId, value: taskController.currentItem.ownerId ,comparisonOperator: NsgComparisonOperator.equal);
    return NsgDataRequestParams(compare: cmp);
  }
}
