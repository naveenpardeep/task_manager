// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../../model/data_controller.dart';

class AccpetController extends NsgDataController<Invitation> {
  AccpetController() : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    cmp.logicalOperator = NsgLogicalOperator.or;
    var user = Get.find<DataController>().currentUser;
    cmp.add(name: InvitationGenerated.nameAuthorId, value: user);
    cmp.add(name: '${InvitationGenerated.nameAuthorId}.${UserAccountGenerated.nameMainUserAccountId}', value: user);
    return NsgDataRequestParams(compare: cmp);
  }
}
