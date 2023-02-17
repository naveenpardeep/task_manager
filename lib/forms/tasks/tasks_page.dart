import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../1/nsg_rich_text.dart';
import '../task_status/task_status_controller.dart';
import 'task_image_controller.dart';
import 'task_user_account_controler.dart';

class TasksPage extends GetView<TasksController> {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todaydate = controller.currentItem.date;
    var updatedate = controller.currentItem.dateUpdated;
    var notificationController = Get.find<NotificationController>();
    var imageCont = Get.find<TaskImageController>();
    var fileController = Get.find<TaskFilesController>();
    if (notificationController.lateInit) {
      notificationController.requestItems();
    }
    if (imageCont.lateInit) {
      imageCont.requestItems();
    }
    if (fileController.lateInit) {
      fileController.requestItems();
    }

    final scrollController = ScrollController();

    String formatted = NsgDateFormat.dateFormat(todaydate, format: 'dd.MM.yy HH:mm');
    String formatupdate = NsgDateFormat.dateFormat(updatedate, format: 'dd.MM.yy HH:mm');
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
                // NsgAppBar(
                //   backColor: const Color(0xff7876D9),
                //   text: controller.currentItem.isEmpty
                //       ? 'Новая задача'.toUpperCase()
                //       : controller.currentItem.name.toString().toUpperCase(),
                //   icon: Icons.arrow_back_ios_new,
                //   color: Colors.white,

                //   colorsInverted: true,
                //   // bottomCircular: true,
                //   onPressed: () {
                //     controller.itemPageCancel();
                //   },
                //   icon2: Icons.check,
                //   onPressed2: () async {
                //     if (controller.currentItem.taskStatus.isEmpty) {
                //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //           content: Text('Пожалуйста, выберите статус задачи')));
                //     } else if (controller.currentItem.name.isEmpty) {
                //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //           content:
                //               Text('пожалуйста, введите название задачи')));
                //     } else {
                //       controller.currentItem.dateUpdated = DateTime.now();
                //       // notificationController.currentItem.task.docNumber=controller.currentItem.docNumber;
                //       // notificationController.currentItem.task.name=controller.currentItem.name;
                //       // notificationController.currentItem.task.date=todaydate;
                //       // notificationController.itemPagePost();
                //       await controller.itemPagePost();
                //       Get.find<TasksController>().refreshData();
                //       Get.toNamed(Routes.homePage);
                //     }
                //   },
                // ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: scrollController,
                        thickness: 15,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: scrollController,
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
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'Создана $formatted',
                                      style: TextStyle(color: ControlOptions.instance.colorGrey),
                                    )),
                              ),
                              if (controller.currentItem.name.isNotEmpty)
                                Text(
                                  'Обновлена $formatupdate',
                                  style: TextStyle(color: ControlOptions.instance.colorGrey),
                                ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.nameName,
                                label: 'Название задачи',
                              ),
                              NsgInput(
                                selectionController: Get.find<TaskStatusController>(),
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.nameTaskStatusId,
                                label: 'Статус',
                              ),

                              // NsgInput(
                              //   selectionController:
                              //       Get.find<UserAccountController>(),
                              //   dataItem: controller.currentItem,
                              //   fieldName: TaskDocGenerated.nameAssigneeId,
                              //   label: 'Исполнитель',
                              // ),
                              NsgInput(
                                label: 'Исполнитель',
                                selectionController: Get.find<TaskUserAccountController>(),
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.nameAssigneeId,
                                //selectionForm: Routes.userAccountListPage,
                              ),

                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.nameTaskNumber,
                                label: 'Номер задачи',
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
                                  dataItem: controller.currentItem,
                                  fieldName: TaskDocGenerated.nameDescription,
                                  objectsList: Get.find<TaskImageController>().images),
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
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.namePriority,
                                label: 'Приоритет',
                              ),

                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.nameFootnote,
                                label: 'Примечание',
                                minLines: 1,
                                maxLines: 5,
                              ),
                              NsgInput(
                                dataItem: controller.currentItem,
                                fieldName: TaskDocGenerated.nameDateRemind,
                                label: 'Напонинание о задаче',
                              ),
                              NsgInput(
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

                              if (controller.currentItem.name.isNotEmpty) Flexible(child: filesUpload()),
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

  Widget imageGallery() {
    // return Get.find<TaskImageController>().obx((state) =>
    return Get.find<TaskImageController>().obx(
      (state) => NsgFilePicker(
        useFilePicker: true,
        showAsWidget: true,
        callback: (value) {},
        objectsList: Get.find<TaskImageController>().images,
        allowedFileFormats: const [],
      ),
    );
  }

  Widget filesUpload() {
    return Get.find<TaskFilesController>().obx((state) => NsgFilePicker(
          textChooseFile: 'Add Files',
          useFilePicker: true,
          showAsWidget: true,
          callback: (value) {},
          objectsList: Get.find<TaskFilesController>().files,
          allowedFileFormats: const ['doc', 'docx', 'rtf', 'xls', 'xlsx', 'pdf', 'rtf'],
        ));
  }
}
