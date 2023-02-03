import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class AccpetController extends NsgDataController<Invitation> {
  AccpetController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100);

  
}