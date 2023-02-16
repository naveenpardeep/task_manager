import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:nsg_controls/nsg_controls.dart';

import 'package:get/get.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';
import 'package:task_manager_app/forms/tasks/task_checklist_page.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_page.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> with TickerProviderStateMixin {
  late TabController _tabController;
  var taskController = Get.find<TasksController>();
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

    return BodyWrap(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                if (taskController.currentItem.taskStatus.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                } else if (taskController.currentItem.name.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
                } else {
                  taskController.currentItem.dateUpdated = DateTime.now();

                  await taskController.itemPagePost();
                  Get.find<TasksController>().refreshData();
                  Get.toNamed(Routes.homePage);
                }
              },
              icon: const Icon(Icons.check))
        ],
        backgroundColor: Colors.white,
        elevation: 0.0, //Shadow gone
        centerTitle: true,
        title: Text(
          taskController.currentItem.isEmpty
              ? 'Новая задача'.toUpperCase()
              : taskController.currentItem.name.toString().toUpperCase(),
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
            tabs: const <Widget>[
              Tab(
                child: Text(
                  'Основное',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                  child: Text(
                'Чек-лист',
                style: TextStyle(color: Colors.black),
              )),
              Tab(
                child: Text(
                  'Комментарии',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
      ),
      body: taskController.obx(
        (state) => TabBarView(controller: _tabController, children: [
          Expanded(child: TasksPage()),
          Expanded(child: ChecklistPage()),
          Expanded(child: TasksCommentRowPage()),
        ]),
      ),
    ));
  }
}
