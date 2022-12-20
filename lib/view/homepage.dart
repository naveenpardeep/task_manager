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
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/enums/e_taskStatus.dart';
import 'package:task_manager_app/model/enums/e_taskStatus.dart';

import '../model/enums.dart';
import '../model/generated/project_item.g.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String projectName = '';
  bool isWorkButton=false;
  var taskConstroller = Get.find<TasksController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectName;
  }

  var projectController = Get.find<ProjectController>();
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(10),
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
                          isWorkButton=false;
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
                Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  child: 
                      Text(
                        'В работе',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                     
                     
                  ),
                  onPressed: () {
                    setState(() {
                      isWorkButton=true;
                    });
                  })),
            const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Мои задачи",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ])),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (projectName.isEmpty)
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Icon(Icons.arrow_upward)),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                projectName.isEmpty ? 'Select Project' : projectName,
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
           isWorkButton==false?
          Row(children: 
         [
            
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.travel_explore),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText('Новые'))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText(taskConstroller.items.length.toString()))),
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
                            taskConstroller.obx((state) => getTaskList()),
                          ],
                        ),
                      ],
                    ))),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.pause),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText('Приостановлено'))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText(taskConstroller.items.length.toString()))),
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
                            taskConstroller.obx((state) => getTaskList()),
                          ],
                        ),
                      ],
                    ))),
                    Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.work_outline_outlined),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText('На будущее'))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText(taskConstroller.items.length.toString()))),
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
                            taskConstroller.obx((state) => getTaskList()),
                          ],
                        ),
                      ],
                    ))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.delete_forever_sharp),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: NsgText('К удалению'))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText('20'))),
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
                        Column(
                          children: [
                            taskConstroller.obx((state) => getTaskDeleted()),
                          ],
                        ),
                      ],
                    )))
          
         ])
          
          :
          //isWorkbutton true
Row(children: 
         [
            
          Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.hourglass_top),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText('В работе'))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText(taskConstroller.items.length.toString()))),
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
                            taskConstroller.obx((state) => getTaskList()),
                          ],
                        ),
                      ],
                    ))),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.manage_search),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText('На проверке'))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText(taskConstroller.items.length.toString()))),
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
                            taskConstroller.obx((state) => getTaskList()),
                          ],
                        ),
                      ],
                    ))),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.done),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: NsgText('Выполнено '))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: NsgText('20'))),
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
                        Column(
                          children: [
                            taskConstroller.obx((state) => getTaskDeleted()),
                          ],
                        ),
                      ],
                    ))),
          
          
          
          
          
          
          
          
          ])
        ],
      ),
    );
  }

  Widget getTaskList() {
    List<Widget> list = [];
    var taskStatuscontroller = Get.find<TaskStatusController>();
    var tasksList = taskConstroller.items;

   // var taskstart = tasksList.where((
   //     (element) => element.taskStatus == taskStatuscontroller.items.ETaskstatus.newtask));
    for (var tasks in tasksList) {
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
        children: list,
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
