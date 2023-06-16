import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_task_comment_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';

import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_page.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';

import '../periodic_tasks/periodic_tasks_controller.dart';
import '../widgets/tt_tabs.dart';

class TaskEditPage extends StatefulWidget {
  const TaskEditPage({super.key});

  @override
  State<TaskEditPage> createState() => _TaskEditPageState();
}

class _TaskEditPageState extends State<TaskEditPage> with TickerProviderStateMixin {
  TTTabsTab currentTab = TTTabsTab(name: 'Основное', onTap: (v) {});
  var taskController = Get.find<TasksController>().isPeriodicController ? Get.find<PeriodicTasksController>() : Get.find<TasksController>();
 
   var commentcontroller = Get.find<TaskCommentsController>().isTaskCommentCont ? Get.find<TaskCommentsController>() : Get.find<PeriodicTaskCommentsController>();

  var checkcontroller =Get.find<TasksController>().isPeriodicController ? Get.find<PeriodicTaskCheckListController>() : Get.find<TaskCheckListController>() ;

  @override
  void initState() {
    super.initState();
    if (commentcontroller.lateInit) {
      commentcontroller.requestItems();
    }
     if (checkcontroller.lateInit) {
      checkcontroller.requestItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalChecklist = checkcontroller.items.length.toDouble();
    double isDone = checkcontroller.items.where((element) => element.isDone == true).length.toDouble();

    late double donePercent;
    if (isDone != 0) {
      donePercent = (isDone / totalChecklist) * 100;
    } else {
      donePercent = 0.0;
    }
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TTAppBar(
            title: taskController.currentItem.docNumber.isEmpty ? 'Новая задача' : taskController.currentItem.docNumber,
            leftIcons: [
              TTAppBarIcon(
                icon: Icons.arrow_back_ios_new,
                onTap: () {
                  Get.back();
                },
              )
            ],
            rightIcons: [
              if (currentTab.name == 'Чеклист${donePercent.toStringAsFixed(1)}%' || currentTab.name == 'Чеклист')
                TTAppBarIcon(
                  icon: Icons.add,
                  onTap: () async {
                    if (taskController.currentItem.taskStatus.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                    } else if (taskController.currentItem.name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
                    } else {
                      checkcontroller.newItemPageOpen(pageName: Routes.taskChecklistPage);
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
                    taskController.refreshData();
                    Get.back();
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
                  name: checkcontroller.items.isEmpty ? 'Чеклист' : 'Чеклист${donePercent.toStringAsFixed(1)}%',
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
          Expanded(child: content(donePercent)),
        ],
      ),
    ));
  }

  Widget content(donePercent) {
    if (currentTab.name == 'Основное') {
      return taskController.obx((state) => const TasksPage());
    }
    if (currentTab.name == 'Чеклист${donePercent.toStringAsFixed(1)}%' || currentTab.name == 'Чеклист') {
      return taskController.obx((state) => const ChecklistPage());
    }
    return commentcontroller.obx((state) => const TasksCommentPage());
  }
}
