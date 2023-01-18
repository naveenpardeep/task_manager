import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/formfields/nsg_period_filter.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_icon_button.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';
import '../forms/user_account/service_object_controller.dart';
import '../forms/widgets/top_menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String projectName = '';
  bool isDatesearch = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController controller = ScrollController();
  var taskController = Get.find<TasksController>();
  var projectController = Get.find<ProjectController>();
  var taskBoardController = Get.find<TaskBoardController>();
  var taskStatusTableController = Get.find<TaskStatusTableController>();
  var userAccountController = Get.find<UserAccountController>();
  var serviceC = Get.find<ServiceObjectController>();
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
    return BodyWrap(
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (width > 991) const TmTopMenu(),
            Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    NsgIconButton(
                      padding: const EdgeInsets.all(8),
                      icon: Icons.arrow_back_ios_new,
                      backColor: ControlOptions.instance.colorMain,
                      color: ControlOptions.instance.colorMainText,
                      onPressed: () {
                        Get.toNamed(Routes.projectListPage);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        projectName,
                        style: TextStyle(fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                    NsgIconButton(
                      padding: const EdgeInsets.all(8),
                      color: ControlOptions.instance.colorMain,
                      size: 22,
                      icon: Icons.edit,
                      onPressed: () {
                        Get.toNamed(Routes.projectPage);
                      },
                    ),
                    if (width > 991)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: NsgButton(
                            width: 150,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            height: 40,
                            icon: Icons.add,
                            text: 'Новая Задача',
                            color: Colors.white,
                            backColor: const Color(0xff7876D9),
                            onPressed: () {
                              Get.find<TasksController>().newItemPageOpen(pageName: Routes.tasksPage);
                              // Get.toNamed(Routes.tasksPage);
                            },
                          ),
                        ),
                      ),
                  ],
                )),
            width > 991
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: filters(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: NsgButton(
                            margin: EdgeInsets.zero,
                            height: 40,
                            icon: Icons.filter_alt,
                            text: 'Фильтры',
                            color: Colors.white,
                            backColor: const Color(0xff7876D9),
                            onPressed: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: NsgButton(
                            margin: EdgeInsets.zero,
                            height: 40,
                            icon: Icons.add,
                            text: 'Новая Задача',
                            color: Colors.white,
                            backColor: const Color(0xff7876D9),
                            onPressed: () {
                              Get.find<TasksController>().newItemPageOpen(pageName: Routes.tasksPage);
                              // Get.toNamed(Routes.tasksPage);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

            //  if (taskBoardController.currentItem.isNotEmpty)
            Expanded(child: taskStatusTableController.obx((state) => getStatusList())),
            if (width < 992) const TmTopMenu(),
          ],
        ),
      ),
    );
  }

/* ----------------------------------------------------------------- Боковое меню ----------------------------------------------------------------- */
  Widget drawer() {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      //width: width * 0.8,
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(color: ControlOptions.instance.colorMain),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Фильтры',
                          style: TextStyle(
                              color: ControlOptions.instance.colorMainText, fontSize: ControlOptions.instance.sizeH4),
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 6),
                  child: NsgIconButton(
                    icon: Icons.close,
                    size: 20,
                    color: ControlOptions.instance.colorMainText,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: filters(),
              ),
            ),
          )
        ],
      ),
    );
  }

