import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectEditPage extends StatefulWidget {
  const ProjectEditPage({Key? key}) : super(key: key);
  @override
  State<ProjectEditPage> createState() => _ProjectEditpageState();
}

class _ProjectEditpageState extends State<ProjectEditPage> {
  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  late NsgFilePicker picker;
  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    // scaffoldKey;
    isHidden;
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

            controller.currentItem.photoFile = imagefile;

            controller.sendNotify();
          }

          Navigator.of(Get.context!).pop();
        },
        objectsList: []);
  }

  @override
  Widget build(BuildContext context) {
    //double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    // var todaydate = controller.currentItem.date;

    //DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    var isNewProject = controller.currentItem.name.isEmpty;
    var scrollController = ScrollController();
    //var newscrollController = ScrollController();

    // String formatted = formateddate.format(controller.currentItem.date);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //   key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  color: Colors.black,
                  backColor: Colors.white,
                  text: isNewProject ? 'Новый проект'.toUpperCase() : controller.currentItem.name.toUpperCase(),
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () {
                    if (controller.currentItem.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите название проекта ')));
                    } else {
                      controller.itemPagePost();
                    }
                  },
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.dialog(picker, barrierDismissible: true);
                      },
                      child: controller.currentItem.photoFile.isEmpty
                          ? ClipOval(
                              child: Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(color: ControlOptions.instance.colorGreyLighter),
                              child: Center(
                                  child: Icon(
                                Icons.add_a_photo,
                                color: ControlOptions.instance.colorMainLight,
                                size: 25,
                              )),
                            ))
                          : Image.memory(
                              Uint8List.fromList(controller.currentItem.photoFile),
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                    ),
                  ),
                ),
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
                              TTNsgInput(
                                infoString: 'Выберите проектов (организация)',
                                selectionController: Get.find<OrganizationController>(),
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameOrganizationId,
                                label: 'Группа проектов (организация)',
                              ),
                              TTNsgInput(
                                infoString: 'Выберите руководителя проекта ',
                                selectionController: Get.find<UserAccountController>(),
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameLeaderId,
                                label: 'Руководитель проекта',
                              ),
                              // TTNsgInput(
                              //   dataItem: controller.currentItem,
                              //   fieldName: ProjectItemGenerated.nameProjectPrefix,
                              //   label: 'Project Prefix',
                              // ),
                              TTNsgInput(
                                infoString: 'Укажите название проекта',
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameName,
                                label: 'Название проекта',
                              ),
                              TTNsgInput(
                                infoString: 'Укажите заказчика проекта',
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameContractor,
                                label: 'Заказчик',
                              ),
                              if (controller.currentItem.name.isNotEmpty)
                                NsgButton(
                                  backColor: Colors.transparent,
                                  text: 'Удалить проект',
                                  color: Colors.red,
                                  onPressed: () async {
                                    showAlertDialog(context);
                                  },
                                )
                            ],
                          ),
                        ),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                        child: TaskButton(
                      text: 'Отменить',
                      style: TaskButtonStyle.light,
                      onTap: () {
                        Get.back();
                      },
                    )),
                    Expanded(
                        child: TaskButton(
                      text: 'Сохранить',
                      onTap: () async {
                        await controller.itemPagePost();
                      },
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () async {
        await controller.deleteItems([controller.currentItem]);
        Get.toNamed(Routes.projectListPage);
        controller.refreshData();
        // Navigator.of(context).pop();
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
