import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';

import 'app_pages.dart';
import 'model/data_controller.dart';

class TTNavigator extends NsgNavigator {
  @override
  Future toPage(String pageName) async {
    Get.find<DataController>().sendNotify();
    // if (pageName == Routes.catalogueItemPage) {
    //   return await Get.toNamed(pageName, preventDuplicates: true, parameters: <String, String>{"id": Get.find<NomenclatureItemController>().currentItem.id});
    // }
    // if (pageName == Routes.catalogueCategoryPage) {
    //   return await Get.toNamed(pageName, preventDuplicates: true, parameters: <String, String>{"categoryId": Get.find<CategoryController>().currentItem.id});
    // } else {
    return await Get.toNamed(pageName, preventDuplicates: true);
    // }
  }
}
