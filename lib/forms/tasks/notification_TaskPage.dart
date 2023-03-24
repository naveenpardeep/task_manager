// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../1/nsg_rich_text.dart';
import '../task_status/task_status_controller.dart';
import '../widgets/tt_nsg_input.dart';
import 'task_file_controller.dart';
import 'task_user_account_controler.dart';

class NotificationTasksPage extends StatefulWidget {
  const NotificationTasksPage({Key? key}) : super(key: key);
  @override
  State<NotificationTasksPage> createState() => _NotificationTasksPageState();
}

class _NotificationTasksPageState extends State<NotificationTasksPage> {
  var notificationController = Get.find<NotificationController>();
  var controller = Get.find<TasksController>();
  var imageCont = Get.find<TaskFilesController>();
  var fileController = Get.find<TaskFilesController>();
  late bool isCheckeddateRemind;
  late bool isCheckedDeadline;

  bool isHidden = true;
  @override
  void initState() {
    super.initState();
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
    if (controller.lateInit) {
      controller.requestItems();
    }
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
            key: GlobalKey(),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NsgAppBar(
                  backColor: Colors.white,
                  color: Colors.black,
                  text: controller.currentItem.isEmpty ? 'Новая задача'.toUpperCase() : controller.currentItem.name.toString().toUpperCase(),
                  icon: Icons.arrow_back_ios_new,

                  colorsInverted: true,
                  // bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () async {
                    if (controller.currentItem.taskStatus.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                    } else if (controller.currentItem.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
                    } else {
                      controller.currentItem.dateUpdated = DateTime.now();
                      await controller.itemPagePost();
                      Get.find<TasksController>().refreshData();
                      Get.toNamed(Routes.homePage);
                    }
                  },
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
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
                          child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // NsgInput(
                                  //       dataItem: controller.currentItem,
                                  //       fieldName: TaskDocGenerated.nameDate,
                                  //       //disabled: true,
                                  //       label: 'Создана',
                                  //     ),
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     Flexible(
                                  //       child: NsgInput(
                                  //         dataItem: controller.currentItem,
                                  //         fieldName: TaskDocGenerated.nameDate,
                                  //         disabled: true,
                                  //         label: 'Создана',
                                  //       ),
                                  //     ),
                                  //     Flexible(
                                  //       child: NsgInput(
                                  //         dataItem: controller.currentItem,
                                  //         fieldName: TaskDocGenerated.nameDateUpdated,
                                  //         disabled: true,
                                  //         label: 'Обновлена',
                                  //       ),
                                  //     ),
                                  //     Flexible(
                                  //       child: NsgInput(
                                  //         dataItem: controller.currentItem,
                                  //         fieldName: TaskDocGenerated.nameDateClosed,
                                  //         disabled: true,
                                  //         label: 'Закрыта',
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // if (width > 700)
                                  //   Row(
                                  //     children: [
                                  //       Expanded(
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.only(left: 4, right: 15),
                                  //           child: Text(
                                  //             'Создана $formatted',
                                  //             style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       if (controller.currentItem.name.isNotEmpty)
                                  //         Expanded(
                                  //           child: Padding(
                                  //             padding: const EdgeInsets.all(4.0),
                                  //             child: Text(
                                  //               'Обновлена $formatupdate',
                                  //               style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       if (controller.currentItem.name.isNotEmpty)
                                  //         Expanded(
                                  //           child: Center(
                                  //             child: Text(
                                  //               'Автор  :  ${controller.currentItem.author}',
                                  //               style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       Expanded(
                                  //         child: SelectableText(
                                  //           'Номер задачи  : ${controller.currentItem.taskNumber}',
                                  //           style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),

                                  // if (width < 700)
                                  //   Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Padding(
                                  //         padding: const EdgeInsets.only(left: 4, right: 15),
                                  //         child: Text(
                                  //           'Создана $formatted',
                                  //           style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //         ),
                                  //       ),
                                  //       if (controller.currentItem.name.isNotEmpty)
                                  //         Padding(
                                  //           padding: const EdgeInsets.all(4.0),
                                  //           child: Text(
                                  //             'Обновлена $formatupdate',
                                  //             style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //           ),
                                  //         ),
                                  //       if (controller.currentItem.name.isNotEmpty)
                                  //         Padding(
                                  //           padding: const EdgeInsets.all(4.0),
                                  //           child: Text(
                                  //             'Автор  :  ${controller.currentItem.author}',
                                  //             style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //           ),
                                  //         ),
                                  //       Padding(
                                  //         padding: const EdgeInsets.all(4.0),
                                  //         child: SelectableText(
                                  //           'Номер задачи  : ${controller.currentItem.taskNumber}',
                                  //           style: TextStyle(color: ControlOptions.instance.colorMain),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),

                                  TTNsgInput(
                                    dataItem: controller.currentItem,
                                    fieldName: TaskDocGenerated.nameName,
                                    label: 'Название задачи',
                                    infoString: 'Укажите название задачи',
                                  ),
                                  if (width > 700)
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TTNsgInput(
                                            controller: controller,
                                            selectionController: Get.find<TaskStatusController>(),
                                            dataItem: controller.currentItem,
                                            fieldName: TaskDocGenerated.nameTaskStatusId,
                                            label: 'Статус',
                                            infoString: 'Укажите статус задачи',
                                          ),
                                        ),
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
                                      selectionController: Get.find<TaskStatusController>(),
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.nameTaskStatusId,
                                      label: 'Статус',
                                      infoString: 'Укажите статус задачи',
                                    ),
                                  // NsgInput(
                                  //   selectionController:
                                  //       Get.find<UserAccountController>(),
                                  //   dataItem: controller.currentItem,
                                  //   fieldName: TaskDocGenerated.nameAssigneeId,
                                  //   label: 'Исполнитель',
                                  // ),
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

