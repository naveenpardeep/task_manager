import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';

import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);
  @override
  State<ProjectPage> createState() => _ProjectpageState();
}

class _ProjectpageState extends State<ProjectPage> {
  //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var controller = Get.find<ProjectController>();
  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    // scaffoldKey;
    isHidden;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    // var todaydate = controller.currentItem.date;

    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    var isNewProject = controller.currentItem.name.isEmpty;
    var scrollController = ScrollController();
    var newscrollController = ScrollController();

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
                              if (!isNewProject) NsgText('Создано :${formateddate.format(controller.currentItem.date)}'),
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
                              TTNsgInput(
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameProjectPrefix,
                                label: 'Project Prefix',
                              ),
                              TTNsgInput(
                                infoString: 'Укажите название проекта',
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameName,
                                label: 'Название проекта',
                              ),
                               TTNsgInput(
                                infoString: 'Выберите Исполнитель по умолчанию ',
                                selectionController: Get.find<UserAccountController>(),
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameDefaultUserId,
                                label: 'Исполнитель по умолчанию',
                              ),
                              TTNsgInput(
                                infoString: 'Укажите заказчика проекта',
                                dataItem: controller.currentItem,
                                fieldName: ProjectItemGenerated.nameContractor,
                                label: 'Заказчик',
                              ),
                              if (isHidden == true && controller.currentItem.name.isEmpty)
                                NsgButton(
                                  text: 'Сохранить и далее',
                                  color: Colors.white,
                                  onPressed: () {
                                    if (controller.currentItem.name.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите название проекта ')));
                                    } else {
                                      setState(() {
                                        isHidden = false;
                                        controller.itemPagePost(goBack: false);
                                      });
                                    }
                                  },
                                ),
if (!isNewProject) const Align(alignment: Alignment.centerLeft, child: NsgText('Добавление Статусы проекта')),
                              if (!isNewProject)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: SizedBox(
                                    height: height * 0.6,
                                    child: RawScrollbar(
                                      thumbVisibility: true,
                                      trackVisibility: true,
                                      controller: newscrollController,
                                      thickness: 8,
                                      trackBorderColor: ControlOptions.instance.colorGreyLight,
                                      trackColor: ControlOptions.instance.colorGreyLight,
                                      thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                                      radius: const Radius.circular(0),
                                      child: SingleChildScrollView(
                                          physics: const BouncingScrollPhysics(),
                                          controller: newscrollController,
                                          child: NsgTable(
                                            showIconFalse: false,
                                            controller: Get.find<ProjectStatusController>(),
                                            elementEditPageName: Routes.taskStatusPage,
                                            availableButtons: const [
                                              NsgTableMenuButtonType.createNewElement,
                                              NsgTableMenuButtonType.editElement,
                                              NsgTableMenuButtonType.removeElement
                                            ],
                                            columns: [
                                              NsgTableColumn(name: TaskStatusGenerated.nameName, expanded: true, presentation: 'Статусы'),
                                              NsgTableColumn(name: TaskStatusGenerated.nameIsDone, width: 100, presentation: 'Финальный'),
                                            ],
                                          )),
                                    ),
                                  ),
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
        Get.back();
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
