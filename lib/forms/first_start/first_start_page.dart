import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_grid.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import '../../app_pages.dart';
import '../widgets/top_menu.dart';

// ignore: must_be_immutable
class FirstStartPage extends GetView<OrganizationController> {
  FirstStartPage({Key? key}) : super(key: key);

  final scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double? width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return BodyWrap(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (width! > 991) const TmTopMenu(),
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Зарегистрированные организации',
                      style: TextStyle(color: ControlOptions.instance.colorText, fontSize: ControlOptions.instance.sizeXL),
                    ),
                  ),
                  NsgButton(
                    width: 150,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    height: 40,
                    icon: Icons.add,
                    text: 'Новая огранизация',
                    color: Colors.white,
                    backColor: ControlOptions.instance.colorMain,
                    onPressed: () {
                      Get.find<OrganizationController>().newItemPageOpen(pageName: Routes.organizationPage);
                    },
                  ),
                ],
              )),
          Expanded(child: controller.obx((state) => showOrganization())),
          if (width! < 700) const BottomMenu(),
        ],
      )),
    );
  }

  Widget showOrganization() {
    List<Widget> list = [];
    for (var project in controller.items) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            // var taskConstroller = Get.find<TasksController>();
            // Get.find<TaskBoardController>().sendNotify();
            // controller.currentItem = project;
            // taskConstroller.refreshData();
            // Get.toNamed(Routes.homePage);
          },
          onLongPress: () {
            // controller.itemPageOpen(project, Routes.projectPage);
          },
          child: Row(
            children: [
              Expanded(
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  project.name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: ControlOptions.instance.sizeL, height: 1),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 5),
                              //   child: NsgCircle(
                              //     text: '55',
                              //     fontSize: 14,
                              //     borderWidth: 1.3,
                              //     color: ControlOptions.instance.colorText,
                              //     shadow: const BoxShadow(),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 5),
                              //   child: NsgCircle(
                              //     text: '2',
                              //     fontSize: 14,
                              //     borderWidth: 1.3,
                              //     color: ControlOptions.instance.colorText,
                              //     borderColor:
                              //         ControlOptions.instance.colorWarning,
                              //     shadow: const BoxShadow(),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 5),
                              //   child: NsgCircle(
                              //     text: '1',
                              //     fontSize: 14,
                              //     borderWidth: 1.3,
                              //     color: ControlOptions.instance.colorText,
                              //     borderColor:
                              //         ControlOptions.instance.colorError,
                              //     shadow: const BoxShadow(),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Рук.: ${project.name}',
                                    style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: ControlOptions.instance.colorGreyDark)),
                                // Text('Заказчик: ${project.contractor}',
                                //     style: TextStyle(
                                //         fontSize: ControlOptions.instance.sizeS,
                                //         color: ControlOptions
                                //             .instance.colorGreyDark)),
                              ],
                            )),
                            ClipOval(
                              child: Image.network(
                                  width: 32,
                                  height: 32,
                                  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return RawScrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        controller: scrollController,
        thickness: 10,
        trackBorderColor: ControlOptions.instance.colorGreyLight,
        trackColor: ControlOptions.instance.colorGreyLight,
        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
        radius: const Radius.circular(0),
        child: SingleChildScrollView(
            controller: scrollController, child: width! > 991 ? NsgGrid(crossAxisCount: width! ~/ 400, children: list) : Column(children: list)));
  }
}
