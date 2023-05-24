// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/user_role/user_role_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

import 'package:task_manager_app/model/data_controller_model.dart';

import '../widgets/tt_nsg_input.dart';

class ProjectUserViewPage extends GetView<ProjectItemUserTableController> {
  const ProjectUserViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool res;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
                // NsgAppBar(
                //   color: Colors.black,
                //   backColor: Colors.white,
                //   text: controller.currentItem.userAccount.name,
                //   icon: Icons.arrow_back_ios_new,
                //   colorsInverted: true,
                //   bottomCircular: true,
                //   onPressed: () {
                //     controller.itemPageCancel();
                //   },
                //   icon2: Icons.check,
                //   onPressed2: () async {
                //     await controller.itemPagePost();
                //     await Get.find<ProjectController>().itemPagePost();
                //   },
                // ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipOval(
                                    child: controller.currentItem.userAccount.photoName.isEmpty
                                        ? Container(
                                            decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                            width: 120,
                                            height: 120,
                                            child: Icon(
                                              Icons.account_circle,
                                              size: 50,
                                              color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                            ),
                                          )
                                        : Image.network(
                                            TaskFilesController.getFilePath(controller.currentItem.userAccount.photoName),
                                            fit: BoxFit.fill,
                                            width: 120,
                                            height: 120,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ' ${controller.currentItem.userAccount.name}',
                                          style: const TextStyle(fontFamily: 'Inter', fontSize: 21),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            ' ${controller.currentItem.userAccount.position}',
                                            style: const TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Дата рождения ',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      NsgDateFormat.dateFormat(controller.currentItem.userAccount.birthDate, format: 'dd.MM.yy').toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Телефон              ',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.currentItem.userAccount.phoneNumber,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Почта                    ',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.currentItem.userAccount.email,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Организация       ',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${controller.currentItem.userAccount.organization}',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 5,
                              indent: 4,
                            ),
                            TTNsgInput(
                              selectionController: Get.find<UserRoleController>(),
                              dataItem: controller.currentItem,
                              fieldName: ProjectItemUserTableGenerated.nameRoleId,
                              label: 'User Role',
                            ),
                            NsgButton(
                              color: Colors.red,
                              backColor: Colors.transparent,
                              text: 'Исключить из проекта',
                              onPressed: () async {
                                try {
                                  var dataController = Get.find<DataController>();
                                  var projController = Get.find<ProjectController>();
                                  res = (await dataController.removeUser(projController.currentItem.id, controller.currentItem.userAccountId, '',
                                          showProgress: true))
                                      .first;

                                  if (res) {
                                    Get.find<ProjectController>().currentItem.tableUsers.removeRow(Get.find<ProjectItemUserTableController>().currentItem);

                                    Get.back();
                                    projController.refreshData();
                                  }
                                  if (res == false) {
                                    //for selecting new user
                                    controller.refreshData();
                                    Get.toNamed(Routes.newUserForDeletedUserPage);
                                  }
                                } on NsgApiException {
                                  throw Get.snackbar('', 'Project Leader can not be Deleted');
                                }

                                //  showAlertDialog(context, controller.currentItem);
                              },
                            ),
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

  showAlertDialog(BuildContext context, user) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        Get.find<ProjectItemUserTableController>().currentItem = user;
        Get.find<ProjectController>().currentItem.tableUsers.removeRow(Get.find<ProjectItemUserTableController>().currentItem);
        Get.find<ProjectController>().itemPagePost();

        Navigator.of(context).pop();
      },
    );
    Widget noButton = ElevatedButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to Delete?"),
      actions: [okButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
