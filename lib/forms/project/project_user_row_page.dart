import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectUserRowPage extends StatefulWidget {
  const ProjectUserRowPage({Key? key}) : super(key: key);
  @override
  State<ProjectUserRowPage> createState() => _ProjectUserRowPageState();
}

class _ProjectUserRowPageState extends State<ProjectUserRowPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  var textEditController = TextEditingController();

  String searchvalue = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<ProjectUserController>().lateInit) {
      Get.find<ProjectUserController>().requestItems();
    }
    if (Get.find<ProjectController>().lateInit) {
      Get.find<ProjectController>().requestItems();
    }
    //  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
      child: Scaffold(
        //  key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //  key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  color: Colors.black,
                  backColor: Colors.white,
                  text: controller.currentItem.isEmpty ? 'Project '.toUpperCase() : controller.currentItem.name,
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () async {
                    Get.find<ProjectItemUserTableController>().usersSaved();
                    //  await controller.itemPagePost();
                    //  await Get.find<ProjectController>().itemPagePost();

                    Get.back();
                    Get.find<ProjectController>().sendNotify();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 35,
                              child: TextField(
                                  controller: textEditController,
                                  decoration: InputDecoration(
                                      filled: false,
                                      fillColor: ControlOptions.instance.colorMainLight,
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                          gapPadding: 1,
                                          borderSide: BorderSide(color: ControlOptions.instance.colorMainDark),
                                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                                      suffixIcon: IconButton(
                                          padding: const EdgeInsets.only(bottom: 0),
                                          onPressed: (() {
                                            setState(() {
                                              
                                            });
                                            textEditController.clear();
                                            searchvalue = '';
                                          }),
                                          icon: const Icon(Icons.cancel)),
                                      // prefixIcon: Icon(Icons.search),
                                      hintText: 'Search Users'),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: TextStyle(color: ControlOptions.instance.colorMainLight),
                                  onChanged: (val) {
                                    setState(() {
                                      searchvalue = val;
                                    });
                                  }),
                            ),

                            // NsgInput(
                            //   controller: controller,
                            //   selectionController:
                            //       Get.find<ProjectUserController>(),
                            //   dataItem: controller.currentItem,
                            //   fieldName: ProjectItemUserTableGenerated
                            //       .nameUserAccountId,
                            //   label: 'User ',
                            // ),
                            // NsgInput(
                            //   dataItem: controller.currentItem,
                            //   fieldName:
                            //       ProjectItemUserTableGenerated.nameIsAdmin,
                            //   label: 'Admin',
                            // ),

                            getProjectuser(context),
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

  Widget getProjectuser(BuildContext context) {
    List<Widget> list = [];
    var projectuseritem = Get.find<ProjectItemUserTableController>().projectUsersList;
    for (var projectuser in projectuseritem) {
      if (projectuser.userAccount.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        list.add(Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipOval(
                      child: projectuser.userAccount.photoFile.isEmpty
                          ? Container(
                              decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                              width: 32,
                              height: 32,
                              child: Icon(
                                Icons.account_circle,
                                size: 20,
                                color: ControlOptions.instance.colorMain.withOpacity(0.4),
                              ),
                            )
                          : Image.memory(
                              Uint8List.fromList(projectuser.userAccount.photoFile),
                              fit: BoxFit.cover,
                              width: 32,
                              height: 32,
                            ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      projectuser.userAccount.name,
                      style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                      width: 30,
                      child: NsgCheckBox(
                          toggleInside: true,
                          key: GlobalKey(),
                          label: '',
                          value: projectuser.isChecked,
                          onPressed: (currentValue) {
                            projectuser.isChecked = currentValue;
                          })),
                ],
              ),
            ),
          ),
        ));
      }
    }
    return SingleChildScrollView(child: Column(children: list));
  }
}
