// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/1/nsg_rich_text.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/task_image_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/generated/task_doc.g.dart';

class TaskViewPage extends StatefulWidget {
  const TaskViewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskViewPage> createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> with TickerProviderStateMixin {
  DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
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
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              const Text(
                                                'Номер задачи:  ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              const Text(
                                                'Дата создания:  ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              const Text(
                                                'Автор задачи:  ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              const Text(
                                                'Статус задачи: ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              const Text(
                                                'Исполнитель : ',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              const Text(
                                                'Приоритет :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                              const Text(
                                                'Дедлайн :',
                                                style: TextStyle(fontFamily: 'Inter', fontSize: 14, color: Color(0xff529FBF)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(controller.currentItem.docNumber),
                                            Text(formateddate.format(controller.currentItem.date)),
                                            Text(controller.currentItem.author.toString()),
                                            Text('${controller.currentItem.taskStatus}'),
                                            Text('${controller.currentItem.assignee}'),
                                            Text('${controller.currentItem.priority}'),
                                            Text(formateddate.format(controller.currentItem.dateDeadline)),
                                          ],
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
                                      key: GlobalKey(),
                                        availableButtons: const [],
                                        controller: controller,
                                        dataItem: controller.currentItem,
                                        fieldName: TaskDocGenerated.nameDescription,
                                        objectsList: Get.find<TaskImageController>().images),
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
}
