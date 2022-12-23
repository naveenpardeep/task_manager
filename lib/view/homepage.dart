import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nsg_controls/formfields/nsg_input.dart';
import 'package:nsg_controls/formfields/nsg_input_type.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_selection.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/enums/e_taskStatus.dart';
import 'package:task_manager_app/model/enums/e_taskStatus.dart';
import 'package:task_manager_app/model/task_board.dart';
import 'package:task_manager_app/model/task_status.dart';

import '../model/enums.dart';
import '../model/generated/project_item.g.dart';
import '../model/generated/task_board.g.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String projectName = '';
  bool isWorkButton = false;
  var taskConstroller = Get.find<TasksController>();
  var projectController = Get.find<ProjectController>();
  var taskBoardController = Get.find<TaskBoardController>();
  var taskStatusTableController = Get.find<TaskStatusTableController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectName;
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    projectName = projectController.currentItem.name;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          actions: [
            Image.asset(
              'lib/assets/images/logo.png',
              height: 70,
            ),
          ],
          backgroundColor: const Color(0xff7876D9),
          flexibleSpace:
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 15, 15),
                child: TextButton(
                  child: Row(
                    children: const [
                      Text(
                        'Проекты',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
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
                          isWorkButton = false;
                          projectName = projectController.currentItem.name;
                        });

                        projectController.sendNotify();
                      },
                    );
                  },
                )),
            const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Все заявки",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Мои задачи",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (projectName.isEmpty)
            //   const Padding(
            //       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //       child: Icon(Icons.arrow_upward)),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  projectName,
                  textScaleFactor: 1.4,
                )),
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('Поиск по тексту'))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('Поиск по дате'))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('Поиск по создателю'))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Column(
                          children: [
                            TextButton(
                              child: Text(
                                'Доска с задачами',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                var form = NsgSelection(
                                  inputType: NsgInputType.reference,
                                  controller: Get.find<TaskBoardController>(),
                                );
                                form.selectFromArray(
                                  'Доски с задачами',
                                  (item) {
                                    var row = TaskBoardGenerated();
                                    // row.name = item as ProjectItem;

                                    setState(() {
                                      // screenName = taskBoardController.currentItem.name;
                                    });

                                    taskBoardController.sendNotify();
                                  },
                                );
                              },
                            ),
                            const Divider(
                              color: Color(0xff7876D9),
                            )
                          ],
                        ))),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text('очистить фильтры'))),
                const Spacer(),
                Expanded(
                    child: NsgButton(
                  width: width * 0.15,
                  icon: Icons.add,
                  text: 'создать заявку',
                  color: Colors.white,
                  backColor: const Color(0xff7876D9),
                  onPressed: () {
                    Get.find<TasksController>().createNewItemAsync();
                    Get.toNamed(Routes.tasksPage);
                  },
                ))
              ],
            ),
            //  if (taskBoardController.currentItem.isNotEmpty)
            taskStatusTableController.obx((state) => SingleChildScrollView(child: Expanded(child: getStatusList())))

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
    );
  }

  Widget getStatusList() {
    double height=MediaQuery.of(context).size.height;
    List<Widget> list = [];

    var statusList = taskStatusTableController.items;

    for (var status in statusList) {
      {
        list.add(Expanded(
          child: Row(children: [
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText(status.status.toString()))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: taskConstroller
                                .obx((state) => getTasklength(status.status)))),
                            TextButton(
                                child: Row(
                                  children: [
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
                       Column(
                                children: [
                                  taskConstroller
                                      .obx((state) => SingleChildScrollView(child: Container(height:height*0.6,child: getTaskList(status.status))),
                       )],
                              ),
                            
                         
                       
                      ],
                    ))),
          ]),
        ));
      }
    }
    return  Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: list,
        ),
      
    );
  }

  Widget getTasklength(TaskStatus status) {
    var tasksList = taskConstroller.items;

    var taskLength =
        tasksList.where(((element) => element.taskStatus == status));

    return Text(taskLength.length.toString());
  }

  Widget getTaskList(TaskStatus status) {
    List<Widget> list = [];
   
    var tasksList = taskConstroller.items;

    // var taskstart = tasksList.where((
    //     (element) => element.taskStatus == taskStatuscontroller.items.ETaskstatus.newtask));
    for (var tasks in tasksList) {
      if (tasks.taskStatus != status) continue;

      // if (tasks.name
      //     .toString()
      //    .toLowerCase()
      //    .contains(searchvalue.toLowerCase()))
      {
        list.add(GestureDetector(
          onTap: () {
            taskConstroller.currentItem = tasks;
            Get.toNamed(Routes.tasksPage);
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                    height: 98,
                    child: Card(
                        color: const Color.fromRGBO(120, 118, 217, 0.12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))),
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
        children:   list,
      ),
    ));
  }

  Widget getTaskDeleted() {
    List<Widget> list = [];
    for (var tasks in taskConstroller.items) {
      // if (tasks.name
      //     .toString()
      //    .toLowerCase()
      //    .contains(searchvalue.toLowerCase()))
      {
        list.add(GestureDetector(
          onTap: () {
            taskConstroller.currentItem = tasks;
            Get.toNamed(Routes.tasksPage);
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                    height: 98,
                    child: Card(
                        color: const Color.fromRGBO(255, 0, 0, 0.12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))),
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
}