                                  // HtmlEditor(
                                  //   key: GlobalKey(),
                                  //   callbacks: Callbacks(
                                  //       onChangeContent: (String? comment) {
                                  //     controller.currentItem.description = comment!;
                                  //     // controller.postItems([controller.currentItem]);
                                  //   }),
                                  //   controller: htmlcontroller, //required
                                  //   htmlEditorOptions: HtmlEditorOptions(
                                  //       hint: "Описание задачи...",
                                  //       initialText:
                                  //           controller.currentItem.description),
                                  //   otherOptions: const OtherOptions(
                                  //     height: 400,
                                  //   ),
                                  // ),

                                  // MarkdownTextInput(
                                  //   (String value) =>
                                  //       controller.currentItem.description = value,
                                  //   controller.currentItem.description,
                                  //   label: 'Description',
                                  //   maxLines: 10,
                                  //   actions: const [
                                  //     MarkdownType.bold,
                                  //     MarkdownType.italic,
                                  //     MarkdownType.title,
                                  //     MarkdownType.link,
                                  //     MarkdownType.list
                                  //   ],
                                  //   controller: textontroller,
                                  //   textStyle: TextStyle(fontSize: 16),
                                  // ),
                                  // TextButton(
                                  //   onPressed: () {
                                  //     textontroller.clear();
                                  //   },
                                  //   child: Text('Clear'),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 10),
                                  //   child: MarkdownBody(
                                  //     data: controller.currentItem.description,
                                  //     shrinkWrap: true,
                                  //     selectable: true,
                                  //   ),
                                  // ),

                                  // NsgInput(
                                  //   dataItem: controller.currentItem,
                                  //   fieldName: TaskDocGenerated.nameDescription,
                                  //   label: 'Описание задачи',
                                  //   minLines: 1,
                                  //   maxLines: 5,
                                  // ),

                                  NsgRichText(
                                      hint: 'Description',
                                      key: GlobalKey(),
                                      dataItem: controller.currentItem,
                                      fieldName: TaskDocGenerated.nameDescription,
                                      fileController: Get.find<TaskFilesController>()),
                                  // Container(
                                  //     height: 300,
                                  //     child: Markdown(
                                  //       styleSheet: MarkdownStyleSheet(
                                  //         h1: const TextStyle(
                                  //             color: Colors.blue, fontSize: 40),
                                  //       ),
                                  //       selectable: true,
                                  //       data: controller.currentItem.description,
                                  //     )),
                                  // quil.QuillToolbar.basic(
                                  //   controller: quillcontroller,
                                  //   afterButtonPressed: () {
                                  //     controller.currentItem.description;
                                  //   },
                                  // ),

                                  // Container(
                                  //   height: 500,
                                  //   child: quil.QuillEditor.basic(
                                  //     controller: quillcontroller,
                                  //     readOnly: false, // true for view only mode
                                  //   ),
                                  //),

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