/* ----------------------------------------------------------------- Поля фильтров ---------------------------------------------------------------- */
  List<Widget> filters() {
    double height = MediaQuery.of(context).size.height;
    return [
      Flexible(
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
                taskController.sendNotify();
                taskStatusTableController.sendNotify();
              }),
        ),
      ),
      Flexible(
        child: Tooltip(
          message: 'Поиск задач по дате создания',
          child: NsgPeriodFilter(
            textAlign: TextAlign.left,
            controller: taskController,
            label: 'Поиск по дате',
            // initialTime: DateTime.now(),
          ),
        ),
      ),

      Flexible(
        child: NsgInput(
          label: 'Исполнитель',
          selectionController: userAccountController,
          dataItem: serviceC.currentItem,
          fieldName: ServiceObjectGenerated.nameUserAccountId,
          selectionForm: Routes.userAccountListPage,
          onEditingComplete: (item, field) {
            // setState(() {
            //   searchvalue = serviceC.currentItem.userAccountId;
            // });
            taskController.refreshData();
            taskStatusTableController.sendNotify();
            taskBoardController.sendNotify();
          },
        ),
      ),
      Flexible(
        child: NsgInput(
            label: 'Выбор доски',
            selectionController: taskBoardController,
            dataItem: serviceC.currentItem,
            fieldName: ServiceObjectGenerated.nameBoardId,
            onEditingComplete: (item, field) {
              setState(() {
                //screenName = taskBoardController.currentItem.name;
                screenName = serviceC.currentItem.boardId;
                taskController.refreshData();
                taskStatusTableController.sendNotify();
                taskBoardController.sendNotify();
              });
            }),
      ),
      // Expanded(
      //   child: Padding(
      //       padding: const EdgeInsets.all(0),
      //       child: Column(
      //         children: [
      //           TextButton(
      //             child: const Text('Поиск по исполнителю', style: TextStyle(color: Colors.black)),
      //             onPressed: () {
      //               selectCreator();
      //             },
      //           ),
      //           const Divider(
      //             color: Color(0xff7876D9),
      //           )
      //         ],
      //       )),
      // ),
      // Expanded(
      //     child: NsgInput(
      //   label: 'Доска с задачами',
      //   selectionController: Get.find<ServiceObjectController>(),
      //   dataItem: taskController.currentItem,
      //   fieldName: ServiceObjectGenerated.nameBoardId,
      //   onEditingComplete: (p0, p1) {
      //     setState(() {
      //       screenName = taskBoardController.currentItem.name;
      //       taskController.refreshData();
      //       taskStatusTableController.sendNotify();
      //       taskBoardController.sendNotify();
      //     });
      //   },
      // )),
      // Expanded(
      //   child: Padding(
      //       padding: const EdgeInsets.all(1),
      //       child: Column(
      //         children: [
      //           Tooltip(
      //             message: 'Выберите экран, на котором вы хотите отобразить статус',
      //             child: TextButton(
      //               child: Text(
      //                 'Доска с задачами   $screenName',
      //                 style: const TextStyle(color: Colors.black),
      //               ),
      //               onPressed: () {
      //                 selectTaskScreen();
      //               },
      //             ),
      //           ),
      //           const Divider(
      //             color: Color(0xff7876D9),
      //           )
      //         ],
      //       )),
      // ),
      // Expanded(
      //     child: Padding(
      //         padding: const EdgeInsets.all(0),
      //         child: Column(
      //           children: [
      //             Tooltip(
      //               message: 'Выберите экран, на котором вы хотите отобразить статус',
      //               child: TextButton(
      //                 child: Text(
      //                   'Доска с задачами   $screenName',
      //                   style: const TextStyle(color: Colors.black),
      //                 ),
      //                 onPressed: () {
      //                   selectTaskScreen();
      //                 },
      //               ),
      //             ),
      //             const Divider(
      //               color: Color(0xff7876D9),
      //             )
      //           ],
      //         ))),
      Flexible(
        child: Padding(
            padding: const EdgeInsets.all(0),
            child: taskBoardController.obx((state) => NsgInput(
                  label: 'Сортировка',
                  dataItem: taskBoardController.currentItem,
                  fieldName: TaskBoardGenerated.nameSortBy,
                  onEditingComplete: (task, name) {
                    taskBoardController.sendNotify();
                    taskController.refreshData();
                  },
                ))),
      ),
      SizedBox(
        width: 100,
        height: 40,
        child: NsgButton(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          text: 'Очистить\nФильтры',
          backColor: Colors.transparent,
          color: ControlOptions.instance.colorMain,
          onPressed: () {
            setState(() {
           taskBoardController.currentItem.sortBy=ESorting.dateDesc;
              taskBoardController.sendNotify();
              serviceC.currentItem.userAccountId='';
              isDatesearch = false;
              searchDate = DateTime.now();
              searchvalue = '';
              textEditController.clear();
              taskController.refreshData();
            });
          },
        ),
      ),
    ];
  }

