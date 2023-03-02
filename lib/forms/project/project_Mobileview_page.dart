import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/helpers/nsg_data_format.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/projectUserMobile.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_page_tables.dart';
import 'package:task_manager_app/forms/project/project_page_users.dart';
import 'package:task_manager_app/forms/project/projectboardMobile.dart';

class ProjectMobileViewPage extends StatefulWidget {
  const ProjectMobileViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectMobileViewPage> createState() => _ProjectMobileViewPageState();
}

class _ProjectMobileViewPageState extends State<ProjectMobileViewPage> with TickerProviderStateMixin {
  DateFormat formateddate = DateFormat("dd.MM.yyyy /HH:mm");
  late TabController _tabController;
  var controller = Get.find<ProjectController>();

  late double height;
  late double width;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
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
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      controller.itemPageOpen(controller.currentItem, Routes.projectEditPage);
                    },
                    icon: const Icon(Icons.edit))
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
                  tabs: const <Widget>[
                    Tab(
                      child: Text(
                        'Основное',
                        style: TextStyle(color: Color(0xff3EA8AB)),
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Доски',
                      style: TextStyle(color: Color(0xff3EA8AB)),
                    )),
                    Tab(
                      child: Text(
                        'Участники',
                        style: TextStyle(color: Color(0xff3EA8AB)),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(controller: _tabController, children: [
              Container(
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
                            thickness: 10,
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
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Название проекта :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  ' ${controller.currentItem.name}',
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
                                                'Организация :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${controller.currentItem.organization}',
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
                                                'Заказчик  :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller.currentItem.contractor.toString(),
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
                                                'Руководитель проекта :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${controller.currentItem.leader}',
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
                                                'Дата создания : ',
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
                                    ),
                                  ],
                                )),
                          )),
                    ),
                  ],
                ),
              ),
              Container(key: GlobalKey(), child: const ProjectBoardMobile()),
              Container(key: GlobalKey(), child: const ProjectUserMobile()),
            ]),
          ),
        ));
  }

  String getCreatedDay() {
    var todayDate = DateTime.now();
    final dateCreated = controller.currentItem.date;
    var daysCreated = todayDate.difference(dateCreated).inDays;
    if (daysCreated > 30) {
      return '${NsgDateFormat.dateFormat(controller.currentItem.date, format: 'dd.MM.yy HH:mm')}';
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
}
