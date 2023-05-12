// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';

import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/organization/organization_userProfile.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';

import '../../model/organization_item_user_table.dart';

class OrganizationUsersMobilePage extends StatefulWidget {
  const OrganizationUsersMobilePage({Key? key}) : super(key: key);
  @override
  State<OrganizationUsersMobilePage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<OrganizationUsersMobilePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<OrganizationController>();
  var orgtable = Get.find<OrganizationItemUserTableController>();

  @override
  void initState() {
    super.initState();
    scaffoldKey;
    if (orgtable.lateInit) {
      orgtable.requestItems();
    }
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
                        thickness: width > 700 ? 10 : 0,
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

                if (width < 700) const BottomMenu(),
                //const TmMobileMenu()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget organizationUsersList(BuildContext context) {
    List<Widget> list = [];
    double height = MediaQuery.of(context).size.height;
    //var orgUsertable = Get.find<OrganizationItemUserTableController>().items;

    for (var orguser in controller.currentItem.tableUsers.rows) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            Get.find<OrganizationItemUserTableController>().currentItem = orguser;
            // Get.find<OrganizationItemUserTableController>().itemPageOpen(orguser, Routes.organizationUserProfile);
            //   Get.toNamed(Routes.organizationUserProfile);
            showdialogBuilder(context, height, orguser);
          },
          onLongPress: () {},
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipOval(
                      child: orguser.userAccount.photoName.isEmpty
                          ? Container(
                              decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                              width: 48,
                              height: 48,
                              child: Icon(
                                Icons.account_circle,
                                size: 32,
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
                  //   const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return SingleChildScrollView(child: Column(children: list));
  }

  Future<void> showdialogBuilder(BuildContext context, height, OrganizationItemUserTable orguser) {
    return showModalBottomSheet<void>(
      context: context,
      constraints: BoxConstraints(maxHeight: height - 30),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          insetPadding: const EdgeInsets.all(0),
          child: Column(children: [
            const Padding(padding: EdgeInsets.only(top: 5)),
            TTAppBar(
              title: orguser.userAccount.toString(),
              rightIcons: [
                TTAppBarIcon(
                  icon: Icons.check,
                  onTap: () async {
                 
                    await controller.postItems([controller.currentItem]);
                    controller.refreshData();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
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
            SizedBox(height: height - 100, child: const OrganizationUserProfile()),
          ]),
        );
      },
    );
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
