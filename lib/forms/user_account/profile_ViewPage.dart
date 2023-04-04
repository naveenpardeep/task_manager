// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/invitation/invitationAcceptNew.dart';
import 'package:task_manager_app/forms/user_account/nottification_settings.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_profile_page.dart';
import 'package:task_manager_app/forms/widgets/nsg_dialog.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../notification/notification_controller.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/nott_item.dart';
import '../widgets/top_menu.dart';
import '../widgets/tt_app_bar.dart';
import '../widgets/tt_tabs.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> with TickerProviderStateMixin {
  DateFormat formateddate = DateFormat("dd.MM.yyyy /HH:mm");
  //late TabController _tabController;
  var controller = Get.find<UserAccountController>();

  TTTabsTab currentTab = TTTabsTab(name: 'Профиль', onTap: (v) {});

  late double height;
  late double width;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();
  var notifC = Get.find<NotificationController>();
  final NsgDialogBodyController nsgDialogBodyController = NsgDialogBodyController(); /////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();

    //_tabController = TabController(length: 3, vsync: this);
    //_tabController.addListener(_setindex);
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var scrollController = ScrollController();
    // var newscrollController = ScrollController();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
        child: NsgDialogBody(
      controller: nsgDialogBodyController,
      key: scaffoldKey,

      /*appBar: AppBar(
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
              ),*/

      children: [
        if (width > 700) const TmTopMenu(),
        if (width <= 700)
          TTAppBar(
            title: 'Аккаунт',
            rightIcons: [
              if (currentTab.name == 'Профиль')
                TTAppBarIcon(
                  icon: Icons.edit_outlined,
                  onTap: () {
                    var userAcC = Get.find<UserAccountController>();
                    userAcC.itemPageOpen(userAcC.currentItem, Routes.profileEditPage);
                  },
                ),
              TTAppBarIcon(
                icon: Icons.notifications_outlined,
                nott: 1,
                onTap: (() {
                  notifC.refreshData();
                  nsgDialogBodyController.openDialog(dialogBody());
                  //NsgDialog().showNsgBottomDialog(context, dialogBody());
                  //_dialogBuilder(context);
                }),
              )
            ],
          ),
        TTTabs(
          currentTab: currentTab,
          tabs: [
            TTTabsTab(
                name: 'Профиль',
                onTap: (v) {
                  currentTab = v;
                  setState(() {});
                }),
            TTTabsTab(
                name: 'Уведомления',
                onTap: (v) {
                  currentTab = v;
                  Get.find<UserAccountController>().saveBackup(Get.find<DataController>().mainProfile);
                  setState(() {});
                }),
            TTTabsTab(
                name: 'Приглашения',
                onTap: (v) {
                  currentTab = v;
                  setState(() {});
                })
          ],
        ),
        Expanded(child: controller.obx((state) => content())),
        if (width < 700)
          //  const BottomMenu()
          const BottomMenu()
      ],
    )

        /*TabBarView(controller: _tabController, children: [
              Container(key: GlobalKey(), child: const UserProfile()),
              Container(key: GlobalKey(), child: const InvitationAcceptNew()),
              Container(key: GlobalKey(), child: const AcceptRejectListPage()),
            ]),*/

        );
  }

  Widget content() {
    if (currentTab.name == 'Профиль') {
      return const UserProfile();
    }
    if (currentTab.name == 'Уведомления') {
      return const NotificationSettings();
    }
    return const InvitationAcceptNew();
  }

  Widget dialogBody() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 5)),
        TTAppBar(
          title: 'Уведомления',
          rightIcons: [
            TTAppBarIcon(
              icon: Icons.settings,
              onTap: () {},
            ),
          ],
          leftIcons: [
            TTAppBarIcon(
              icon: Icons.arrow_back_ios_new,
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        Expanded(child: notifC.obx(
          (state) {
            return SingleChildScrollView(
              child: Column(children: getNotifications()),
            );
          },
        )),
        TaskButton(
          text: "Пометить все как прочитанные",
          onTap: () {},
        )
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      constraints: BoxConstraints(maxHeight: height - 30),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          insetPadding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 5)),
              TTAppBar(
                title: 'Уведомления',
                rightIcons: [
                  TTAppBarIcon(
                    icon: Icons.settings,
                    onTap: () {},
                  ),
                ],
                leftIcons: [
                  TTAppBarIcon(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Expanded(child: notifC.obx(
                (state) {
                  return SingleChildScrollView(
                    child: Column(children: getNotifications()),
                  );
                },
              )),
              TaskButton(
                text: "Пометить все как прочитанные",
                onTap: () {},
              )
            ],
          ),
        );
      },
    );
  }

  List<NottItem> getNotifications() {
    List<NottItem> list = [];

    for (var notif in notifC.items) {
      list.add(NottItem(notification: notif));
    }

    return list;
  }
  /*
  AlertDialog(
          title: TTAppBar(
            title: 'Уведомления',
            rightIcons: [
              TTAppBarIcon(
                icon: Icons.settings,
                onTap: () {},
              ),
            ],
            leftIcons: [
              TTAppBarIcon(
                icon: Icons.arrow_back_ios_new,
                onTap: () {},
              )
            ],
          ),
          content: Expanded(
            child: Container(color: Colors.white),
          ),
          actions: <Widget>[
            TaskButton(
              text: 'Прочитать все',
              onTap: () {},
            )
          ],
        );
  
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
  }*/
}
