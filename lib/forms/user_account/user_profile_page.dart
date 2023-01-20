import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_circle.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../../app_pages.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var userAccountController = Get.find<UserAccountController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return userAccountController.obx((state) => (BodyWrap(
          child: Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: ClipOval(
                child: Image.network(
                    width: 70,
                    height: 70,
                    'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80'),
                  ),
                ),
              )),
        )));
  }
}
