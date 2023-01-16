import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/formfields/nsg_period_filter.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_expansion_panel.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';

import '../forms/widgets/top_menu.dart';

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
  final ScrollController controller = ScrollController();
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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (width > 991) const TmTopMenu(),

          Padding(
              padding: const EdgeInsets.all(10),
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
          width > 991
              ? Row(
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Tooltip(
                              message: 'Поиск по тексту задачи, Описание задачи',
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
                                  child: const Text('Поиск по исполнителю', style: TextStyle(color: Colors.black)),
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
                                  message: 'Выберите экран, на котором вы хотите отобразить статус',
                                  child: TextButton(
                                    child: Text(
                                      'Доска с задачами   $screenName',
                                      style: const TextStyle(color: Colors.black),
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
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: taskBoardController.obx((state) => NsgInput(
                                  label: 'Сортировка',
                                  dataItem: taskBoardController.currentItem,
                                  fieldName: TaskBoardGenerated.nameSortBy,
                                  onEditingComplete: (task, name) {
                                    taskBoardController.sendNotify();
                                    taskConstroller.refreshData();
                                  },
                                )))),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                isDatesearch = false;
                                searchDate = DateTime.now();
                                searchvalue = '';
                                textEditController.clear();
                                taskConstroller.sendNotify();
                                taskBoardController.sendNotify();
                              });
                            },
                            child: const Text('сбросить\nфильтры'))),
                    Expanded(
                        child: NsgButton(
                      height: 40,
                      width: 150,
                      icon: Icons.add,
                      text: 'Новая Заявка',
                      color: Colors.white,
                      backColor: const Color(0xff7876D9),
                      onPressed: () {
                        Get.find<TasksController>().newItemPageOpen(pageName: Routes.tasksPage);
                        // Get.toNamed(Routes.tasksPage);
                      },
                    ))
                  ],
                )
              : Column(
                  children: [
                    NsgButton(
                      height: 40,
                      width: 150,
                      icon: Icons.add,
                      text: 'Новая Заявка',
                      color: Colors.white,
                      backColor: const Color(0xff7876D9),
                      onPressed: () {
                        Get.find<TasksController>().newItemPageOpen(pageName: Routes.tasksPage);
                        // Get.toNamed(Routes.tasksPage);
                      },
                    ),
                    NsgExpansionPanel(
                        widgetTop: const Text('Фильтры'),
                        widgetTopBackColor: ControlOptions.instance.colorMainText,
                        widgetBottom: SizedBox(
                          child: Column(children: [
                            Padding(
                                padding: const EdgeInsets.all(15),
                                child: Tooltip(
                                  message: 'Поиск по тексту задачи, Описание задачи',
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
                                      child: const Text('Поиск по исполнителю', style: TextStyle(color: Colors.black)),
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
                                      message: 'Выберите экран, на котором вы хотите отобразить статус',
                                      child: TextButton(
                                        child: Text(
                                          'Доска с задачами   $screenName',
                                          style: const TextStyle(color: Colors.black),
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
                                padding: const EdgeInsets.all(1),
                                child: taskBoardController.obx((state) => NsgInput(
                                      label: 'Сортировка',
                                      dataItem: taskBoardController.currentItem,
                                      fieldName: TaskBoardGenerated.nameSortBy,
                                      onEditingComplete: (task, name) {
                                        taskBoardController.sendNotify();
                                        taskConstroller.refreshData();
                                      },
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
                          ]),
                        )),
                  ],
                ),
          //  if (taskBoardController.currentItem.isNotEmpty)
          Expanded(child: taskStatusTableController.obx((state) => getStatusList())),
          if (width < 992) const TmTopMenu(),
        ],
      ),
    );
  }

  Widget getStatusList() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<Widget> list = [];
    List<String> statuses = [];

    var statusList = taskStatusTableController.items;

    for (var status in statusList) {
      var scrollController = ScrollController();
      statuses.add(status.status.toString());
      list.add(Expanded(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      status.status.toString(),
                      style: TextStyle(fontSize: ControlOptions.instance.sizeL),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: taskConstroller
                            .obx((state) => searchvalue.isEmpty ? getTasklength(status.status) : const Text(''))),
                  ],
                ),
                const Divider(thickness: 2, height: 20),
                Expanded(
                  child: wrapdragTarget(
                    status: status,
                    child: taskConstroller.obx(
                      (state) => RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: scrollController,
                        thickness: 8,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.5),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(controller: scrollController, child: getTaskList(status.status)),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ));
    }

    if (width > 700) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      );
    } else {
      return TitleScrollNavigation(
        identiferStyle: NavigationIdentiferStyle(color: ControlOptions.instance.colorMain, width: 2),
        barStyle: TitleNavigationBarStyle(
          activeColor: ControlOptions.instance.colorMain,
          deactiveColor: ControlOptions.instance.colorGrey,
          style: TextStyle(fontSize: ControlOptions.instance.sizeL),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          spaceBetween: 20,
        ),
        titles: statuses,
        pages: list,
      );
    }
  }

  Widget getTasklength(TaskStatus status) {
    var tasksList = taskConstroller.items;
    var length;
    var taskLength = tasksList.where(((element) => element.taskStatus == status));

    length = taskLength.length.toString();

    return Text(
      length,
      style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.w600),
    );
  }

  Widget getTaskList(TaskStatus status) {
    List<Widget> list = [];

    var tasksList = taskConstroller.items;
    var projectPrefix = projectController.items;

    // var taskstart = tasksList.where((
    //     (element) => element.taskStatus == taskStatuscontroller.items.ETaskstatus.newtask));

    for (var tasks in tasksList) {
      if (tasks.taskStatus != status) continue;

      if (tasks.name.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          tasks.description.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          tasks.assignee.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        list.add(GestureDetector(
          onTap: () {
            // taskConstroller.currentItem = tasks;
            // taskConstroller.currentItem.taskStatus = status;
            // Get.toNamed(Routes.tasksPage);
            tasks.taskStatus = status;
            taskConstroller.itemPageOpen(tasks, Routes.tasksPage, needRefreshSelectedItem: true);
          },
          child: Row(
            children: [
              Expanded(
                child: LayoutBuilder(builder: (context, constraints) {
                  return DraggableRotatingCard(
                    tasks: tasks,
                    constraints: constraints,
                  );
                }),
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

  Widget wrapdragTarget({required TaskBoardStatusTable status, required Widget child}) {
    return DragTarget<TaskDoc>(
      builder: (context, accepted, rejected) {
        return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: accepted.isNotEmpty
                  ? ControlOptions.instance.colorMain.withOpacity(0.4)
                  : ControlOptions.instance.colorMain.withOpacity(0.1),
            ),
            child: child);
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) async {
        data.taskStatus = status.status;
        taskConstroller.currentItem = data;
        //taskConstroller.itemPagePost(goBack: false);
        NsgProgressDialog progress = NsgProgressDialog(textDialog: 'Сохранение данных на сервере', canStopped: false);
        progress.show();
        await taskConstroller.postItems([taskConstroller.currentItem]);
        progress.hide();
        taskConstroller.sendNotify();
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

  sortTask() {
    var form = NsgSelection(
      inputType: NsgInputType.reference,
      controller: Get.find<TasksController>(),
    );
    form.selectFromArray(
      'Сортировка',
      (item) {
        var row = ESorting;
        setState(() {});

        taskConstroller.refreshData();

        taskStatusTableController.sendNotify();

        taskBoardController.sendNotify();
      },
    );
  }
}

class DraggableRotatingCard extends StatefulWidget {
  final TaskDoc tasks;
  final BoxConstraints constraints;
  const DraggableRotatingCard({super.key, required this.tasks, required this.constraints});

  @override
  State<DraggableRotatingCard> createState() => DraggableRotatingCardState();
}

class DraggableRotatingCardState extends State<DraggableRotatingCard> {
  final dataKey = GlobalKey<RotatingCardState>();
  double angle = 0;
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.tasks,
      onDragUpdate: (details) {
        angle = details.delta.dx / 200;
        if ((angle).abs() < .03) {
          angle = 0;
        }
        if (dataKey.currentState != null) dataKey.currentState!.setAngle(angle);
      },
      feedback: RotatingCard(key: dataKey, tasks: widget.tasks, constraints: widget.constraints),
      childWhenDragging: Opacity(opacity: 0.2, child: taskCard(widget.tasks, widget.constraints)),
      child: taskCard(widget.tasks, widget.constraints),
    );
  }
}

class RotatingCard extends StatefulWidget {
  final TaskDoc tasks;
  final BoxConstraints constraints;

  const RotatingCard({Key? key, required this.tasks, required this.constraints}) : super(key: key);

  @override
  State<RotatingCard> createState() => RotatingCardState();
}

class RotatingCardState extends State<RotatingCard> {
  double curAngle = 0;
  void setAngle(double angle) {
    curAngle = angle;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
      turns: curAngle,
      child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 10, color: ControlOptions.instance.colorGrey.withOpacity(0.7))]),
          child: taskCard(widget.tasks, widget.constraints)),
    );
  }
}

Widget taskCard(TaskDoc tasks, BoxConstraints constraints) {
  return SizedBox(
    width: constraints.maxWidth,
    child: Card(
        color: const Color.fromARGB(239, 248, 250, 252),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  tasks.docNumber,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        tasks.name,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Icon(Icons.access_time,
                        size: ControlOptions.instance.sizeS, color: ControlOptions.instance.colorGreyDark),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      'создано: ${{NsgDateFormat.dateFormat(tasks.date, format: 'dd.MM.yy HH:mm')}}',
                      maxLines: 1,
                      textScaleFactor: 0.8,
                      style: TextStyle(
                        color: ControlOptions.instance.colorGreyDark,
                        fontSize: ControlOptions.instance.sizeS,
                      ),
                    ),
                  ),
                  Text(
                    //   'Обновлено: ${{
                    // NsgDateFormat.dateFormat(tasks.dateUpdated,
                    //     format: 'dd.MM.yy HH:mm')
                    //   }}',
                    "(${getupdateDay(tasks)})",
                    maxLines: 1,
                    textScaleFactor: 0.8,
                    style: TextStyle(
                      color: ControlOptions.instance.colorGreyDark,
                      fontSize: ControlOptions.instance.sizeS,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
  );
}

String getupdateDay(TaskDoc tasks) {
  var todayDate = DateTime.now();
  final lastDate = tasks.dateUpdated;
  var daysleft = todayDate.difference(lastDate).inDays;
  if (daysleft > 7) {
    return 'Обновлено: ${{NsgDateFormat.dateFormat(tasks.dateUpdated, format: 'dd.MM.yy HH:mm')}}';
  }
  var minutes = todayDate.difference(lastDate).inMinutes;
  if (minutes < 60) {
    return 'Обновлено: $minutes мин. назад';
  }
  var hours = todayDate.difference(lastDate).inHours;
  if (hours <= 24) {
    return 'Обновлено: $hours Час. назад';
  }

  if (daysleft <= 7) {
    return 'Обновлено: $daysleft дн. назад';
  }

  return '$daysleft дн. назад';
}
