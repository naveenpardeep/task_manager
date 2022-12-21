import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../../app_pages.dart';
import '../project/project_controller.dart';
import '../task_status/task_status_controller.dart';
import 'task_image_controller.dart';

class TasksPage extends GetView<TasksController> {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todaydate = controller.currentItem.date;

    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    String formatted = formateddate.format(todaydate);
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
                  backColor: Color(0xff7876D9),
                  text: controller.currentItem.isEmpty
                      ? 'Новая задача'.toUpperCase()
                      : controller.currentItem.date.toString().toUpperCase(),
                  icon: Icons.arrow_back_ios_new,
                  color: Colors.white,

                  colorsInverted: true,
                  // bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () {
                    controller.itemPagePost();
                  },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
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
                            NsgText('Создано :$formatted'),
                            NsgInput(
                              selectionController:
                                  Get.find<TaskStatusController>(),
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameTaskStatusId,
                              label: 'Статус',
                            
                            ),
                            NsgInput(
                              selectionController:
                                  Get.find<UserAccountController>(),
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameAssigneeId,
                              label: 'Исполнитель',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameName,
                              label: 'Название задачи',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameDescription,
                              label: 'Описание задачи',
                              minLines: 3,
                              maxLines: 20,
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.namePriority,
                              label: 'Приоритет',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameComment,
                              label: 'Комментарий',
                              minLines: 3,
                              maxLines: 20,
                            ),
                            //   NsgInput(
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

                            //  Flexible(child: imageGallery()),
                          ],
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
    return NsgFilePicker(
      showAsWidget: true,
      callback: (value) {},
      objectsList: Get.find<TaskImageController>().images,
      allowedFileFormats: const [],
    );
  }
}
