// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/acceptRejectList.dart';
import 'package:task_manager_app/forms/invitation/invitationAcceptNew.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_profile_page.dart';
import 'package:task_manager_app/model/data_controller.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> with TickerProviderStateMixin {
  DateFormat formateddate = DateFormat("dd.MM.yyyy /HH:mm");
  late TabController _tabController;
  var controller = Get.find<UserAccountController>();

  late double height;
  late double width;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_setindex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var scrollController = ScrollController();
    // var newscrollController = ScrollController();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return controller.obx((state) => SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              actions: [
                if (_tabController.index == 0)
                  IconButton(
                      onPressed: () {
                        if (_tabController.index == 0) {
                          controller.itemPageOpen(Get.find<DataController>().currentUser, Routes.userAccount);
                        }

                        if (_tabController.index == 2) {}
                      },
                      icon: const Icon(Icons.edit)),
              ],

              backgroundColor: Colors.white,
              elevation: 0.0, //Shadow gone
              centerTitle: true,
              title: controller.obx((state) => Text(
                    controller.currentItem.name.toString().toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  )),
              bottom: TabBar(
                  onTap: (value) {
                    setState(() {
                      if (_tabController.index == 0) {
                        _tabController.index = 0;
                      } else if (_tabController.index == 1) {
                        _tabController.index = 1;
                      } else if (_tabController.index == 2) {
                        _tabController.index = 2;
                      }
                    });
                  },
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Основное',
                        style: TextStyle(color: const Color(0xff3EA8AB), fontSize: width < 700 ? 10 : 15),
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Приглашения',
                      style: TextStyle(color: const Color(0xff3EA8AB), fontSize: width < 700 ? 10 : 15),
                    )),
                    Tab(
                        child: Text(
                      'Список приглашений',
                      style: TextStyle(color: const Color(0xff3EA8AB), fontSize: width < 700 ? 10 : 15),
                    )),
                  ]),
            ),
            body: TabBarView(controller: _tabController, children: [
              Container(key: GlobalKey(), child: const UserProfile()),
              Container(key: GlobalKey(), child: const InvitationAcceptNew()),
              Container(key: GlobalKey(), child: const AcceptRejectListPage()),
            ]),
          ),
        ));
  }

  void _setindex() {

    setState(() {
      if (_tabController.index == 0) {
        _tabController.index = 0;
      } else if (_tabController.index == 1) {
        _tabController.index = 1;
      } else if (_tabController.index == 2) {
        _tabController.index = 2;
      }
    });
  
  }
}
