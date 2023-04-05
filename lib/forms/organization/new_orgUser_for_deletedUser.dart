// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/app_pages.dart';

import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';


class NewOrgUserForDeletedUserPage extends StatefulWidget {
  const NewOrgUserForDeletedUserPage({Key? key}) : super(key: key);
  @override
  State<NewOrgUserForDeletedUserPage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<NewOrgUserForDeletedUserPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<OrganizationController>();

  @override
  void initState() {
    super.initState();

    scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(child: Text('Выберите пользователя для назначения отложенных задач')),
        ),
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            key: GlobalKey(),
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
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              orgUsersList(context),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orgUsersList(BuildContext context) {
    List<Widget> list = [];
    bool res;

    for (var orguser in controller.currentItem.tableUsers.rows.where((element) => element.userAccountId!=Get.find<OrganizationItemUserTableController>().currentItem.userAccountId)) {
      list.add(Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        child: InkWell(
          onTap: () async {
            var dataController = Get.find<DataController>();
           
            res = (await dataController.removeUser(
                    controller.currentItem.id, Get.find<OrganizationItemUserTableController>().currentItem.userAccountId, orguser.userAccountId,
                    showProgress: true))
                .first;

            if (res) {
              controller.currentItem.tableUsers.removeRow( Get.find<OrganizationItemUserTableController>().currentItem);
              Get.find<OrganizationItemUserTableController>().selectedItem=null;
              Get.toNamed(Routes.organizationViewPageMobile);
              controller.refreshData();
            }
          },
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipOval(
                      child: orguser.userAccount.photoName.isEmpty
                          ? Container(
                              decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.account_circle,
                                size: 48,
                                color: ControlOptions.instance.colorMain.withOpacity(0.4),
                              ),
                            )
                          : Image.network(
                              TaskFilesController.getFilePath(orguser.userAccount.photoName),
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         orguser.userAccount.name,
                          style: TextStyle(
                            fontSize: ControlOptions.instance.sizeL,
                          ),
                        ),
                        Text(
                          orguser.userAccount.phoneNumber,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                        ),
                      ],
                    ),
                  ),
                  if (orguser.isAdmin) const Icon(Icons.admin_panel_settings),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orguser.userAccount.organization.name,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                        ),
                       
                      ],
                    ),
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      ));
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  
}
