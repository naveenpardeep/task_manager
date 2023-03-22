import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/user_account/user_image_controller.dart';
import 'package:task_manager_app/forms/user_account/user_notification_controller.dart';
import 'package:task_manager_app/forms/widgets/nsg_carousel.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';
import '../widgets/tt_text.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var organizationName = '';
  var userAccountController = Get.find<UserAccountController>();
  var orgController = Get.find<OrganizationController>();
  var userImageController = Get.find<UserImageController>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final scrollController = ScrollController();
  double? width;
  late NsgFilePicker picker;
  var currentTabIndex = 0;
  List<ProfileCard> profilesList = [];

  @override
  void initState() {
    super.initState();
    picker = NsgFilePicker(
        showAsWidget: true,
        skipInterface: true,
        oneFile: true,
        callback: (value) async {
          if (value.isNotEmpty) {
            List<int> imagefile;
            if (kIsWeb) {
              imagefile = await File.fromUri(Uri(path: value[0].filePath)).readAsBytes();
            } else {
              imagefile = await File(value[0].filePath).readAsBytes();
            }
            // File imageFile = File(value[0].filePath);
            //  List<int> imagebytes = await imageFile.readAsBytes();
            Get.find<DataController>().currentUser.photoFile = imagefile;
            await userAccountController.postItems([Get.find<DataController>().currentUser]);
            await userAccountController.refreshData();
          }
          //userAccountController.sendNotify();
          Navigator.of(Get.context!).pop();
        },
        // ignore: prefer_const_literals_to_create_immutables
        objectsList: []);
    organizationName = userAccountController.currentItem.organization.toString();
    if (userAccountController.lateInit) {
      userAccountController.requestItems();
    }
    if (userImageController.lateInit) {
      userImageController.requestItems();
    }
    if (Get.find<UserNotificationController>().lateInit) {
      Get.find<UserNotificationController>().requestItems();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return userAccountController.obx((state) {
      profilesList = getProfilesCards();
      userAccountController.currentItem = profilesList[currentTabIndex].profile;
      return BodyWrap(
        child: SafeArea(
          child: Scaffold(
              key: scaffoldKey,
              body: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        NsgCarousel(
                          maxSliderItems: 7,
                          widgetList: profilesList,
                          height: 300,
                          onChange: (current) {
                            currentTabIndex = current;
                            userAccountController.currentItem = profilesList[current].profile;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        TaskTextButton(
                          text: 'Выйти из аккаунта',
                          onTap: () {},
                        )
                      ],
                    ),
                  )),
                ],
              )),
        ),
      );
    });
  }

  List<ProfileCard> getProfilesCards() {
    List<ProfileCard> list = [];

    list.add(ProfileCard(profile: Get.find<DataController>().currentUser));
    for (var profile in userAccountController.items) {
      if (Get.find<DataController>().currentUser == profile.mainUserAccount) {
        list.add(ProfileCard(profile: profile));
      }
    }

    return list;
  }

  selectOrganization() {
    var form = NsgSelection(
      inputType: NsgInputType.reference,
      controller: Get.find<OrganizationController>(),
    );
    form.selectFromArray(
      'Организация',
      (item) {
        setState(() {
          organizationName = userAccountController.currentItem.organization.toString();
        });
      },
    );
  }

  Widget projectList() {
    var controller = Get.find<UserNotificationController>();
    List<Widget> list = [];
    for (var project in controller.items) {
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
          onTap: () {
            controller.currentItem = project;
            Get.toNamed(Routes.userNotificationNewTaskPage);
          },
          onLongPress: () {
            // controller.itemPageOpen(project, Routes.projectPage);
          },
          child: Row(
            children: [
              Expanded(
                child: Card(
                  // elevation: 3,
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              // controller.currentItem = project;
                              // await controller
                              //     .deleteItems([controller.currentItem]);
                              // controller.sendNotify();
                              showAlertDialog(context, project);
                            },
                            icon: const Icon(Icons.delete)),
                        Expanded(
                          child: Text(
                            project.project.name,
                            style: TextStyle(
                              color: ControlOptions.instance.colorMainDark,
                              fontSize: ControlOptions.instance.sizeL,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
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

  showAlertDialog(BuildContext context, UserNotificationSettings project) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        Get.find<UserNotificationController>().currentItem = project;
        Get.find<UserNotificationController>().deleteItems([Get.find<UserNotificationController>().currentItem]).then((value) {
          Get.find<UserNotificationController>().sendNotify();
          Navigator.of(context).pop();
        });
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

  Widget organizationList() {
    var list = <Widget>[];
    for (var org in orgController.items) {
      list.add(TextButton(
          onPressed: (() {
            Get.find<DataController>().currentUser = Get.find<UserAccountController>().getUserByOrganization(org);
            setState(() {});
          }),
          child: Text(org.name)));
    }
    return Row(
      children: list,
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.profile});

  final UserAccount profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        //boxShadow: [
        //BoxShadow(offset: const Offset(0, 5), blurRadius: 5, color: ControlOptions.instance.colorText.withOpacity(.3)),
        //BoxShadow(offset: const Offset(0, -5), blurRadius: 5, color: ControlOptions.instance.colorText.withOpacity(.3))
        //],
      ),
      child: IntrinsicWidth(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: profile.photoFile.isEmpty
                      ? Container(
                          decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 32,
                            color: ControlOptions.instance.colorMain.withOpacity(0.4),
                          ),
                        )
                      : Image.memory(
                          Uint8List.fromList(Get.find<DataController>().currentUser.photoFile),
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${profile.lastName} ${profile.firstName}',
                        style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontFamily: 'Inter'),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Код профиля',
                            style: TextStyle(color: ControlOptions.instance.colorMainLight, fontFamily: 'Inter', fontSize: ControlOptions.instance.sizeM),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  'GN2934NIUN98798',
                                  style: TextStyle(fontFamily: 'Inter', fontSize: ControlOptions.instance.sizeM),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.copy,
                                      color: ControlOptions.instance.colorMainLight,
                                      size: 15,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          TTInfoList(
            rows: [
              TTInfoRow(title: 'Должность', value: profile.position),
              TTInfoRow(title: 'Дата рождения', value: '${NsgDateFormat.dateFormat(profile.birthDate, format: 'dd.MM.yyyy')}'),
              TTInfoRow(title: 'Телефон', value: profile.phoneNumber),
              TTInfoRow(title: 'Почта', value: profile.email),
              TTInfoRow(title: 'Компания', value: profile.organization.name),
              //TTInfoRow(title: 'Проект', value: profile.),
            ],
          ),
        ],
      )),
    );
  }
}
