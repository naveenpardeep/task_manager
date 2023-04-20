import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_page.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';

import '../widgets/tt_tabs.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> with TickerProviderStateMixin {
  TTTabsTab currentTab = TTTabsTab(name: 'Основное', onTap: (v) {});
  var taskController = Get.find<TasksController>();
  var commnetController = Get.find<TaskCommentsController>();

  @override
  void initState() {
    super.initState();
    if (commnetController.lateInit) {
      commnetController.requestItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TTAppBar(
            title: '${taskController.currentItem.taskNumber}',
            leftIcons: [
              TTAppBarIcon(
                icon: Icons.arrow_back_ios_new,
                onTap: () {
                  Get.back();
                },
              )
            ],
            rightIcons: [
              if (currentTab.name == 'Чек-лиск')
                TTAppBarIcon(
                  icon: Icons.add,
                  onTap: () async {
                    if (taskController.currentItem.taskStatus.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                    } else if (taskController.currentItem.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
                    } else {
                      Get.find<TaskCheckListController>().newItemPageOpen(pageName: Routes.taskChecklistPage);
                    }
                  },
                ),
              TTAppBarIcon(
                icon: Icons.check,
                onTap: () async {
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
              )
            ],
          ),
          TTTabs(
            currentTab: currentTab,
            tabs: [
              TTTabsTab(
                  name: 'Основное',
                  onTap: (v) {
                    currentTab = v;
                    setState(() {});
                  }),
              TTTabsTab(
                  name: 'Чек-лиск',
                  onTap: (v) {
                    currentTab = v;
                    setState(() {});
                  }),
              TTTabsTab(
                  name: 'Комментарии',
                  onTap: (v) {
                    currentTab = v;
                    setState(() {});
                  })
            ],
          ),
          Expanded(child: content()),
        ],
      ),
    ));
  }

  Widget content() {
    if (currentTab.name == 'Основное') {
      return taskController.obx((state) => const TasksPage());
    }
    if (currentTab.name == 'Чек-лиск') {
      return taskController.obx((state) => const ChecklistPage());
    }
    return commnetController.obx((state) => const TasksCommentPage());
  }
}
