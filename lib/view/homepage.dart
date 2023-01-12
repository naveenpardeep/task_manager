import 'dart:math';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/formfields/nsg_period_filter.dart';

import 'package:nsg_controls/nsg_controls.dart';

import 'package:nsg_controls/nsg_text.dart';
import 'package:nsg_data/helpers/nsg_period.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';

import 'package:task_manager_app/model/task_status.dart';

import '../model/generated/project_item.g.dart';
import '../model/generated/task_board.g.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String projectName = '';
  bool isDatesearch = false;

  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  var taskConstroller = Get.find<TasksController>();
  var projectController = Get.find<ProjectController>();
  var taskBoardController = Get.find<TaskBoardController>();
  var taskStatusTableController = Get.find<TaskStatusTableController>();
  var userAccountController = Get.find<UserAccountController>();
  var textEditController = TextEditingController();
  String screenName = '';
  String searchvalue = '';
  DateTime searchDate = DateTime.now();
  DateFormat searchformat = DateFormat("dd-MM-yyyy");

  DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
  @override
  void initState() {
    super.initState();

    projectName;
    searchvalue;
    searchDate;
    isDatesearch;
    textEditController;

    screenName;
  }

  @override
  Widget build(BuildContext context) {
    projectName = projectController.currentItem.name;
    // screenName=taskBoardController.currentItem.name;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: width >= 700 ? 70 : 150,
          actions: [
            Image.asset(
              'lib/assets/images/logo.png',
              height: 70,
            ),
          ],
          backgroundColor: const Color(0xff7876D9),
          flexibleSpace: width >= 700
              ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 15, 15),
                      child: TextButton(
                        child: Row(
                          children: const [
                            Tooltip(
                              message: 'Выберите проект здесь',
                              child: Text(
                                'Проекты',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        onPressed: () {
                          var form = NsgSelection(
                            inputType: NsgInputType.reference,
                            controller: projectController,
                          );
                          form.selectFromArray(
                            'Проекты',
                            (item) {
                              var row = ProjectItemGenerated();
                              // row.name = item as ProjectItem;
                              setState(() {
                                projectName =
                                    projectController.currentItem.name;
                              });
                              taskStatusTableController.sendNotify();
                              projectController.sendNotify();
                            },
                          );
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.all(15),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isDatesearch = false;
                            searchDate = DateTime.now();
                            searchvalue = '';
                            textEditController.clear();
                          });
                        },
                        child: const Tooltip(
                          message: 'А при нажатии этой, фильтр сбрасывается',
                          child: Text(
                            "Все заявки",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                  const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Мои задачи",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                ])
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 15, 15),
                      child: TextButton(
                        child: Row(
                          children: const [
                            Tooltip(
                              message: 'Выберите проект здесь',
                              child: Text(
                                'Проекты',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        onPressed: () {
                          var form = NsgSelection(
                            inputType: NsgInputType.reference,
                            controller: projectController,
                          );
                          form.selectFromArray(
                            'Проекты',
                            (item) {
                              var row = ProjectItemGenerated();
                              // row.name = item as ProjectItem;
                              setState(() {
                                projectName =
                                    projectController.currentItem.name;
                              });
                              taskStatusTableController.sendNotify();
                              projectController.sendNotify();
                            },
                          );
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 15, 15),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isDatesearch = false;
                            searchDate = DateTime.now();
                            searchvalue = '';
                            textEditController.clear();
                          });
                        },
                        child: const Tooltip(
                          message: 'А при нажатии этой, фильтр сбрасывается',
                          child: Text(
                            "Все заявки",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 15, 15),
                      child: Text(
                        "Мои задачи",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                ])),
      body: AdaptiveScrollbar(
        controller: horizontalScroll,
        child: SingleChildScrollView(
          controller: horizontalScroll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (projectName.isEmpty)
              //   const Padding(
              //       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              //       child: Icon(Icons.arrow_upward)),

              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(
                        projectName,
                        textScaleFactor: 1.4,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_rounded),
                        onPressed: () {
                          projectController.currentItem.name = projectName;
                          Get.toNamed(Routes.projectPage);
                        },
                      )
                    ],
                  )),
              width >= 700
                  ? Row(
                      children: [
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Tooltip(
                                  message:
                                      'Поиск по тексту задачи, Описание задачи',
                                  child: TextField(
                                      controller: textEditController,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: (() {
                                                setState(() {
                                                  textEditController.clear();
                                                  searchvalue = '';
                                                });
                                              }),
                                              icon: const Icon(Icons.cancel)),
                                          // prefixIcon: Icon(Icons.search),
                                          hintText: 'Поиск по тексту'),
                                      onChanged: (val) {
                                        searchvalue = val;

                                        taskStatusTableController.sendNotify();
                                      }),
                                ))),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Tooltip(
                                  message: 'Поиск задач по дате создания',
                                  child: NsgPeriodFilter(
                                    controller: taskConstroller,
                                    label: 'Поиск по дате',

                                    // initialTime: DateTime.now(),
                                  ),
                                ))),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: const Text('Поиск по исполнителю',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      onPressed: () {
                                        selectCreator();
                                      },
                                    ),
                                    const Divider(
                                      color: Color(0xff7876D9),
                                    )
                                  ],
                                ))),
                        Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(1),
                                child: Column(
                                  children: [
                                    Tooltip(
                                      message:
                                          'Выберите экран, на котором вы хотите отобразить статус',
                                      child: TextButton(
                                        child: Text(
                                          'Доска с задачами   $screenName',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        onPressed: () {
                                          selectTaskScreen();
                                        },
                                      ),
                                    ),
                                    const Divider(
                                      color: Color(0xff7876D9),
                                    )
                                  ],
                                ))),
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isDatesearch = false;
                                    searchDate = DateTime.now();
                                    searchvalue = '';
                                    textEditController.clear();
                                  });
                                },
                                child: const Text('очистить фильтры'))),
                        const Spacer(),
                        Expanded(
                            child: NsgButton(
                          width: width * 0.15,
                          icon: Icons.add,
                          text: 'создать заявку',
                          color: Colors.white,
                          backColor: const Color(0xff7876D9),
                          onPressed: () {
                            Get.find<TasksController>()
                                .newItemPageOpen(pageName: Routes.tasksPage);
                            // Get.toNamed(Routes.tasksPage);
                          },
                        ))
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: Tooltip(
                              message:
                                  'Поиск по тексту задачи, Описание задачи',
                              child: TextField(
                                  controller: textEditController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: (() {
                                            setState(() {
                                              textEditController.clear();
                                              searchvalue = '';
                                            });
                                          }),
                                          icon: const Icon(Icons.cancel)),
                                      // prefixIcon: Icon(Icons.search),
                                      hintText: 'Поиск по тексту'),
                                  onChanged: (val) {
                                    searchvalue = val;

                                    taskStatusTableController.sendNotify();
                                  }),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(0),
                            child: Tooltip(
                              message: 'Поиск задач по дате создания',
                              child: NsgPeriodFilter(
                                controller: taskConstroller,
                                label: 'Поиск по дате',

                                // initialTime: DateTime.now(),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                TextButton(
                                  child: const Text('Поиск по исполнителю',
                                      style: TextStyle(color: Colors.black)),
                                  onPressed: () {
                                    selectCreator();
                                  },
                                ),
                                const Divider(
                                  color: Color(0xff7876D9),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.all(1),
                            child: Column(
                              children: [
                                Tooltip(
                                  message:
                                      'Выберите экран, на котором вы хотите отобразить статус',
                                  child: TextButton(
                                    child: Text(
                                      'Доска с задачами   $screenName',
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      selectTaskScreen();
                                    },
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xff7876D9),
                                )
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    isDatesearch = false;
                                    searchDate = DateTime.now();
                                    searchvalue = '';
                                    textEditController.clear();
                                  });
                                },
                                child: const Text('очистить фильтры'))),
                        NsgButton(
                          icon: Icons.add,
                          text: 'создать заявку',
                          color: Colors.white,
                          backColor: const Color(0xff7876D9),
                          onPressed: () {
                            Get.find<TasksController>()
                                .newItemPageOpen(pageName: Routes.tasksPage);
                            // Get.toNamed(Routes.tasksPage);
                          },
                        )
                      ],
                    ),
              //  if (taskBoardController.currentItem.isNotEmpty)
              taskStatusTableController
                  .obx((state) => SingleChildScrollView(child: getStatusList()))

              // Row(children: [
              //   Expanded(
              //       child: Padding(
              //           padding: EdgeInsets.all(10),
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Icon(Icons.travel_explore),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5),
              //                           child: NsgText('Новые'))),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5),
              //                           child: NsgText(taskConstroller.items.length
              //                               .toString()))),
              //                   TextButton(
              //                       child: Row(
              //                         children: [
              //                           Text(
              //                             'по дате',
              //                             style:
              //                                 TextStyle(color: Color(0xff6D6BD6)),
              //                             textAlign: TextAlign.center,
              //                           ),
              //                           Icon(
              //                             Icons.arrow_drop_down,
              //                             color: Color(0xff6D6BD6),
              //                           )
              //                         ],
              //                       ),
              //                       onPressed: () {})
              //                 ],
              //               ),
              //               const Divider(),
              //               Column(
              //                 children: [
              //                   taskConstroller.obx((state) => getTaskList()),
              //                 ],
              //               ),
              //             ],
              //           ))),
              //   Expanded(
              //       child: Padding(
              //           padding: EdgeInsets.all(10),
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Icon(Icons.pause),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5),
              //                           child: NsgText('Приостановлено'))),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5),
              //                           child: NsgText(taskConstroller.items.length
              //                               .toString()))),
              //                   TextButton(
              //                       child: Row(
              //                         children: [
              //                           Text(
              //                             'по дате',
              //                             style:
              //                                 TextStyle(color: Color(0xff6D6BD6)),
              //                             textAlign: TextAlign.center,
              //                           ),
              //                           Icon(
              //                             Icons.arrow_drop_down,
              //                             color: Color(0xff6D6BD6),
              //                           )
              //                         ],
              //                       ),
              //                       onPressed: () {})
              //                 ],
              //               ),
              //               const Divider(),
              //               Column(
              //                 children: [
              //                   taskConstroller.obx((state) => getTaskList()),
              //                 ],
              //               ),
              //             ],
              //           ))),
              //   Expanded(
              //       child: Padding(
              //           padding: EdgeInsets.all(10),
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   Icon(Icons.work_outline_outlined),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5),
              //                           child: NsgText('На будущее'))),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5),
              //                           child: NsgText(taskConstroller.items.length
              //                               .toString()))),
              //                   TextButton(
              //                       child: Row(
              //                         children: [
              //                           Text(
              //                             'по дате',
              //                             style:
              //                                 TextStyle(color: Color(0xff6D6BD6)),
              //                             textAlign: TextAlign.center,
              //                           ),
              //                           Icon(
              //                             Icons.arrow_drop_down,
              //                             color: Color(0xff6D6BD6),
              //                           )
              //                         ],
              //                       ),
              //                       onPressed: () {})
              //                 ],
              //               ),
              //               const Divider(),
              //               Column(
              //                 children: [
              //                   taskConstroller.obx((state) => getTaskList()),
              //                 ],
              //               ),
              //             ],
              //           ))),
              //   Expanded(
              //       child: Padding(
              //           padding: const EdgeInsets.all(10),
              //           child: Column(
              //             children: [
              //               Row(
              //                 children: [
              //                   const Icon(Icons.delete_forever_sharp),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: const EdgeInsets.all(5),
              //                           child: NsgText('К удалению'))),
              //                   Expanded(
              //                       child: Padding(
              //                           padding: EdgeInsets.all(5),
              //                           child: NsgText('20'))),
              //                   TextButton(
              //                       child: Row(
              //                         children: const [
              //                           Text(
              //                             'по дате',
              //                             style:
              //                                 TextStyle(color: Color(0xff6D6BD6)),
              //                             textAlign: TextAlign.center,
              //                           ),
              //                           Icon(
              //                             Icons.arrow_drop_down,
              //                             color: Color(0xff6D6BD6),
              //                           )
              //                         ],
              //                       ),
              //                       onPressed: () {})
              //                 ],
              //               ),
              //               const Divider(),
              //               Column(
              //                 children: [
              //                   taskConstroller.obx((state) => getTaskDeleted()),
              //                 ],
              //               ),
              //             ],
              //           )))
              // ])
            ],
          ),
        ),
      ),
    );
  }

  Widget getStatusList() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<Widget> list = [];

    var statusList = taskStatusTableController.items;

    for (var status in statusList) {
      {
        list.add(Expanded(
          child: Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: NsgText(status.status.toString())),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: taskConstroller.obx((state) =>
                                        searchvalue.isEmpty
                                            ? getTasklength(status.status)
                                            : const Text('')))),
                            TextButton(
                                child: Row(
                                  children: const [
                                    Text(
                                      'по дате',
                                      style:
                                          TextStyle(color: Color(0xff6D6BD6)),
                                      textAlign: TextAlign.center,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff6D6BD6),
                                    )
                                  ],
                                ),
                                onPressed: () {})
                          ],
                        ),
                        const Divider(),
                        wrapdragTarget(
                          status: status,
                          child: Column(
                            children: [
                              taskConstroller.obx(
                                (state) => SingleChildScrollView(
                                    child: SizedBox(
                                        width: width,
                                        height: height * 0.6,
                                        child: getTaskList(status.status))),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ]),
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: list,
      ),
    );
  }

  Widget getTasklength(TaskStatus status) {
    var tasksList = taskConstroller.items;
    var length;
    var taskLength =
        tasksList.where(((element) => element.taskStatus == status));

    length = taskLength.length.toString();

    return Text(length);
  }

  Widget getTaskList(TaskStatus status) {
    List<Widget> list = [];

    var tasksList = taskConstroller.items;

    // var taskstart = tasksList.where((
    //     (element) => element.taskStatus == taskStatuscontroller.items.ETaskstatus.newtask));
    for (var tasks in tasksList) {
      if (tasks.taskStatus != status) continue;

      if (tasks.name
              .toString()
              .toLowerCase()
              .contains(searchvalue.toLowerCase()) ||
          tasks.description
              .toString()
              .toLowerCase()
              .contains(searchvalue.toLowerCase()) ||
          tasks.assignee
              .toString()
              .toLowerCase()
              .contains(searchvalue.toLowerCase()))
      // ignore: curly_braces_in_flow_control_structures
      if (isDatesearch == true) {
        if (searchformat.format(tasks.date) ==
            searchformat.format(searchDate)) {
          list.add(GestureDetector(
            onTap: () {
              //taskConstroller.currentItem = tasks;
              //taskConstroller.currentItem.taskStatus = status;
              tasks.taskStatus = status;
              taskConstroller.itemPageOpen(tasks, Routes.tasksPage,
                  needRefreshSelectedItem: true);
              //Get.toNamed(Routes.tasksPage);
            },
            child: Row(
              children: [
                Expanded(
                  child: Draggable(
                    data: tasks,
                    feedback: SizedBox(
                        height: 98,
                        width: 300,
                        child: Card(
                            color: const Color.fromRGBO(120, 118, 217, 0.12),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.priority_high_rounded,
                                          color: Colors.red,
                                          size: 12,
                                        ),
                                        Expanded(
                                          child: Text(
                                            tasks.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   tasks.description,
                                  //   maxLines: 2,
                                  // ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 12,
                                      ),
                                      Text(
                                        'создано: ${formateddate.format(tasks.date)}',
                                        textScaleFactor: 0.8,
                                        style: const TextStyle(
                                            color: Color(0xff10051C)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))),
                    childWhenDragging: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.pinkAccent,
                      child: const Center(
                        child: Text('Dragging'),
                      ),
                    ),
                    child: SizedBox(
                        height: 98,
                        child: Card(
                            color: const Color.fromARGB(239, 248, 250, 252),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.priority_high_rounded,
                                        color: Colors.red,
                                        size: 12,
                                      ),
                                      Text(
                                        tasks.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    tasks.description,
                                    maxLines: 2,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 12,
                                      ),
                                      Expanded(
                                          child: Text(
                                        'создано: ${formateddate.format(tasks.date)}',
                                        textScaleFactor: 0.8,
                                        style: const TextStyle(
                                            color: Color(0xff10051C)),
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ))),
                  ),
                ),
              ],
            ),
          ));
        }
      } else {
        list.add(GestureDetector(
          onTap: () {
            // taskConstroller.currentItem = tasks;
            // taskConstroller.currentItem.taskStatus = status;
            // Get.toNamed(Routes.tasksPage);
            tasks.taskStatus = status;
            taskConstroller.itemPageOpen(tasks, Routes.tasksPage,
                needRefreshSelectedItem: true);
          },
          child: Row(
            children: [
              Expanded(
                child: Draggable(
                  data: tasks,
                  feedback: SizedBox(
                      height: 98,
                      width: 300,
                      child: Card(
                          color: const Color.fromRGBO(120, 118, 217, 0.12),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.priority_high_rounded,
                                      color: Colors.red,
                                      size: 12,
                                    ),
                                    Text(
                                      tasks.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // Text(
                                //   tasks.description,
                                //   maxLines: 2,
                                // ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      size: 12,
                                    ),
                                    Text(
                                      'создано: ${formateddate.format(tasks.date)}',
                                      textScaleFactor: 0.8,
                                      style: const TextStyle(
                                          color: Color(0xff10051C)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))),
                  childWhenDragging: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.pinkAccent,
                    child: const Center(
                      child: Text('Dragging'),
                    ),
                  ),
                  child: Tooltip(
                    message: 'Drag and drop измените статус задачи',
                    child: SizedBox(
                        height: 98,
                        child: Card(
                            color: const Color.fromARGB(239, 248, 250, 252),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // if(taskConstroller.currentItem.priority==EPriority.high)
                                      //  const Icon(
                                      //   Icons.priority_high_rounded,
                                      //   color: Colors.red,
                                      //   size: 12,
                                      // ),
                                      Expanded(
                                        child: Text(
                                          tasks.name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Text(
                                  //   tasks.description,
                                  //   maxLines: 2,
                                  // ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 12,
                                      ),
                                      Expanded(
                                          child: Text(
                                        'создано: ${formateddate.format(tasks.date)}',
                                        textScaleFactor: 0.8,
                                        style: const TextStyle(
                                            color: Color(0xff10051C)),
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            ))),
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    }
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: list,
      ),
    ));
  }

  Widget wrapdragTarget(
      {required TaskBoardStatusTable status, required Column child}) {
    return DragTarget<TaskDoc>(
      builder: (context, accepted, rejected) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: ControlOptions.instance.colorText.withOpacity(0.1),
                border: Border.all(
                    width: accepted.isNotEmpty ? 10 : 1,
                    color: accepted.isNotEmpty
                        ? Colors.red
                        : const Color.fromRGBO(120, 118, 217, 0.12))),
            child: child);
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        data.taskStatus = status.status;
        taskConstroller.currentItem = data;
        taskConstroller.itemPagePost(goBack: false);
      },
    );
  }

  selectTaskScreen() {
    var form = NsgSelection(
      inputType: NsgInputType.reference,
      controller: Get.find<TaskBoardController>(),
    );
    form.selectFromArray(
      'Доски с задачами',
      (item) {
        var row = TaskBoardGenerated();
        setState(() {
          screenName = taskBoardController.currentItem.name;
          taskConstroller.refreshData();

          taskStatusTableController.sendNotify();

          taskBoardController.sendNotify();
        });
      },
    );
  }

  selectCreator() {
    var form = NsgSelection(
      inputType: NsgInputType.reference,
      controller: Get.find<UserAccountController>(),
    );
    form.selectFromArray(
      'Поиск по исполнителю',
      (item) {
        var row = UserAccountGenerated();
        setState(() {
          searchvalue = userAccountController.currentItem.name;
        });

        taskConstroller.refreshData();

        taskStatusTableController.sendNotify();

        taskBoardController.sendNotify();
      },
    );
  }
}
