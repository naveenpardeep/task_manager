// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/tasks/checkList.dart';
import 'package:task_manager_app/forms/tasks/task_comment_page.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

class TaskViewPage extends StatefulWidget {
  const TaskViewPage({Key? key}) : super(key: key);

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

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                if (controller.currentItem.taskStatus.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, выберите статус задачи')));
                } else if (controller.currentItem.name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('пожалуйста, введите название задачи')));
                } else {
                  controller.currentItem.dateUpdated = DateTime.now();

                  await controller.itemPagePost();
                  Get.find<TasksController>().refreshData();
                  //  Get.toNamed(Routes.homePage);
                }
              },
              icon: const Icon(Icons.check))
        ],
        backgroundColor: Colors.white,
        elevation: 0.0, //Shadow gone
        centerTitle: true,
        title: Text(
          controller.currentItem.isEmpty ? 'Новая задача'.toUpperCase() : controller.currentItem.name.toString().toUpperCase(),
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
      body: controller.obx(
        // ignore: prefer_const_literals_to_create_immutables
        (state) => TabBarView(controller: _tabController, children: [
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
                        thickness: 15,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            child: Column(
                              children: [
                                Text(
                                  'Номер задачи:  ${controller.currentItem.docNumber}',
                                ),
                                Text('Дата создания:  ${formateddate.format(controller.currentItem.date)}'),
                                Text(
                                  'Автор задачи:  ${controller.currentItem.author} ',
                                ),
                                Text('Статус задачи: ${controller.currentItem.taskStatus}'),
                                Text('Исполнитель : ${controller.currentItem.assignee}'),
                                Text('Приоритет : ${controller.currentItem.priority}'),
                                Text('Дедлайн : ${formateddate.format(controller.currentItem.dateDeadline)}'),
                              ],
                            )),
                      )),
                ),
              ],
            ),
          ),
          const ChecklistPage(),
          const TasksCommentRowPage(),
        ]),
      ),
    ));
  }
}
