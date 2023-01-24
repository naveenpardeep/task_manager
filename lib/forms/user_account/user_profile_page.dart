import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_newTask_controller.dart';
import 'package:task_manager_app/model/generated/organization_item.g.dart';

import '../../app_pages.dart';
import '../../model/generated/user_account.g.dart';

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
                                NsgInput(
                                  dataItem: userAccountController.currentItem,
                                  fieldName: UserAccountGenerated
                                      .nameSettingNotifyByPush,
                                  label: 'Показывать push-уведомления',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                NsgInput(
                                  dataItem: userAccountController.currentItem,
                                  fieldName: UserAccountGenerated
                                      .nameSettingNotifyByEmail,
                                  label: 'Отправлять уведомления на почту',
                                  // onChanged: (p0) async {
                                  //  await userAccountController.itemPagePost(goBack: false);
                                  // },
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
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Expanded(
                                          child: Text(
                                              'Новая задача с моим участием')),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.arrow_forward_ios),
                                        onPressed: () {
                                          Get.toNamed(Routes
                                              .userNotificationNewTaskPage);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Expanded(
                                          child:
                                              Text('Все изменения в задаче')),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.arrow_forward_ios),
                                        onPressed: () {},
                                      )
                                    ],
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
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Expanded(
                                          child:
                                              Text('Новая задача в проекте')),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.arrow_forward_ios),
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Expanded(
                                          child: Text(
                                              'Все изменения в задачах проектов')),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.arrow_forward_ios),
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                ),
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
}
