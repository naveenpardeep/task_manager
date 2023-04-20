import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_page.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> with TickerProviderStateMixin {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          if (_tabController.index == 0)
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
                    await taskController.itemPagePost(goBack: true);
                    Get.find<TasksController>().refreshData();
                  }
                },
                icon: const Icon(Icons.check)),
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
        title: Text(
          "${taskController.currentItem.docNumber}  ",
          style: const TextStyle(color: Colors.black),
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
          const TasksPage(),
          Container(key: GlobalKey(), child: const ChecklistPage()),
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
}
