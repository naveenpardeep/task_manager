// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/invitation/acceptController.dart';

import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_userViewpage.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';
import 'package:task_manager_app/model/generated/project_item_user_table.g.dart';
import 'package:task_manager_app/model/project_item_user_table.dart';

import '../../model/generated/user_account.g.dart';

class ProjectUserMobile extends StatefulWidget {
  const ProjectUserMobile({Key? key}) : super(key: key);
  @override
  State<ProjectUserMobile> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectUserMobile> {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  var invitations = Get.find<AccpetController>();
  var textEditController = TextEditingController();

  String searchvalue = '';

  @override
  void initState() {
    super.initState();

    if (invitations.lateInit) {
      invitations.requestItems();
    }
    scaffoldKey;
  }

  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //  key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                  child: RefreshIndicator(
                      onRefresh: () {
                        return controller.refreshData();
                      },
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
                              if (controller.currentItem.name.isNotEmpty && width < 700)
                                SizedBox(
                                  height: 35,
                                  child: TextField(
                                      controller: textEditController,
                                      decoration: InputDecoration(
                                          filled: false,
                                          fillColor: ControlOptions.instance.colorMainLight,
                                          prefixIcon: const Icon(Icons.search),
                                          border: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(color: ControlOptions.instance.colorMainDark),
                                              borderRadius: const BorderRadius.all(Radius.circular(20))),
                                          suffixIcon: IconButton(
                                              padding: const EdgeInsets.only(bottom: 0),
                                              onPressed: (() {
                                                setState(() {});
                                                textEditController.clear();
                                                searchvalue = '';
                                              }),
                                              icon: const Icon(Icons.cancel)),
                                          // prefixIcon: Icon(Icons.search),
                                          hintText: 'Search Users'),
                                      textAlignVertical: TextAlignVertical.bottom,
                                      style: TextStyle(color: ControlOptions.instance.colorMainLight),
                                      onChanged: (val) {
                                        setState(() {
                                          searchvalue = val;
                                        });
                                      }),
                                ),
                              invitations.obx((state) => projectuserInvitations(context)),
                              if (width < 700) projectUsersList(context),
                              if (width > 700)
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: NsgTable(
                                    showIconFalse: false,
                                    controller: Get.find<ProjectItemUserTableController>(),
                                    elementEditPageName: Routes.projectUserViewPage,
                                    availableButtons: const [
                                      NsgTableMenuButtonType.editElement,
                                    ],
                                    columns: [
                                      NsgTableColumn(name: ProjectItemUserTableGenerated.nameUserAccountId, expanded: true, presentation: 'Name'),
                                      NsgTableColumn(name: ProjectItemUserTableGenerated.nameUserEmail, expanded: true, presentation: 'Email'),
                                      NsgTableColumn(name: ProjectItemUserTableGenerated.nameUserPhone, expanded: true, presentation: 'Phone'),
                                      NsgTableColumn(name: ProjectItemUserTableGenerated.nameRoleId, expanded: true, presentation: 'User Role'),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      )),
                )),
                if (controller.currentItem.name.isNotEmpty)
                  NsgButton(
                    borderRadius: 30,
                    color: Colors.white,
                    backColor: const Color(0xff0859ff),
                    text: '+ Добавить участника в проект',
                    onPressed: () async {
                      await Get.find<ProjectUserController>().requestItems();
                      Get.find<ProjectItemUserTableController>().prepapreProjectUsers();

                      Get.find<ProjectItemUserTableController>().newItemPageOpen(pageName: Routes.projectuserRowpage);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget projectuserInvitations(BuildContext context) {
    List<Widget> list = [];

    var invitations = Get.find<AccpetController>()
        .items
        .reversed
        .where((element) => element.project.name == controller.currentItem.name && element.isAccepted == false && element.isRejected == false);

    {
      for (var invitation in invitations) {
        {
          list.add(GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: invitation.invitedUser.photoName.isEmpty
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
                                  TaskFilesController.getFilePath(invitation.invitedUser.photoName),
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
                              invitation.invitedUser.name,
                              style: TextStyle(
                                fontSize: ControlOptions.instance.sizeL,
                              ),
                            ),
                            Text(
                              invitation.invitedUser.phoneNumber,
                              style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invited User',
                              style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: 'Cancel Invitation',
                        child: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () async {
                            Get.find<AccpetController>().currentItem = invitation;
                            await Get.find<AccpetController>().deleteItems([Get.find<AccpetController>().currentItem]);
                            Get.find<AccpetController>().refreshData();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        }
      }
    }

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: list,
      ),
    ));
  }

  Widget projectUsersList(BuildContext context) {
    List<Widget> list = [];
    double height = MediaQuery.of(context).size.height;
    //var projectUsertable = Get.find<ProjectItemUserTableController>().items;

    for (var projectuser in controller.currentItem.tableUsers.rows) {
      if (projectuser.userAccount.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.email.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.phoneNumber.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        list.add(Padding(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: InkWell(
            onTap: () {
              Get.find<ProjectItemUserTableController>().currentItem = projectuser;
              //   Get.toNamed(Routes.projectUserViewPage);
              showdialogBuilder(context, height, projectuser);
            },
            onLongPress: () {},
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipOval(
                        child: projectuser.userAccount.photoName.isEmpty
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
                                TaskFilesController.getFilePath(projectuser.userAccount.photoName),
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
                          Directionality(
                              textDirection: TextDirection.ltr,
                              child: SubstringHighlight(
                                text: projectuser.userAccount.name,
                                term: searchvalue,
                                textStyle: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold, color: Colors.black),
                                textStyleHighlight: const TextStyle(color: Colors.deepOrange),
                              )),
                          Directionality(
                              textDirection: TextDirection.ltr,
                              child: SubstringHighlight(
                                text: projectuser.userAccount.phoneNumber,
                                term: searchvalue,
                                textStyle: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                                textStyleHighlight: const TextStyle(color: Colors.deepOrange),
                              )),
                        ],
                      ),
                    ),
                    if (projectuser.isAdmin) const Icon(Icons.admin_panel_settings),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            projectuser.userAccount.organization.name,
                            style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                          ),
                          // Text(
                          //   projectuser.userAccount.email,
                          //   style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                          // ),
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
                    // const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ],
            ),
          ),
        ));
      }
    }

    return SingleChildScrollView(child: Column(children: list));
  }

  Future<void> showdialogBuilder(BuildContext context, height, ProjectItemUserTable projectuser) {
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
              title: projectuser.userAccount.toString(),
              rightIcons: [
                TTAppBarIcon(
                  icon: Icons.check,
                  onTap: () async {
                    await Get.find<ProjectItemUserTableController>().itemPagePost(goBack: false);
                    await Get.find<ProjectController>().itemPagePost(goBack: false);
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
            SizedBox(height: height - 100, child: const ProjectUserViewPage()),
          ]),
        );
      },
    );
  }

  showAlertDialog(BuildContext context, user) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        Get.find<ProjectItemUserTableController>().currentItem = user;
        controller.currentItem.tableUsers.removeRow(Get.find<ProjectItemUserTableController>().currentItem);
        controller.itemPagePost();

        Navigator.of(context).pop();
      },
    );
    Widget noButton = ElevatedButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to Delete?"),
      actions: [okButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
