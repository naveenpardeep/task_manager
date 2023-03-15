import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/mobile_menu.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var organizationName = '';
  var userAccountController = Get.find<UserAccountController>();
  var orgController = Get.find<OrganizationController>();
  var userImageController = Get.find<UserImageController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final scrollController = ScrollController();
  double? width;
  late NsgFilePicker picker;

  @override
  void initState() {
    super.initState();
    picker = NsgFilePicker(
        showAsWidget: true,
        skipInterface: true,
        oneFile: true,
        callback: (value) async {
          if (value.isNotEmpty) {
            List<int> imagefile;
            if (kIsWeb) {
              imagefile = await File.fromUri(Uri(path: value[0].filePath)).readAsBytes();
            } else {
              imagefile = await File(value[0].filePath).readAsBytes();
            }
            // File imageFile = File(value[0].filePath);
            //  List<int> imagebytes = await imageFile.readAsBytes();
            Get.find<DataController>().currentUser.photoFile = imagefile;
            await userAccountController.postItems([Get.find<DataController>().currentUser]);
            await userAccountController.refreshData();
          }
          //userAccountController.sendNotify();
          Navigator.of(Get.context!).pop();
        },
        // ignore: prefer_const_literals_to_create_immutables
        objectsList: []);
    organizationName = userAccountController.currentItem.organization.toString();
    if (userAccountController.lateInit) {
      userAccountController.requestItems();
    }
    if (userImageController.lateInit) {
      userImageController.requestItems();
    }
    if (Get.find<UserNotificationController>().lateInit) {
      Get.find<UserNotificationController>().requestItems();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return userAccountController.obx((state) => (BodyWrap(
          child: SafeArea(
            child: Scaffold(
                key: scaffoldKey,
                appBar: width > 700
                    ? AppBar(
                        // ignore: prefer_const_constructors
                        title: Center(
                          child: const Text(
                            'Аккаунт ',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              userAccountController.itemPageOpen(Get.find<DataController>().currentUser, Routes.userAccount);
                            },
                            icon: const Icon(Icons.edit),
                          )
                        ],
                        leading: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        backgroundColor: Colors.white,
                        //  toolbarHeight: 200, // Set this height
                      )
                    : null,
                body: SafeArea(
                  child: Column(children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: width,
                            child: Card(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                Get.dialog(picker, barrierDismissible: true);
                                              },
                                              child: Get.find<DataController>().currentUser.photoFile.isEmpty
                                                  ? Container(
                                                      decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                                      width: 100,
                                                      height: 100,
                                                      child: Icon(
                                                        Icons.add_a_photo,
                                                        size: 32,
                                                        color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                                      ),
                                                    )
                                                  : Image.memory(
                                                      Uint8List.fromList(Get.find<DataController>().currentUser.photoFile),
                                                      fit: BoxFit.cover,
                                                      width: 100,
                                                      height: 100,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: Colors.white,
                                          width: width * 0.5,
                                          child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: organizationList()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                    child: Text('Должность  : ${Get.find<DataController>().currentUser.position}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                    child: Divider(
                                      color: ControlOptions.instance.colorBlue,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width,
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                                    child: Text('Организация  : ${Get.find<DataController>().currentUser.organization.name}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                                    child: Text('Имя пользователя  : ${Get.find<DataController>().currentUser.name}'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                    child: Divider(
                                      color: ControlOptions.instance.colorBlue,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                                    child: Text('Телефон   : ${Get.find<DataController>().currentUser.phoneNumber}'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                    child: Divider(
                                      color: ControlOptions.instance.colorBlue,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                                    child: Text('Почта   : ${Get.find<DataController>().currentUser.email}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                    child: Divider(
                                      color: ControlOptions.instance.colorBlue,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ]),
                )),
          ),
        )));
  }

  selectOrganization() {
    var form = NsgSelection(
      inputType: NsgInputType.reference,
      controller: Get.find<OrganizationController>(),
    );
    form.selectFromArray(
      'Организация',
      (item) {
        setState(() {
          organizationName = userAccountController.currentItem.organization.toString();
        });
      },
    );
  }

  Widget projectList() {
    var controller = Get.find<UserNotificationController>();
    List<Widget> list = [];
    for (var project in controller.items) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            controller.currentItem = project;
            Get.toNamed(Routes.userNotificationNewTaskPage);
          },
          onLongPress: () {
            // controller.itemPageOpen(project, Routes.projectPage);
          },
          child: Row(
            children: [
              Expanded(
                child: Card(
                  // elevation: 3,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              // controller.currentItem = project;
                              // await controller
                              //     .deleteItems([controller.currentItem]);
                              // controller.sendNotify();
                              showAlertDialog(context, project);
                            },
                            icon: const Icon(Icons.delete)),
                        Expanded(
                          child: Text(
                            project.project.name,
                            style: TextStyle(
                              color: ControlOptions.instance.colorMainDark,
                              fontSize: ControlOptions.instance.sizeL,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios)
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
    return SingleChildScrollView(child: Column(children: list));
  }

  showAlertDialog(BuildContext context, UserNotificationSettings project) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        Get.find<UserNotificationController>().currentItem = project;
        Get.find<UserNotificationController>().deleteItems([Get.find<UserNotificationController>().currentItem]).then((value) {
          Get.find<UserNotificationController>().sendNotify();
          Navigator.of(context).pop();
        });
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

  Widget organizationList() {
    var list = <Widget>[];
    for (var org in orgController.items) {
      list.add(TextButton(
          onPressed: (() {
            Get.find<DataController>().currentUser = Get.find<UserAccountController>().getUserByOrganization(org);
            setState(() {});
          }),
          child: Text(org.name)));
    }
    return Row(
      children: list,
    );
  }
}
