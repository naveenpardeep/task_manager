// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/TaskList/tasklist_controller.dart';
import 'package:task_manager_app/forms/TaskList/taskopen_for_tasklist.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

class TaskPageForTaskList extends StatefulWidget {
  const TaskPageForTaskList({super.key});

  @override
  State<TaskPageForTaskList> createState() => _TaskPageForTaskListState();
}

class _TaskPageForTaskListState extends State<TaskPageForTaskList> with TickerProviderStateMixin {
  late TabController _tabController;
  var taskController = Get.find<TaskListController>();
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
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
       //   actions: [
            // if (_tabController.index == 0)
            //   IconButton(
            //       onPressed: () async {
            //         if (taskController.currentItem.taskStatus.isEmpty) {
            //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
            //         } else if (taskController.currentItem.name.isEmpty) {
            //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
            //         } else {
            //           taskController.currentItem.dateUpdated = DateTime.now();
            //           if (taskController.currentItem.assignee.isEmpty) {
            //             taskController.currentItem.assignee = Get.find<ProjectController>().currentItem.defaultUser;
            //           }
            //           await taskController.itemPagePost(goBack: false);
            //           Get.find<TasksController>().refreshData();
            //           Get.toNamed(Routes.homePage);
            //           Get.find<TasksController>().createNewItemAsync();
            //         }
            //       },
            //       icon: const Icon(Icons.check)),
            // if (_tabController.index == 1)
            //   IconButton(
            //       onPressed: () async {
            //         if (taskController.currentItem.taskStatus.isEmpty) {
            //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
            //         } else if (taskController.currentItem.name.isEmpty) {
            //           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
            //         } else {
            //           Get.find<TaskCheckListController>().newItemPageOpen(pageName: Routes.taskChecklistPage);
            //         }
            //       },
            //       icon: const Icon(Icons.add))
      //    ],
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
        body: TabBarView(controller: _tabController, children: [
          const TaskopenForTaskList(),
          const ChecklistPage(),
          commnetController.obx((state) => const TasksCommentPage()),
        ]),
      ),
    );
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
