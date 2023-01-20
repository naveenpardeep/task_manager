import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    organizationName;
    if (userAccountController.lateInit) {
      userAccountController.requestItems();
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
          child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Center(
                  child: Text(
                    '${userAccountController.currentItem.name} ',
                    style: const TextStyle(color: Colors.black),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: ClipOval(
                                    child: Image.network(
                                        width: 70,
                                        height: 70,
                                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80'),
                                  ),
                                ),
                                Row(children: [
                                  TextButton(
                                      onPressed: (() {
                                        selectOrganization();
                                      }),
                                      child:
                                          Text('Организация $organizationName'))
                                ]),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Должность  : ${userAccountController.currentItem.position}'),
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
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  'Имя пользователя  : ${userAccountController.currentItem.name}'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  'Телефон   : ${userAccountController.currentItem.phoneNumber}'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  'Почта   : ${userAccountController.currentItem.email}'),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
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
