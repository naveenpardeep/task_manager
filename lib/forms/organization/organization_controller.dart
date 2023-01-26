import 'package:get/get.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/model/generated/organization_item.g.dart';
import 'package:task_manager_app/model/organization_item.dart';
import 'package:task_manager_app/model/organization_item_user_table.dart';



class OrganizationController extends NsgDataController<OrganizationItem> {
  OrganizationController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 100){
        referenceList=[
          OrganizationItemGenerated.nameId,
          OrganizationItemGenerated.nameName
        ];
      
      }

  @override
  Future<NsgDataItem> doCreateNewItem() async {
    var element = await super.doCreateNewItem();

    element.id = Guid.newGuid();

    return element;
  }

  @override
  Future<OrganizationItem> createNewItemAsync() async {
      var element = await super.createNewItemAsync();
    return element;
  }
}

class OrganizationItemUserTableController
    extends NsgDataTableController<OrganizationItemUserTable> {
  OrganizationItemUserTableController()
      : super(
          masterController: Get.find<OrganizationController>(),
          tableFieldName: OrganizationItemGenerated.nameTableUsers,
        );
}
