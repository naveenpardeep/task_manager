import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_control_options.dart';
import 'package:nsg_controls/nsg_icon_button.dart';
import 'package:nsg_data/helpers/nsg_data_format.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_manager_app/1/availableButtons.dart';
import 'package:task_manager_app/1/nsg_rich_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_page.dart';
import 'package:task_manager_app/image_file_view/tt_nsg_file_picker.dart';
import 'package:task_manager_app/model/generated/task_doc.g.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> with TickerProviderStateMixin {
  late TabController _tabController;
  var taskController = Get.find<TasksController>();
  var commnetController = Get.find<TaskCommentsController>();
  late double height;
  late double width;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    if (commnetController.lateInit) {
      commnetController.requestItems();
    }
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_setIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formateddate = DateFormat("dd.MM.yyyy /HH:mm");
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    double totalChecklist = taskController.currentItem.checkList.rows.length.toDouble();
    double isDone = taskController.currentItem.checkList.rows.where((element) => element.isDone == true).length.toDouble();

    late double donePercent;
    if (isDone != 0) {
      donePercent = (isDone / totalChecklist);
    } else {
      donePercent = 0.0;
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {
          Get.back();
        }, ),
        actions: [
          if (_tabController.index == 0)
          (kIsWeb || (Platform.isWindows || Platform.isLinux)) ?
            IconButton(
                onPressed: () async {
                  if (taskController.currentItem.taskStatus.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                  } else if (taskController.currentItem.name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
                  } else {
                    taskController.currentItem.dateUpdated = DateTime.now();
                    if (taskController.currentItem.assignee.isEmpty) {
                      taskController.currentItem.assignee = Get.find<ProjectController>().currentItem.defaultUser;
                    }
                    await taskController.itemPagePost(goBack: false);
                    Get.find<TasksController>().refreshData();
                    Get.toNamed(Routes.homePage);
                    Get.find<TasksController>().createNewItemAsync();
                  }
                },
                icon: const Icon(Icons.check)) : 
                IconButton(onPressed: (){
                  taskController.itemPageOpen(taskController.currentItem, Routes.taskEditPageMobile);

                }, icon: const Icon(Icons.edit)),
          if (_tabController.index == 1)
            IconButton(
                onPressed: () async {
                  if (taskController.currentItem.taskStatus.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                  } else if (taskController.currentItem.name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
                  } else {
                    Get.find<TaskCheckListController>().newItemPageOpen(pageName: Routes.taskChecklistPage);
                  }
                },
                icon: const Icon(Icons.add))
        ],
        backgroundColor: Colors.white,
        elevation: 0.0, //Shadow gone
        centerTitle: true,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${taskController.currentItem.docNumber}  ",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        bottom: TabBar(
            onTap: (value) {
              setState(() {
                if (_tabController.index == 0) {
                  _tabController.index = 0;
                } else if (_tabController.index == 1) {
                  _tabController.index = 1;
                } else if (_tabController.index == 2) {
                  _tabController.index = 2;
                }
              });
            },
            controller: _tabController,
            tabs: <Widget>[
              const Tab(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Основное',
                    style: TextStyle(color: Color(0xff3EA8AB)),
                  ),
                ),
              ),
              Tab(
                  child: Column(
                children: [
                  const Text(
                    'Чек-лист',
                    style: TextStyle(color: Color(0xff3EA8AB)),
                  ),
                  if (taskController.currentItem.checkList.rows.isNotEmpty && (_tabController.index == 0 || _tabController.index == 2))
                    LinearPercentIndicator(
                      key: GlobalKey(),
                      center: Text(
                        ('${(donePercent * 100).toStringAsFixed(2)}%'),
                        style: const TextStyle(color: Colors.white),
                      ),
                      lineHeight: 20,
                      percent: donePercent,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.green,
                    ),
                ],
              )),
              const Tab(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Комментарии',
                    style: TextStyle(color: Color(0xff3EA8AB)),
                  ),
                ),
              ),
            ]),
      ),
      body: taskController.obx(
        // ignore: prefer_const_literals_to_create_immutables
        (state) => TabBarView(controller: _tabController, children: [
       (kIsWeb || (Platform.isWindows || Platform.isLinux)) ?
       const TasksPage() :
        
            Container(
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
                          thickness: width > 700 ? 10 : 0,
                          trackBorderColor: ControlOptions.instance.colorGreyLight,
                          trackColor: ControlOptions.instance.colorGreyLight,
                          thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                          radius: const Radius.circular(0),
                          child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      ' ${taskController.currentItem.name}',
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'Детали задачи',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      // Row(
                                      //   children: [
                                      //     const Padding(
                                      //       padding: EdgeInsets.only(right: 5),
                                      //       child: Text(
                                      //         'Номер задачи:  ',
                                      //         style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                      //       ),
                                      //     ),
                                      //     Expanded(
                                      //       child: Text(
                                      //         controller.currentItem.docNumber,
                                      //         style: const TextStyle(
                                      //           fontFamily: 'Inter',
                                      //           fontSize: 14,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 40),
                                              child: Text(
                                                'Дата создания:  ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: ControlOptions.instance.colorMainLight),
                                              ),
                                            ),
                                            Expanded(
                                              child: Row(children: [
                                                Text(
                                                  getCreatedDay(),
                                                  style: const TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 2),
                                                  child: Icon(
                                                    Icons.access_time,
                                                    size: 20,
                                                    color: ControlOptions.instance.colorMainLight,
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 47),
                                              child: Text(
                                                'Автор задачи:  ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: ControlOptions.instance.colorMainLight),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                taskController.currentItem.author.toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 44),
                                              child: Text(
                                                'Статус задачи: ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: ControlOptions.instance.colorMainLight),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${taskController.currentItem.taskStatus}',
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 49),
                                              child: Text(
                                                'Исполнитель : ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: ControlOptions.instance.colorMainLight),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${taskController.currentItem.assignee}',
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 69),
                                              child: Text(
                                                'Приоритет :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: ControlOptions.instance.colorMainLight),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${taskController.currentItem.priority}',
                                                style: const TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            // ignore: prefer_const_constructors
                                            Padding(
                                              padding: const EdgeInsets.only(right: 82),
                                              child: Text(
                                                'Дедлайн :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: ControlOptions.instance.colorMainLight),
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              formateddate.format(taskController.currentItem.dateDeadline),
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 14,
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            // ignore: prefer_const_constructors
                                            Padding(
                                              padding: const EdgeInsets.only(right: 5),
                                              child: Text(
                                                'Напомнить о задаче:',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: ControlOptions.instance.colorMainLight),
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              formateddate.format(taskController.currentItem.dateRemind),
                                              style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 14,
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      'Описание задачи',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NsgRichText(
                                        disabled: true,
                                        key: GlobalKey(),
                                        availableButtons: const [...AvailableButtons.allValues],
                                        controller: taskController,
                                        dataItem: taskController.currentItem,
                                        fieldName: TaskDocGenerated.nameDescription,
                                        fileController: Get.find<TaskFilesController>()),
                                  ),
                                  if (taskController.currentItem.name.isNotEmpty) SizedBox(key: GlobalKey(), height: 500, width: 375, child: imageGallery()),
                                ],
                              )),
                        )),
                  ),
                ],
              ),
            ),
             const ChecklistPage(),
          commnetController.obx(
              // ignore: prefer_const_literals_to_create_immutables
              (state) => const TasksCommentPage()),
        ]),
      ),
    ));
  }

  void _setIndex() {
    setState(() {
      if (_tabController.index == 0) {
        _tabController.index = 0;
      } else if (_tabController.index == 1) {
        _tabController.index = 1;
      } else if (_tabController.index == 2) {
        _tabController.index = 2;
      }
    });
  }

  Widget imageGallery() {
    return Get.find<TaskFilesController>().obx(
      (state) => TTNsgFilePicker(
        useFilePicker: false,
        showAsWidget: false,
        callback: (value) async {},
        objectsList: Get.find<TaskFilesController>().files,
      ),
    );
  }

  String getCreatedDay() {
    var todayDate = DateTime.now();
    final dateCreated = taskController.currentItem.date;
    var daysCreated = todayDate.difference(dateCreated).inDays;
    if (daysCreated > 30) {
      return '${NsgDateFormat.dateFormat(taskController.currentItem.date, format: 'dd.MM.yy HH:mm')}';
    }
    var minutes = todayDate.difference(dateCreated).inMinutes;
    if (minutes < 60) {
      return '$minutes мин. назад';
    }
    var hours = todayDate.difference(dateCreated).inHours;
    if (hours <= 24) {
      return '$hours Час. назад';
    }

    if (daysCreated <= 30) {
      return '$daysCreated дн. назад';
    }

    return '$daysCreated дн. назад';
  }
}
