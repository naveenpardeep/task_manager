import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/business_process/business_process_controller.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class BusinessProcessPage extends GetView<BusinessProcessController> {
  const BusinessProcessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    //double width = MediaQuery.of(context).size.width;
    return BodyWrap(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  text: 'Business Process',
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () async {
                    await controller.itemPagePost();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TTNsgInput(
                              dataItem: controller.currentItem,
                              fieldName: BusinessProcessGenerated.nameName,
                              label: 'Наименование',
                            ),
                            const Text('Add Transition status From Status to which you want to Change -> To Status'),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: NsgTable(
                                showIconFalse: false,
                                controller: Get.find<BusinessProcessTransitionTableController>(),
                                elementEditPageName: Routes.businessProcessTransitionTablePage,
                                availableButtons: const [
                                  NsgTableMenuButtonType.createNewElement,
                                  NsgTableMenuButtonType.editElement,
                                  NsgTableMenuButtonType.removeElement
                                ],
                                columns: [
                                  NsgTableColumn(name: BusinessProcessTransitionTableGenerated.nameStatusFromId, expanded: true, presentation: 'From Status'),
                                  NsgTableColumn(name: BusinessProcessTransitionTableGenerated.nameStatusToId, expanded: true, presentation: 'To Status'),
                                  NsgTableColumn(name: BusinessProcessTransitionTableGenerated.nameUserRoleId, expanded: true, presentation: 'User Permission'),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 800,
                                  decoration: BoxDecoration(color: const Color.fromARGB(255, 195, 218, 236), borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      const Text('Transition Status'),
                                      Row(
                                        children: [getTransitionStatus()],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTransitionStatus() {
    List<Widget> list = [];

    for (var status in controller.currentItem.transitionTable.rows) {
      list.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(child: Text(status.statusFrom.name)),
                    ))),
            const SizedBox(
              child: Text('---------------->'),
            ),
            Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(child: Text(status.toString())),
                    ))),
            SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(child: Text('Who can change ->${status.userRole}')),
                )),
          ],
        ),
      ));
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      ),
    );
  }
}
