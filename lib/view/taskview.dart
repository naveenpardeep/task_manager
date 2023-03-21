// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/helpers/nsg_data_format.dart';
import 'package:task_manager_app/1/availableButtons.dart';
import 'package:task_manager_app/1/nsg_rich_text.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/generated/task_doc.g.dart';

import '../forms/tasks/task_file_controller.dart';

class TaskViewPage extends StatefulWidget {
  const TaskViewPage({
    super.key,
  });

  @override
  State<TaskViewPage> createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> with TickerProviderStateMixin {
  DateFormat formateddate = DateFormat("dd.MM.yyyy /HH:mm");
  late TabController _tabController;
  var controller = Get.find<TasksController>();
  var commnetController = Get.find<CommentTableTasksController>();
  late double height;
  late double width;
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return controller.obx((state) => SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              automaticallyImplyLeading: false,

              backgroundColor: Colors.white,
              elevation: 0.0, //Shadow gone
              centerTitle: true,
              title: controller.obx((state) => Text(
                    controller.currentItem.isEmpty ? 'Новая задача'.toUpperCase() : controller.currentItem.docNumber.toString().toUpperCase(),
                    style: const TextStyle(color: Colors.black),
                  )),
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
                  tabs: const <Widget>[
                    Tab(
                      child: Text(
                        'Основное',
                        style: TextStyle(color: Color(0xff3EA8AB)),
                      ),
                    ),
                    Tab(
                        child: Text(
                      'Чек-лист',
                      style: TextStyle(color: Color(0xff3EA8AB)),
                    )),
                    Tab(
                      child: Text(
                        'Комментарии',
                        style: TextStyle(color: Color(0xff3EA8AB)),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(controller: _tabController, children: [
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
                            thickness: 10,
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
                                        ' ${controller.currentItem.name}',
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
                                                  controller.currentItem.author.toString(),
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
                                                  '${controller.currentItem.taskStatus}',
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
                                                  '${controller.currentItem.assignee}',
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
                                                  '${controller.currentItem.priority}',
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
                                                formateddate.format(controller.currentItem.dateDeadline),
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
                                                formateddate.format(controller.currentItem.dateRemind),
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
                                    NsgRichText(
                                        disabled: true,
                                        key: GlobalKey(),
                                        availableButtons: const [...AvailableButtons.allValues],
                                        controller: controller,
                                        dataItem: controller.currentItem,
                                        fieldName: TaskDocGenerated.nameDescription,
                                        fileController: Get.find<TaskFilesController>()),
                                   if (controller.currentItem.name.isNotEmpty)  imageGallery(),
                               
                                  ],
                                )),
                          )),
                    ),
                  ],
                ),
              ),
              Container(key: GlobalKey(), child: const ChecklistPage()),
              Container(key: GlobalKey(), child: const TasksCommentRowPage()),
            ]),
          ),
        ));
  }

  Widget imageGallery() {

    return Get.find<TaskFilesController>().obx(
      (state) => NsgFilePicker(
        useFilePicker: false,
        showAsWidget: true,
        callback: (value) async {},
      
        objectsList: Get.find<TaskFilesController>().files,
        allowedFileFormats: const ['doc', 'docx', 'rtf', 'xls', 'xlsx', 'pdf'],
      ),
    );
  }

  String getCreatedDay() {
    var todayDate = DateTime.now();
    final dateCreated = controller.currentItem.date;
    var daysCreated = todayDate.difference(dateCreated).inDays;
    if (daysCreated > 30) {
      return '${NsgDateFormat.dateFormat(controller.currentItem.date, format: 'dd.MM.yy HH:mm')}';
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
