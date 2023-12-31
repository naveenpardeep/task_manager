// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_light_app_bar.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/organization/organization_projects.dart';
import 'package:task_manager_app/forms/organization/organization_users_Mobile.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';

import '../widgets/tt_tabs.dart';

class OrganizationViewPageMobile extends StatefulWidget {
  const OrganizationViewPageMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<OrganizationViewPageMobile> createState() => _OrganizationViewPageMobileState();
}

class _OrganizationViewPageMobileState extends State<OrganizationViewPageMobile> with TickerProviderStateMixin {
  DateFormat formateddate = DateFormat("dd.MM.yyyy /HH:mm");
  late TabController _tabController;
  TTTabsTab currentTab = TTTabsTab(name: 'Основное', onTap: (v) {});
  var controller = Get.find<OrganizationController>();
  var orgTable = Get.find<OrganizationItemUserTableController>().items;

  late double height;
  late double width;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    if (controller.lateInit) {
      controller.requestItems();
    }

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_indexSet);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return controller.obx((state) => SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            body: Column(
              children: [
                controller.obx((state) => NsgLightAppBar(
                      title: controller.currentItem.name.toString().toUpperCase(),
                      leftIcons: [
                        NsgLigthAppBarIcon(
                          color: Colors.black,
                            onTap: () {
                              Get.toNamed(Routes.organizationListMobilePage);
                            },
                            icon: Icons.arrow_back_ios)
                      ],
                      rightIcons: [
                        if (currentTab.name == 'Основное')
                          NsgLigthAppBarIcon(
                            color: Colors.black,
                              onTap: () {
                                controller.itemPageOpen(controller.currentItem, Routes.createOrganizationPage, needRefreshSelectedItem: true);
                              },
                              icon: Icons.edit),
                      ],
                    )),
                TTTabs(
                  currentTab: currentTab,
                  tabs: [
                    TTTabsTab(
                        name: 'Основное',
                        onTap: (v) {
                          currentTab = v;
                          setState(() {});
                        }),
                    TTTabsTab(
                        name: 'Сотрудники',
                        onTap: (v) {
                          currentTab = v;
                          setState(() {});
                        }),
                    TTTabsTab(
                        name: 'Проекты',
                        onTap: (v) {
                          currentTab = v;
                          setState(() {});
                        })
                  ],
                ),
                Expanded(child: controller.obx((state) => getContent())),
              ],
            ),
          ),
        ));
  }

  Widget getContent() {
    if (currentTab.name == 'Основное') {
      return Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                  child: RawScrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    controller: scrollController,
                    thickness: width > 700 ? 10 : 0,
                    trackBorderColor: ControlOptions.instance.colorGreyLight,
                    trackColor: ControlOptions.instance.colorGreyLight,
                    thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                    radius: const Radius.circular(0),
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipOval(
                                      child: controller.currentItem.photoPath.isEmpty
                                          ? Container(
                                              decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                              width: 120,
                                              height: 120,
                                              child: Icon(
                                                Icons.account_circle,
                                                size: 20,
                                                color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                              ),
                                            )
                                          : Image.network(
                                              TaskFilesController.getFilePath(controller.currentItem.photoPath),
                                              fit: BoxFit.cover,
                                              width: 120,
                                              height: 120,
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ' ${controller.currentItem.name}',
                                        style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Администратор        ',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      controller.currentItem.ceo.toString(),
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
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Дата создания          ',
                                    style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      getCreatedDay(),
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  )),
            ),
            if (width < 700) const BottomMenu(),
            //const TmMobileMenu()
          ],
        ),
      );
    }
    if (currentTab.name == 'Сотрудники') {
      return Container(key: GlobalKey(), child: const OrganizationUsersMobilePage());
    }
    return Container(key: GlobalKey(), child: OrganizationProject());
  }

  String getCreatedDay() {
    var todayDate = DateTime.now();
    final dateCreated = controller.currentItem.dateCreated;
    var daysCreated = todayDate.difference(dateCreated).inDays;
    if (daysCreated > 30) {
      return '${NsgDateFormat.dateFormat(controller.currentItem.dateCreated, format: 'dd.MM.yy HH:mm')}';
    }
    var minutes = todayDate.difference(dateCreated).inMinutes;
    if (minutes < 60) {
      return '$minutes мин. назад';
    }
    var hours = todayDate.difference(dateCreated).inHours;
    if (hours <= 24) {
      return '$hours Час. назад';
    }

    if (daysCreated <= 30) {
      return '$daysCreated дн. назад';
    }

    return '$daysCreated дн. назад';
  }

  void _indexSet() {
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
