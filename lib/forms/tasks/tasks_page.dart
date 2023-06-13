import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_tasks_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task%20type/task_type_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/new_task_status_controller.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/image_file_view/multi_image_picker_controller.dart';
import 'package:task_manager_app/image_file_view/tt_nsg_file_picker.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../1/nsg_rich_text.dart';
import '../widgets/tt_nsg_input.dart';
import 'task_file_controller.dart';
import 'task_user_account_controler.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  var nsgMultiImagePickerController = NsgMultiImagePickerController();
  var notificationController = Get.find<NotificationController>();
  var controller = Get.find<TasksController>().isPeriodicController ? Get.find<PeriodicTasksController>() : Get.find<TasksController>();
  var imageCont = Get.find<TaskFilesController>();
  var fileController = Get.find<TaskFilesController>();
  var statuscon = Get.find<NewTaskStatusController>();
  late bool isCheckeddateRemind;
  late bool isCheckedDeadline;

  bool isHidden = true;
  @override
  void initState() {
    super.initState();
    if (statuscon.lateInit) {
      statuscon.requestItems();
    }
    if (controller.currentItem.dateRemind.toString() == '1754-01-01 00:00:00.000' ||
        controller.currentItem.dateRemind.toString() == '0001-01-01 00:00:00.000') {
      isCheckeddateRemind = false;
    } else {
      isCheckeddateRemind = true;
    }
    if (controller.currentItem.dateDeadline.toString() == '1754-01-01 00:00:00.000' ||
        controller.currentItem.dateDeadline.toString() == '0001-01-01 00:00:00.000') {
      isCheckedDeadline = false;
    } else {
      isCheckedDeadline = true;
    }
    isCheckedDeadline;
    if (notificationController.lateInit) {
      notificationController.requestItems();
    }
    if (imageCont.lateInit) {
      imageCont.requestItems();
    }
    if (fileController.lateInit) {
      fileController.requestItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    // var todaydate = controller.currentItem.date;
    // var updatedate = controller.currentItem.dateUpdated;

    final scrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;
    // String formatted = NsgDateFormat.dateFormat(todaydate, format: 'dd.MM.yy HH:mm');
    // String formatupdate = NsgDateFormat.dateFormat(updatedate, format: 'dd.MM.yy HH:mm');
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BodyWrap(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            //  key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (controller.currentItem.name.isNotEmpty)
                                    Center(
                                      child: Text(
                                        'Автор  :  ${controller.currentItem.author}',
                                        style: TextStyle(color: ControlOptions.instance.colorMain),
                                      ),
                                    ),
                                  TTNsgInput(
                                    dataItem: controller.currentItem,
                                    fieldName: TaskDocGenerated.nameName,
                                    label: 'Название задачи',
                                    infoString: 'Укажите название задачи',
                                  ),
                                  TTNsgInput(
                                    selectionController: Get.find<TaskTypeController>(),
                                    dataItem: controller.currentItem,
                                    fieldName: TaskDocGenerated.nameTaskTypeId,
                                    label: 'Тип задачи',
                                    infoString: 'Выберите тип задачи',
                                  ),
                                  // TTNsgInput(
                                  //   controller: controller,
                                  //   selectionController: Get.find<NewTaskStatusController>(),
                                  //   dataItem: controller.currentItem,
                                  //   fieldName: TaskDocGenerated.nameTaskStatusId,
                                  //   label: 'Статус',
                                  //   infoString: 'Укажите статус задачи',
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                                          child: Text('Статус', style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: Colors.black)),
                                        ),
                                        TextFormField(
                                          initialValue: controller.currentItem.taskStatus.toString(),
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.fromLTRB(10, 14, 25, 14),
                                            isDense: true,
                                            border: OutlineInputBorder(
                                                gapPadding: 1,
                                                borderSide: BorderSide(color: ControlOptions.instance.colorMain),
                                                borderRadius: const BorderRadius.all(Radius.circular(10))),
                                          ),
                                          style: TextStyle(color: ControlOptions.instance.colorText, fontSize: 14),
                                          onTap: () {
                                            taskStatus(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (width > 700)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TTNsgInput(
                                            controller: controller,
                                            label: 'Исполнитель',
                                            infoString: 'Выберите исполнителя задачи',
                                            selectionController: Get.find<TaskUserAccountController>(),
                                            dataItem: controller.currentItem,
                                            fieldName: TaskDocGenerated.nameAssigneeId,
                                            //selectionForm: Routes.userAccountListPage,
                                          ),
                                        ),
                                        Expanded(
                                          child: TTNsgInput(
                                            dataItem: controller.currentItem,
                                            fieldName: TaskDocGenerated.namePriority,
                                            label: 'Приоритет',
                                            infoString: 'Выберите приоритет задачи',
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (width < 700)
                                    TTNsgInput(
                                      controller: controller,
                                      label: 'Исполнитель',
                                      infoString: 'Выберите исполнителя задачи',
                                      selectionController: Get.find<TaskUserAccountController>(),
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.nameAssigneeId,
                                      //selectionForm: Routes.userAccountListPage,
                                    ),
                                  if (width < 700)
                                    TTNsgInput(
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.namePriority,
                                      label: 'Приоритет',
                                      infoString: 'Выберите приоритет задачи',
                                    ),
                                  Center(
                                    child: NsgButton(
                                      borderRadius: 20,
                                      width: width,

                                      backColor: const Color.fromARGB(255, 173, 233, 230),
                                      color: Colors.black,
                                      text: 'Assign me',
                                      onPressed: () {
                                        controller.currentItem.assignee = Get.find<DataController>().currentUser;
                                        controller.sendNotify();
                                      },
                                      //selectionForm: Routes.userAccountListPage,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(5, 4, 0, 4),
                                    child: Text(
                                      'Описание задачи',
                                      style: TextStyle(fontFamily: 'Inter', fontSize: 12),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                      ),
                                      child: NsgRichText(
                                          hint: 'Description',
                                          key: GlobalKey(),
                                          dataItem: controller.currentItem,
                                          fieldName: TaskDocGenerated.nameDescription,
                                          fileController: Get.find<TaskFilesController>()),
                                    ),
                                  ),
                                  TTNsgInput(
                                    dataItem: controller.currentItem,
                                    fieldName: TaskDocGenerated.nameFootnote,
                                    label: 'Примечание',
                                    minLines: 1,
                                    maxLines: 5,
                                  ),
                                  NsgCheckBox(
                                      toggleInside: true,
                                      key: GlobalKey(),
                                      label: 'установить напоминание ',
                                      value: isCheckeddateRemind,
                                      onPressed: (currentValue) {
                                        setState(() {
                                          isCheckeddateRemind = currentValue;
                                        });
                                      }),
                                  if (isCheckeddateRemind == true)
                                    TTNsgInput(
                                      controller: controller,
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.nameDateRemind,
                                      label: 'Напонинание о задаче',
                                    ),
                                  NsgCheckBox(
                                      toggleInside: true,
                                      key: GlobalKey(),
                                      label: 'задать дедлайн',
                                      value: isCheckedDeadline,
                                      onPressed: (currentValue) {
                                        setState(() {
                                          isCheckedDeadline = currentValue;
                                        });
                                      }),

                                  if (isCheckedDeadline == true)
                                    TTNsgInput(
                                      controller: controller,
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.nameDateDeadline,
                                      label: 'Срок выполнения',
                                    ),
                                  NsgCheckBox(
                                      toggleInside: true,
                                      key: GlobalKey(),
                                      label: 'Periodic Task',
                                      value: controller.currentItem.isPeriodic,
                                      onPressed: (currentValue) {
                                        setState(() {
                                          controller.currentItem.isPeriodic = currentValue;
                                        });
                                      }),
                                  if (controller.currentItem.isPeriodic)
                                    TTNsgInput(
                                      controller: controller,
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.namePeriodicNumberOfIterations,
                                      label: 'Number Of Iterations',
                                    ),
                                  if (controller.currentItem.isPeriodic)
                                    TTNsgInput(
                                      controller: controller,
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.namePeriodicActualUntil,
                                      label: 'PeriodicActualUntil',
                                    ),
                                  if (controller.currentItem.isPeriodic)
                                    TTNsgInput(
                                      controller: controller,
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.namePeriodicLastClosed,
                                      label: 'Periodic Last Closed',
                                      infoString: 'Выберите дату',
                                    ),
                                  if (controller.currentItem.isPeriodic)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TTNsgInput(
                                            controller: controller,
                                            dataItem: controller.currentItem,
                                            fieldName: TaskDocGenerated.namePeriodicInterval,
                                            label: 'Periodic Interval',
                                          ),
                                        ),
                                        Expanded(
                                          child: TTNsgInput(
                                            controller: controller,
                                            dataItem: controller.currentItem,
                                            fieldName: TaskDocGenerated.namePeriodicIntervalUnit,
                                            label: 'Periodic Interval Unit',
                                          ),
                                        ),
                                      ],
                                    ),

                                  if (controller.currentItem.isPeriodic)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TTNsgInput(
                                            controller: controller,
                                            dataItem: controller.currentItem,
                                            fieldName: TaskDocGenerated.namePeriodicTimeLimit,
                                            label: 'Periodic Time Limit',
                                          ),
                                        ),
                                        Expanded(
                                          child: TTNsgInput(
                                            controller: controller,
                                            dataItem: controller.currentItem,
                                            fieldName: TaskDocGenerated.namePeriodicTimeLimitlUnit,
                                            label: 'Periodic Time Limit Unit',
                                          ),
                                        ),
                                      ],
                                    ),
                                  Flexible(child: imageGallery()),
                                  if (controller.currentItem.name.isNotEmpty)
                                    NsgButton(
                                      backColor: Colors.transparent,
                                      text: 'Удалить задачу',
                                      color: Colors.red,
                                      onPressed: () async {
                                        showAlertDialog(context);
                                      },
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
                                          if (controller.currentItem.taskStatus.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                                          } else if (controller.currentItem.name.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите название задачи')));
                                          } else {
                                            controller.currentItem.dateUpdated = DateTime.now();
                                            if (controller.currentItem.assignee.isEmpty) {
                                              controller.currentItem.assignee = Get.find<ProjectController>().currentItem.defaultUser;
                                            }

                                            await controller.itemPagePost(goBack: false);
                                            Get.find<TasksController>().refreshData();
                                            Get.toNamed(Routes.homePage);
                                          }
                                        },
                                      )),
                                    ],
                                  )
                                ],
                              )),
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

  taskStatus(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Center(child: Text('Select Status')),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (controller.currentItem.state == NsgDataItemState.fill || controller.currentItem.state == NsgDataItemState.create)
                statuslist(context, controller.currentItem.state == NsgDataItemState.create)
            ],
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget statuslist(context, bool isNewStatus) {
    List<Widget> list = [];
    double width = MediaQuery.of(context).size.width;
    var taskboardstaus = Get.find<TaskBoardController>().currentItem;

    var stsList =
        isNewStatus ? Get.find<NewTaskStatusController>().items.where((element) => element.isDone == false) : Get.find<NewTaskStatusController>().items;

    for (var status in stsList) {
      list.add(Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: InkWell(
              onTap: () {
                controller.currentItem.taskStatus = status;
                controller.sendNotify();
                Navigator.of(context).pop();
                setState(() {});
              },
              onLongPress: () {},
              child: Column(children: [
                Container(
                  width: width > 700 ? width / 2 : width,
                  color: controller.currentItem.taskStatus == status ? const Color.fromARGB(255, 208, 243, 209) : Colors.white,
                  child: Center(
                    child: Text(
                      status.name,
                      style: TextStyle(
                          fontSize: ControlOptions.instance.sizeL,
                          color: taskboardstaus.statusTable.rows.where((element) => element.status.name == status.name).isNotEmpty ? Colors.black : Colors.red),
                    ),
                  ),
                ),
              ]))));
    }
    return SingleChildScrollView(child: Column(children: list));
  }

  Widget imageGallery() {
    // return Get.find<TaskImageController>().obx((state) =>
    return Get.find<TaskFilesController>().obx(
      (state) => TTNsgFilePicker(
        useFilePicker: true,
        showAsWidget: true,
        callback: (value) async {},
        // objectsList: Get.find<TaskImageController>().images,
        objectsList: Get.find<TaskFilesController>().files,
        //allowedFileFormats: const [],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Do you want to Delete?"),
          actions: [
            ElevatedButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(); // dismiss dialog
              },
            ),
            ElevatedButton(
              child: const Text("Yes"),
              onPressed: () async {
                await controller.deleteItems([controller.currentItem]);
                Get.back();
                controller.refreshData();
                // Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
