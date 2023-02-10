import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';
import '../widgets/helper.dart';

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
          File imageFile = File(value[0].filePath);
          List<int> imagebytes = await imageFile.readAsBytes();
          Get.find<DataController>().currentUser.photoFile = imagebytes;
          await userAccountController.postItems([Get.find<DataController>().currentUser]);
          await userAccountController.refreshData();
          //userAccountController.sendNotify();
          Navigator.of(Get.context!).pop();
        },
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
                appBar: AppBar(
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
                ),
                body: SafeArea(
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
                                            child: Image.memory(
                                              Uint8List.fromList(Get.find<DataController>().currentUser.photoFile),
                                              width: 70,
                                              height: 70,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                          onPressed: (() {
                                            selectOrganization();
                                          }),
                                          child: Text('Организация ${orgController.currentItem.name}')),
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
                        SizedBox(
                          width: width,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 10, 20, 0),
                                  child: Text(
                                    'Уведомления',
                                    textScaleFactor: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: Get.find<DataController>().currentUser,
                                    fieldName: UserAccountGenerated.nameSettingNotifyByPush,
                                    label: 'Показывать push-уведомления',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: Get.find<DataController>().currentUser,
                                    fieldName: UserAccountGenerated.nameSettingNotifyByEmail,
                                    label: 'Отправлять уведомления на почту',
                                    // onChanged: (p0) async {
                                    //  await userAccountController.itemPagePost(goBack: false);
                                    // },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgText(
                                    'МОИ ЗАДАЧИ',
                                    color: ControlOptions.instance.colorGrey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: Get.find<DataController>().currentUser,
                                    fieldName: UserAccountGenerated.nameSettingNotifyNewTasks,
                                    label: 'Создана задача с моим участием',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: Get.find<DataController>().currentUser,
                                    fieldName: UserAccountGenerated.nameSettingNotifyEditedTasks,
                                    label: 'Все изменения в задачах с моим участием',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgText(
                                    'ЗАДАЧИ ПРОЕКТОВ',
                                    color: ControlOptions.instance.colorGrey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: Get.find<DataController>().currentUser,
                                    fieldName: UserAccountGenerated.nameSettingNotifyNewTasksInProjects,
                                    label: 'Новая задача в проекте',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: Get.find<DataController>().currentUser,
                                    fieldName: UserAccountGenerated.nameSettingNotifyEditedTasksInProjects,
                                    label: 'Все изменения в задачах проектов',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgText(
                                    'ПРОЕКТЫ-ИСКЛЮЧЕНИЯ',
                                    color: ControlOptions.instance.colorGrey,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: NsgTable(
                                //     controller: Get.find<UserNotificationController>(),
                                //     elementEditPageName:
                                //         Routes.userProjectListPage,
                                //     availableButtons: const [NsgTableMenuButtonType.createNewElement],
                                //     columns: [
                                //       NsgTableColumn(
                                //           name: UserNotificationSettingsGenerated.nameProjectId,
                                //           expanded: true,
                                //           presentation: 'Проекты'),
                                //     ],
                                //   ),
                                // ),
                                Get.find<UserNotificationController>().obx(
                                  (state) => (projectList()),
                                ),

                                Center(
                                  child: NsgButton(
                                    text: '+ добавить проект для уведомлений',
                                    borderRadius: 10,
                                    onPressed: () {
                                      Get.find<UserNotificationController>()
                                          .newItemPageOpen(pageName: Routes.userProjectListPage);
                                    },
                                  ),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.all(10.0),
                                //   child: SizedBox(
                                //     width: width,
                                //     height: 200,
                                //     child: NsgListPage(
                                //         appBar: const SizedBox(),
                                //         appBarIcon: null,
                                //         appBarIcon2: null,
                                //         appBarBackColor:
                                //             const Color(0xff7876D9),
                                //         appBarColor: Colors.white,
                                //         type: NsgListPageMode.table,
                                //         controller: Get.find<
                                //             UserNotificationController>(),
                                //         title: '',
                                //         textNoItems: '',
                                //         elementEditPage:
                                //             Routes.userProjectListPage,
                                //         onElementTap: (element) {
                                //           element as UserNotificationSettings;

                                //           Get.find<UserNotificationController>()
                                //               .currentItem = element;
                                //           Get.toNamed(Routes
                                //               .userNotificationNewTaskPage);
                                //         },
                                //         availableButtons: const [
                                //           NsgTableMenuButtonType
                                //               .createNewElement,
                                //           NsgTableMenuButtonType.editElement,
                                //           NsgTableMenuButtonType.removeElement
                                //         ],
                                //         columns: [
                                //           NsgTableColumn(
                                //               name:
                                //                   UserNotificationSettingsGenerated
                                //                       .nameProjectId,
                                //               expanded: true,
                                //               presentation: 'Название проекта'),
                                //         ]),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
      onPressed: () async {
        Get.find<UserNotificationController>().currentItem = project;
        await Get.find<UserNotificationController>().deleteItems([Get.find<UserNotificationController>().currentItem]);
        Get.find<UserNotificationController>().sendNotify();
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