/* ------------------------------------------------------- Вывод колонок ------------------------------------------------------- */
  Widget getStatusList() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Widget> list = [];
    List<String> statuses = [];

    var statusList = taskStatusTableController.items;

    for (var status in statusList) {
      var scrollController = ScrollController();
      statuses.add(status.status.toString());
      if (width > 768) {
        list.add(Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
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
                          child: taskController
                              .obx((state) => searchvalue.isEmpty ? getTasklength(status.status) : const Text(''))),
                    ],
                  ),
                  const Divider(thickness: 2, height: 20),
                  Expanded(
                    child: SizedBox(
                      width: width,
                      child: wrapdragTarget(
                        status: status,
                        child: taskController.obx(
                          (state) => RawScrollbar(
                            thumbVisibility: true,
                            trackVisibility: true,
                            controller: scrollController,
                            thickness: 10,
                            trackBorderColor: ControlOptions.instance.colorGreyLight,
                            trackColor: ControlOptions.instance.colorGreyLight,
                            thumbColor: ControlOptions.instance.colorMain.withOpacity(0.5),
                            radius: const Radius.circular(0),
                            child: SingleChildScrollView(
                                controller: scrollController,
                                child: taskController.obx((state) => getTaskList(status.status))),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
      } else {
        list.add(SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        status.status.toString(),
                        style: TextStyle(fontSize: ControlOptions.instance.sizeL),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: taskController
                              .obx((state) => searchvalue.isEmpty ? getTasklength(status.status) : const Text(''))),
                    ],
                  ),
                  const Divider(thickness: 2, height: 20),
                  SizedBox(
                    width: width * 0.6,
                    height: height * 0.62,
                    child: wrapdragTarget(
                        status: status,
                        child: taskController.obx((state) => RawScrollbar(
                              thumbVisibility: true,
                              trackVisibility: true,
                              controller: scrollController,
                              thickness: 10,
                              trackBorderColor: ControlOptions.instance.colorGreyLight,
                              trackColor: ControlOptions.instance.colorGreyLight,
                              thumbColor: ControlOptions.instance.colorMain.withOpacity(0.5),
                              radius: const Radius.circular(0),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: taskController.obx((state) => getTaskList(status.status)),
                              ),
                            ))),
                  ),
                ],
              )),
        ));
      }
    }

    if (width > 768) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      );
    } else {
      var scrollController = ScrollController();
      return RawScrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          controller: scrollController,
          thickness: 15,
          trackBorderColor: ControlOptions.instance.colorGreyLight,
          trackColor: ControlOptions.instance.colorGreyLight,
          thumbColor: ControlOptions.instance.colorMain.withOpacity(0.5),
          radius: const Radius.circular(0),
          child: ListView(
            controller: scrollController,
            //  shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: list,
          ));
    }
    // else {
    //   return TitleScrollNavigation(
    //     identiferStyle: NavigationIdentiferStyle(
    //         color: ControlOptions.instance.colorMain, width: 2),
    //     barStyle: TitleNavigationBarStyle(
    //       activeColor: ControlOptions.instance.colorMain,
    //       deactiveColor: ControlOptions.instance.colorGrey,
    //       style: TextStyle(fontSize: ControlOptions.instance.sizeL),
    //       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    //       spaceBetween: 20,
    //     ),
    //     titles: statuses,
    //     pages: list,
    //   );
    // }
  }

  Widget getTasklength(TaskStatus status) {
    var tasksList = taskController.items;
    String length = '';
    var taskLength = tasksList.where(((element) => element.taskStatus == status));

    length = taskLength.length.toString();

    return Text(
      length,
      style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.w600),
    );
  }

/* ------------------------------------------------------- Список задач в колонке по статусу ------------------------------------------------------ */
  Widget getTaskList(TaskStatus status) {
    List<Widget> list = [];

    var tasksList = taskController.items;

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
            taskController.itemPageOpen(tasks, Routes.tasksPage, needRefreshSelectedItem: true);
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
        taskController.currentItem = data;
        //taskConstroller.itemPagePost(goBack: false);
        NsgProgressDialog progress = NsgProgressDialog(textDialog: 'Сохранение данных на сервере', canStopped: false);
        progress.show();
        await taskController.postItems([taskController.currentItem]);
        progress.hide();
        taskController.sendNotify();
      },
    );
  }

  // selectTaskScreen() {
  //   var form = NsgSelection(
  //     inputType: NsgInputType.reference,
  //     controller: Get.find<TaskBoardController>(),
  //   );
  //   form.selectFromArray(
  //     'Доски с задачами',
  //     (item) {
  //       setState(() {
  //         screenName = taskBoardController.currentItem.name;
  //         taskController.refreshData();
  //         taskStatusTableController.sendNotify();
  //         taskBoardController.sendNotify();
  //       });
  //     },
  //   );
  // }

  // selectCreator() {
  //   var form = NsgSelection(
  //     inputType: NsgInputType.reference,
  //     controller: Get.find<UserAccountController>(),
  //   );
  //   form.selectFromArray(
  //     'Поиск по исполнителю',
  //     (item) {
  //       setState(() {
  //         searchvalue = userAccountController.currentItem.name;
  //       });
  //       taskController.refreshData();
  //       taskStatusTableController.sendNotify();
  //       taskBoardController.sendNotify();
  //     },
  //   );
  // }

  // sortTask() {
  //   var form = NsgSelection(
  //     inputType: NsgInputType.reference,
  //     controller: Get.find<TasksController>(),
  //   );
  //   form.selectFromArray(
  //     'Сортировка',
  //     (item) {
  //       setState(() {});

  //       taskController.refreshData();

  //       taskStatusTableController.sendNotify();

  //       taskBoardController.sendNotify();
  //     },
  //   );
  // }
}

/* ------------------------------------------------------- Главный виджет карточки с задачей ------------------------------------------------------ */
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

/* --------------------------------------- Дочерний виджет поворачивающейся при движении карточки с задачей --------------------------------------- */
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

/* -------------------------------------------------------------- Карточка с задачей -------------------------------------------------------------- */
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