                                  // const NsgText('Create CheckList for this Task'),
                                  // NsgTable(
                                  //   controller: Get.find<TaskCheckListController>(),
                                  //   elementEditPageName: Routes.taskChecklistPage,
                                  //   availableButtons: const [
                                  //     NsgTableMenuButtonType.createNewElement,
                                  //     NsgTableMenuButtonType.editElement,
                                  //     NsgTableMenuButtonType.removeElement
                                  //   ],
                                  //   columns: [
                                  //     NsgTableColumn(
                                  //         name: TaskDocCheckListTableGenerated
                                  //             .nameText,
                                  //         expanded: true,
                                  //         presentation: 'CheckList Name'),
                                  //     NsgTableColumn(
                                  //         name: TaskDocCheckListTableGenerated
                                  //             .nameIsDone,
                                  //         width: 100,
                                  //         presentation: 'Done'),
                                  //   ],
                                  // ),
                                  // if (controller.currentItem.name.isNotEmpty)
                                  //   NsgButton(
                                  //     text: 'Open Comments',
                                  //     onPressed: () {
                                  //       // Get.find<CommentTableTasksController>()
                                  //       //     .itemPageOpen(
                                  //       //        Get.find<CommentTableTasksController>()
                                  //       //          .currentItem,
                                  //       //       Routes.commentRowPage);
                                  //       // Get.toNamed(Routes.commentRowPage);
                                  //       Get.find<CommentTableTasksController>()
                                  //           .newItemPageOpen(
                                  //               pageName: Routes.commentRowPage);
                                  //     },
                                  //   ),
                                  if (controller.currentItem.name.isEmpty)
                                    NsgButton(
                                        text: 'Add Photos',
                                        color: Colors.white,
                                        onPressed: () {
                                          if (controller.currentItem.name.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите название задачи ')));
                                          } else {
                                            controller.itemPagePost(goBack: false);
                                          }
                                        }),
                                  if (controller.currentItem.name.isNotEmpty) Flexible(child: imageGallery()),
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

                                            await controller.itemPagePost(goBack: false);
                                            Get.find<TasksController>().refreshData();
                                            Get.toNamed(Routes.homePage);
                                          }
                                        },
                                      )),
                                    ],
                                  )

                                  //   if (controller.currentItem.name.isNotEmpty) Flexible(child: filesUpload()),
                                  // NsgTable(
                                  //     controller:
                                  //         Get.find<FilesTableTasksController>(),
                                  //     columns: [
                                  //       NsgTableColumn(
                                  //           name: TaskDocFilesTableGenerated.nameFile,
                                  //           expanded: true,
                                  //           presentation: 'Files'),
                                  //     ]),
                                  // NsgInput(
                                  //   dataItem: controller.currentItem,
                                  //   fieldName: TaskDocGenerated.nameFiles,
                                  // ),
                                  // NsgInput(
                                  //     selectionController:
                                  //         Get.find<ProjectController>(),
                                  //     dataItem: controller.currentItem,
                                  //     fieldName: TaskDocGenerated.nameProjectId,
                                  //     label: 'Проект',
                                  //     //selectionForm: Routes.projectListPage
                                  //     ),
                                  // NsgInput(
                                  //     selectionController:
                                  //         Get.find<ProjectController>(),
                                  //     dataItem: controller.currentItem,
                                  //     fieldName: TaskDocGenerated.nameSprintId,
                                  //     label: 'Спринт',
                                  //     selectionForm: Routes.projectListPage),
                                  // NsgInput(
                                  //   dataItem: controller.currentItem,
                                  //   fieldName: TaskDocGenerated.nameName,
                                  //   label: 'Заголовок',
                                  // ),
                                  // NsgInput(
                                  //   dataItem: controller.currentItem,
                                  //   fieldName: TaskDocGenerated.nameDescription,
                                  //   label: 'Описание',
                                  //   minLines: 3,
                                  //   maxLines: 20,
                                  // ),

                                  // NsgTable(
                                  //   controller:
                                  //       Get.find<CommentTableTasksController>(),
                                  //   columns: [
                                  //     NsgTableColumn(
                                  //         name:
                                  //             TaskDocCommentsTableGenerated.nameDate,
                                  //         width: 80,
                                  //         //expanded: true,
                                  //         presentation: 'Дата'),
                                  //     NsgTableColumn(
                                  //         name: TaskDocCommentsTableGenerated
                                  //             .nameAuthorId,
                                  //         width: 80,
                                  //         //expanded: true,
                                  //         presentation: 'Автор'),
                                  //     NsgTableColumn(
                                  //         name:
                                  //             TaskDocCommentsTableGenerated.nameText,
                                  //         expanded: true,
                                  //         presentation: 'Комментарий')
                                  //   ],
                                  //   elementEditPageName: Routes.commentRowPage,
                                  // ),
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

  Widget imageGallery() {
    // return Get.find<TaskImageController>().obx((state) =>
    return Get.find<TaskFilesController>().obx(
      (state) => NsgFilePicker(
        useFilePicker: true,
        showAsWidget: true,
        callback: (value) async {},
        // objectsList: Get.find<TaskImageController>().images,
        objectsList: Get.find<TaskFilesController>().files,
        allowedFileFormats: const ['doc', 'docx', 'rtf', 'xls', 'xlsx', 'pdf'],
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
