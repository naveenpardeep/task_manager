import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_user_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';

import '../user_account/user_account_controller.dart';

class ProjectUserRowPage extends StatefulWidget {
  const ProjectUserRowPage({Key? key}) : super(key: key);
  @override
  State<ProjectUserRowPage> createState() => _ProjectUserRowPageState();
}

class _ProjectUserRowPageState extends State<ProjectUserRowPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  var textEditController = TextEditingController();

  String searchvalue = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<ProjectUserController>().lateInit) {
      Get.find<ProjectUserController>().requestItems();
    }
    if (Get.find<ProjectController>().lateInit) {
      Get.find<ProjectController>().requestItems();
    }
    double width = MediaQuery.of(context).size.width;
    //  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
      child: Scaffold(
        //  key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //  key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  color: Colors.black,
                  backColor: Colors.white,
                  text: 'Добавить участников в проект',
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  // icon2: Icons.check,
                  // onPressed2: () async {
                  //   Get.find<ProjectItemUserTableController>().usersSaved();
                  //   Get.find<ProjectController>().sendNotify();
                  // },
                  icon2: Icons.close,
                  onPressed2: () {
                    controller.itemPageCancel();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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

                            // NsgInput(
                            //   controller: controller,
                            //   selectionController:
                            //       Get.find<ProjectUserController>(),
                            //   dataItem: controller.currentItem,
                            //   fieldName: ProjectItemUserTableGenerated
                            //       .nameUserAccountId,
                            //   label: 'User ',
                            // ),
                            // NsgInput(
                            //   dataItem: controller.currentItem,
                            //   fieldName:
                            //       ProjectItemUserTableGenerated.nameIsAdmin,
                            //   label: 'Admin',
                            // ),
                            getProjectShowUser(context),
                            const Divider(
                              height: 2,
                            ),
                         
                            getProjectuser(context),
                          ],
                        ),
                      )),
                ),
                NsgButton(
                  borderRadius: 30,
                  color: const Color(0xff0859ff),
                  backColor: const Color(0xffABF4FF),
                  text: 'Пригласить по почте или телефону',
                  onPressed: () async {
                    Get.find<UserAccountController>().newItemPageOpen(pageName: Routes.createInvitationUser);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getProjectuser(BuildContext context) {
    List<Widget> list = [];
    List<Widget> adduser = [];
    var projectuseritem = Get.find<ProjectItemUserTableController>().projectUsersList;
    for (var projectuser in projectuseritem) {
      if (projectuser.userAccount.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.email.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.phoneNumber.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        list.add(Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Row(
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
              if (projectuser.isChecked == false)
                Container(
                  constraints: BoxConstraints.tight(const Size(50, 42)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff0859ff),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      alignment: Alignment.center,
                      onPressed: () {
                        projectuser.isChecked = true;

                        Get.find<ProjectItemUserTableController>().usersSaved();
                        projectuseritem.remove(projectuser);
                        Get.find<ProjectController>().sendNotify();
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ),
                ),

              // SizedBox(
              //     width: 30,
              //     child: NsgCheckBox(
              //         toggleInside: true,
              //         key: GlobalKey(),
              //         label: '',
              //         value: projectuser.isChecked,
              //         onPressed: (currentValue) {
              //           projectuser.isChecked = currentValue;
              //         })),
            ],
          ),
        ));
      }
    }
    for (var projectuser in controller.currentItem.tableUsers.rows) {
      if (projectuser.userAccount.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.email.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.phoneNumber.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        adduser.add(Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: Row(
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
                    Text(
                      projectuser.userAccount.name,
                      style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      projectuser.userAccount.phoneNumber,
                      style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: const Color(0xff529FBF)),
                    ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints.tight(const Size(50, 42)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffEDEFF3),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    alignment: Alignment.center,
                    onPressed: () {},
                    icon: const Icon(Icons.check),
                    color: const Color(0xff529FBF),
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    }
    return SingleChildScrollView(child: Column(children: list + adduser));
  }

  Widget getProjectShowUser(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> list = [];
    //  var projectuseritem = Get.find<ProjectItemUserTableController>().projectUsersShowList;
    for (var projectuser in controller.currentItem.tableUsers.rows) {
      if (projectuser.userAccount.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.email.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          projectuser.userAccount.phoneNumber.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        list.add(Stack(
          children: [
           
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
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
                                  color: ControlOptions.instance.colorPrimary.withOpacity(0.4),
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
                    Text(
                      projectuser.userAccount.name,
                      style: TextStyle(fontSize: ControlOptions.instance.sizeXS),
                    ),
                  ],
                ),
              ),
            ),
             Positioned(
              right: 10,
              child: ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                    decoration: const BoxDecoration(color: Color(0xffEDEFF3), shape: BoxShape.circle),
                    child: IconButton(
                      alignment: AlignmentDirectional.topCenter,
                        onPressed: () async {
                          controller.currentItem.tableUsers.removeRow(projectuser);
              
                          await controller.itemPagePost(goBack: false);
                          Get.find<ProjectItemUserTableController>().projectUsersList.add(projectuser);
                          controller.sendNotify();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Color(0xff529FBF),
                        ))),
              ),
            ),
          ],
        ));
      }
    }
    return Container(color: Colors.white, width: width, child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: list)));
  }
}
