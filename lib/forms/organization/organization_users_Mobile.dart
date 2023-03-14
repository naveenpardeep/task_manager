// ignore_for_file: file_names

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/mobile_menu.dart';

class OrganizationUsersMobilePage extends StatefulWidget {
  const OrganizationUsersMobilePage({Key? key}) : super(key: key);
  @override
  State<OrganizationUsersMobilePage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<OrganizationUsersMobilePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<OrganizationItemUserTableController>();

  @override
  void initState() {
    super.initState();
    scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var scrollController = ScrollController();

    return SafeArea(
      child: Scaffold(
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
                              organizationUsersList(context),
                            ],
                          ),
                        ),
                      )),
                ),
                NsgButton(
                  borderRadius: 30,
                  color: Colors.white,
                  backColor: const Color(0xff0859ff),
                  text: '+ Добавить участника в Организация',
                  onPressed: () async {
                    // await Get.find<UserAccountController>().requestItems();
                    Get.find<OrganizationItemUserTableController>().prepapreOrgUsers();
                    Get.find<OrganizationItemUserTableController>().newItemPageOpen(pageName: Routes.organizationUserAddPage);
                  },
                ),
               
                if (width < 700)
                  //const BottomMenu(),
                  const TmMobileMenu()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget organizationUsersList(BuildContext context) {
    List<Widget> list = [];
    var orgUsertable = Get.find<OrganizationItemUserTableController>().items;

    for (var orguser in orgUsertable) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            Get.find<OrganizationItemUserTableController>().currentItem = orguser;
            Get.toNamed(Routes.organizationUserProfile);
          },
          onLongPress: () {},
          child: Column(
            children: [
              Card(
                // elevation: 3,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: orguser.userAccount.photoFile.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                  width: 32,
                                  height: 32,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 20,
                                    color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                  ),
                                )
                              : Image.memory(
                                  Uint8List.fromList(orguser.userAccount.photoFile),
                                  fit: BoxFit.cover,
                                  width: 32,
                                  height: 32,
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
                              orguser.userAccount.position,
                              style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                            ),
                          ],
                        ),
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       showAlertDialog(context, projectuser);
                      //     },
                      //     icon: const Icon(
                      //       Icons.remove_circle_outline,
                      //       color: Colors.red,
                      //     )),
                      const Icon(Icons.arrow_forward_ios),
                    ],
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

  // showAlertDialog(BuildContext context, user) {
  //   // set up the button
  //   Widget okButton = ElevatedButton(
  //     child: const Text("Yes"),
  //     onPressed: () {
  //       Get.find<ProjectItemUserTableController>().currentItem = user;
  //       controller.currentItem.tableUsers.removeRow(Get.find<ProjectItemUserTableController>().currentItem);
  //       controller.itemPagePost();

  //       Navigator.of(context).pop();
  //     },
  //   );
  //   Widget noButton = ElevatedButton(
  //     child: const Text("No"),
  //     onPressed: () {
  //       Navigator.of(context).pop(); // dismiss dialog
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: const Text("Do you want to Delete?"),
  //     actions: [okButton, noButton],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
}
