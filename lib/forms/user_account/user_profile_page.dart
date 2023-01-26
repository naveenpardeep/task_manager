import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_controller.dart';
import 'package:task_manager_app/forms/user_account/user_project_list_page.dart';
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
  var userImageController = Get.find<UserImageController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final scrollController = ScrollController();
  double? width;

  @override
  void initState() {
    super.initState();
    organizationName =
        userAccountController.currentItem.organization.toString();
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
                    TextButton(
                        onPressed: () {
                          userAccountController.itemPageOpen(
                              userAccountController.currentItem,
                              Routes.userAccount);
                        },
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text('Edit Profile'),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ))
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 20),
                                      child: ClipOval(
                                        child: Image.network(
                                            width: 70,
                                            height: 70,
                                            'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80'),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                          onPressed: (() {
                                            selectOrganization();
                                          }),
                                          child: Text(
                                              'Организация $organizationName')),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Text(
                                      'Должность  : ${userAccountController.currentItem.position}'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
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
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10, 20, 0),
                                  child: Text(
                                      'Имя пользователя  : ${userAccountController.currentItem.name}'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10, 20, 0),
                                  child: Text(
                                      'Телефон   : ${userAccountController.currentItem.phoneNumber}'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10, 20, 0),
                                  child: Text(
                                      'Почта   : ${userAccountController.currentItem.email}'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: userAccountController.currentItem,
                                    fieldName: UserAccountGenerated
                                        .nameSettingNotifyByPush,
                                    label: 'Показывать push-уведомления',
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: userAccountController.currentItem,
                                    fieldName: UserAccountGenerated
                                        .nameSettingNotifyByEmail,
                                    label: 'Отправлять уведомления на почту',
                                    // onChanged: (p0) async {
                                    //  await userAccountController.itemPagePost(goBack: false);
                                    // },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgText(
                                    'МОИ ЗАДАЧИ',
                                    color: ControlOptions.instance.colorGrey,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: userAccountController.currentItem,
                                    fieldName: UserAccountGenerated
                                        .nameSettingNotifyNewTasks,
                                    label: 'Создана задача с моим участием',
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: userAccountController.currentItem,
                                    fieldName: UserAccountGenerated
                                        .nameSettingNotifyEditedTasks,
                                    label:
                                        'Все изменения в задачах с моим участием',
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgText(
                                    'ЗАДАЧИ ПРОЕКТОВ',
                                    color: ControlOptions.instance.colorGrey,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: userAccountController.currentItem,
                                    fieldName: UserAccountGenerated
                                        .nameSettingNotifyNewTasksInProjects,
                                    label: 'Новая задача в проекте',
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: NsgInput(
                                    dataItem: userAccountController.currentItem,
                                    fieldName: UserAccountGenerated
                                        .nameSettingNotifyEditedTasksInProjects,
                                    label: 'Все изменения в задачах проектов',
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Divider(
                                    color: ControlOptions.instance.colorBlue,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
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
                                          .newItemPageOpen(
                                              pageName:
                                                  Routes.userProjectListPage);
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
          organizationName =
              userAccountController.currentItem.organization.toString();
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
                              controller.currentItem = project;
                              await controller
                                  .deleteItems([controller.currentItem]);
                              controller.sendNotify();
                            },
                            icon: const Icon(Icons.delete)),
                        Expanded(
                          child: Text(
                            project.project.name,
                            style: TextStyle(
                                color: ControlOptions.instance.colorMainDark,
                                fontWeight: FontWeight.bold,
                                fontSize: ControlOptions.instance.sizeL,
                                height: 1),
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
}
