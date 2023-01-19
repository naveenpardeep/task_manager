import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

import '../task_status/task_status_controller.dart';
import 'task_image_controller.dart';

class TasksPage extends GetView<TasksController> {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todaydate = controller.currentItem.date;
    var updatedate = controller.currentItem.dateUpdated;

    String formatted =
        NsgDateFormat.dateFormat(todaydate, format: 'dd.MM.yy HH:mm');
    String formatupdate =
        NsgDateFormat.dateFormat(updatedate, format: 'dd.MM.yy HH:mm');
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
                  backColor: const Color(0xff7876D9),
                  text: controller.currentItem.isEmpty
                      ? 'Новая задача'.toUpperCase()
                      : controller.currentItem.name.toString().toUpperCase(),
                  icon: Icons.arrow_back_ios_new,
                  color: Colors.white,

                  colorsInverted: true,
                  // bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  icon2: Icons.check,
                  onPressed2: () async {
                    if (controller.currentItem.taskStatus.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Пожалуйста, выберите статус задачи')));
                    } else if (controller.currentItem.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('пожалуйста, введите название задачи')));
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
                      child: SingleChildScrollView(
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
                                    style: TextStyle(
                                        color:
                                            ControlOptions.instance.colorGrey),
                                  )),
                            ),
                            if (controller.currentItem.name.isNotEmpty)
                              Text(
                                'Обновлена $formatupdate',
                                style: TextStyle(
                                    color: ControlOptions.instance.colorGrey),
                              ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameName,
                              label: 'Название задачи',
                            ),
                            NsgInput(
                              selectionController:
                                  Get.find<TaskStatusController>(),
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
                              selectionController:
                                  Get.find<UserAccountController>(),
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameAssigneeId,
                              selectionForm: Routes.userAccountListPage,
                            ),

                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameTaskNumber,
                              label: 'Номер задачи',
                            ),
                            NsgInput(
                              dataItem: controller.currentItem,
                              fieldName: TaskDocGenerated.nameDescription,
                              label: 'Описание задачи',
                              minLines: 1,
                              maxLines: 5,
                            ),
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

                            Flexible(child: imageGallery()),
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
    return Get.find<TaskImageController>().obx(
      (state) => NsgFilePicker(
        showAsWidget: true,
        callback: (value) {},
        objectsList: Get.find<TaskImageController>().images,
        allowedFileFormats: const [],
      ),
    );
  }
}
