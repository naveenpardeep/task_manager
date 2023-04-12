import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_icon_button.dart';
import 'package:nsg_controls/widgets/nsg_circle.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/taskCopyMoveController.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';
import 'package:task_manager_app/view/taskview.dart';
import '../forms/tasks/task_file_controller.dart';
import '../forms/user_account/service_object_controller.dart';
import '../forms/widgets/nsg_tabs.dart';
import '../forms/widgets/task_tuner_button.dart';
import '../forms/widgets/top_menu.dart';
import '../forms/widgets/tt_nsg_input.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String projectName = '';
  bool isDatesearch = false;
  bool taskView = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final ScrollController controller = ScrollController();
  var taskController = Get.find<TasksController>();
  var projectController = Get.find<ProjectController>();
  var taskBoardController = Get.find<TaskBoardController>();
  var taskStatusTableController = Get.find<TaskStatusTableController>();
  var userAccountController = Get.find<UserAccountController>();
  var taskcommentC = Get.find<TaskCommentsController>();
  var serviceC = Get.find<ServiceObjectController>();
  var textEditController = TextEditingController();
  var taskCopyMoveController = Get.find<TaskCopyMoveController>();
  String screenName = '';
  String searchvalue = '';
  DateTime searchDate = DateTime.now();
  DateFormat searchformat = DateFormat("dd-MM-yyyy");

  DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
  @override
  void initState() {
    super.initState();
    if (taskcommentC.lateInit) {
      taskcommentC.requestItems();
    }
    if (taskCopyMoveController.lateInit) {
      taskCopyMoveController.requestItems();
    }
    reset();
    taskView;
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
    var scrollController = ScrollController();
    // screenName=taskBoardController.currentItem.name;
    double width = MediaQuery.of(context).size.width;
    return projectController.obx(
      (state) => BodyWrap(
        child: Scaffold(
          key: scaffoldKey,
          drawer: drawer(),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (width > 700) const TmTopMenu(),
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      // NsgIconButton(
                      //   padding: EdgeInsets.zero,
                      //   icon: Icons.arrow_back_ios_new,
                      //   backColor: Colors.transparent,
                      //   color: ControlOptions.instance.colorMain,
                      //   size: 22,
                      //   onPressed: () {
                      //     serviceC.selectedItem = null;
                      //     Get.toNamed(Routes.projectListPage);
                      //   },
                      // ),
                      projectController.obx(
                        (state) => Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            projectController.currentItem.name,
                            style: TextStyle(fontSize: ControlOptions.instance.sizeXL),
                          ),
                        ),
                      ),
                      if (Get.find<DataController>().currentUser == projectController.currentItem.leader ||
                          Get.find<DataController>().currentUser == projectController.currentItem.leader.mainUserAccount ||
                          Get.find<DataController>().currentUser == projectController.currentItem.organization.ceo ||
                          Get.find<DataController>().currentUser == projectController.currentItem.organization.ceo.mainUserAccount ||
                          Get.find<DataController>().currentUser ==
                              projectController.currentItem.organization.tableUsers.rows
                                  .firstWhere(
                                    (element) => element.isAdmin == true,
                                    orElse: () => OrganizationItemUserTable(),
                                  )
                                  .userAccount ||
                          Get.find<DataController>().currentUser.mainUserAccount ==
                              projectController.currentItem.organization.tableUsers.rows
                                  .firstWhere(
                                    (element) => element.isAdmin == true,
                                    orElse: () => OrganizationItemUserTable(),
                                  )
                                  .userAccount ||
                          Get.find<DataController>().currentUser.mainUserAccount ==
                              projectController.currentItem.tableUsers.rows
                                  .firstWhere(
                                    (element) => element.isAdmin == true,
                                    orElse: () => ProjectItemUserTable(),
                                  )
                                  .userAccount ||
                          Get.find<DataController>().currentUser ==
                              projectController.currentItem.tableUsers.rows
                                  .firstWhere(
                                    (element) => element.isAdmin == true,
                                    orElse: () => ProjectItemUserTable(),
                                  )
                                  .userAccount)
                        NsgIconButton(
                          padding: const EdgeInsets.all(8),
                          color: ControlOptions.instance.colorMain,
                          size: 22,
                          icon: Icons.edit,
                          onPressed: () {
                            //   if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
                            //    projectController.itemPageOpen(projectController.currentItem, Routes.projectSettingsPage);
                            //  } else {
                            projectController.itemPageOpen(projectController.currentItem, Routes.projectMobilePageview);
                            //  }
                            //  Get.toNamed(Routes.projectPage);
                            //  Get.find<ProjectController>().itemPageOpen(projectController.currentItem, Routes.projectSettingsPage);
                          },
                        ),
                      IconButton(
                          onPressed: () {
                            Get.find<TasksController>().refreshData();
                            setState(() {
                              taskView = false;
                            });
                          },
                          icon: const Icon(Icons.refresh)),

                      if (width > 700)
                        Flexible(
                          child: SizedBox(
                            height: 30,
                            child: TextField(
                                controller: textEditController,
                                decoration: InputDecoration(
                                    filled: false,
                                    fillColor: ControlOptions.instance.colorMainLight,
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                        gapPadding: 1,
                                        borderSide: BorderSide(color: ControlOptions.instance.colorMainDark),
                                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                                    suffixIcon: IconButton(
                                        padding: const EdgeInsets.only(bottom: 0),
                                        onPressed: (() {
                                          setState(() {
                                            textEditController.clear();
                                            searchvalue = '';
                                          });
                                        }),
                                        icon: const Icon(Icons.cancel)),
                                    // prefixIcon: Icon(Icons.search),
                                    hintText: 'Поиск по задачам'),
                                textAlignVertical: TextAlignVertical.bottom,
                                style: TextStyle(color: ControlOptions.instance.colorMainLight),
                                onChanged: (val) {
                                  searchvalue = val;
                                  taskController.sendNotify();
                                  taskStatusTableController.sendNotify();
                                }),
                          ),
                        ),
                      if (width > 700)
                        NsgButton(
                            height: 10,
                            borderRadius: 20,
                            width: 100,
                            onPressed: () {
                              serviceC.currentItem.userAccount = Get.find<DataController>().currentUser;

                              Get.find<TasksController>().refreshData();
                            },
                            text: 'My Tasks'),
                      //  if (width > 700)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: NsgButton(
                            width: width > 700 ? 150 : 35,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            height: 10,
                            icon: Icons.add,
                            text: width > 700 ? 'Новая Задача' : '',
                            color: width > 700 ? Colors.white : ControlOptions.instance.colorMain,
                            backColor: width > 700 ? ControlOptions.instance.colorMain : Colors.transparent,
                            onPressed: () {
                              Get.find<TasksController>().selectedItem == null;
                              //  Get.find<TasksController>().createNewItemAsync();
                              Get.find<TasksController>().newItemPageOpen(pageName: Routes.newTaskPage);

                              // Get.find<TasksController>()
                              //     .newItemPageOpen(pageName: Routes.tasksPage);
                              //  Get.toNamed(Routes.newTaskPage);
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              width > 700
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: filters(width: width),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: TextField(
                                  controller: textEditController,
                                  decoration: InputDecoration(
                                      filled: false,
                                      fillColor: ControlOptions.instance.colorMainLight,
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                          gapPadding: 1,
                                          borderSide: BorderSide(color: ControlOptions.instance.colorMainDark),
                                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                                      suffixIcon: IconButton(
                                          padding: const EdgeInsets.only(bottom: 0),
                                          onPressed: (() {
                                            setState(() {
                                              textEditController.clear();
                                              searchvalue = '';
                                            });
                                          }),
                                          icon: const Icon(Icons.cancel)),
                                      // prefixIcon: Icon(Icons.search),
                                      hintText: 'Поиск по задачам'),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: TextStyle(color: ControlOptions.instance.colorMainLight),
                                  onChanged: (val) {
                                    searchvalue = val;
                                    taskController.sendNotify();
                                    taskStatusTableController.sendNotify();
                                  }),
                            ),
                          ),
                          TaskIconButton(
                            nott: 0,
                            style: TaskButtonStyle.light,
                            icon: Icons.filter_alt_outlined,
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                          // const SizedBox(width: 10),
                          // Expanded(
                          //   child: NsgButton(
                          //     margin: EdgeInsets.zero,
                          //   //  height: 30,
                          //     icon: Icons.add,
                          //     text: 'Новая Задача',
                          //     color: Colors.white,
                          //     backColor: ControlOptions.instance.colorMain,
                          //     onPressed: () {
                          //       //   var images = <NsgFilePickerObject>[].clear();
                          //       // Get.find<TasksController>()
                          //       //     .newItemPageOpen(pageName: Routes.tasksPage);
                          //       Get.find<TasksController>().newItemPageOpen(pageName: Routes.newTaskPage);
                          //       //  Get.toNamed(Routes.tasksPage);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),

              //  if (taskBoardController.currentItem.isNotEmpty)
              Expanded(
                child: Stack(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisSize: MainAxisSize.min,
                  children: [
                    if (taskView)
                      RawScrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          controller: scrollController,
                          thickness: 15,
                          trackBorderColor: ControlOptions.instance.colorMain,
                          trackColor: ControlOptions.instance.colorMain,
                          mainAxisMargin: 5,
                          crossAxisMargin: 2,
                          thumbColor: ControlOptions.instance.colorGrey,
                          radius: const Radius.circular(50),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
                              child: SizedBox(
                                width: width + 450,
                                child: taskStatusTableController.obx((state) => getStatusListForTaskView()),
                              ))),
                    if (taskView == false) Container(child: taskStatusTableController.obx((state) => getStatusList())),
                    if (taskView == true)
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 388,
                          child: taskController.obx((state) => Container(key: GlobalKey(), child: const TaskViewPage())),
                        ),
                      ),
                    if (taskView)
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                taskView = false;
                              });
                            },
                            icon: const Icon(Icons.close)),
                      )
                  ],
                ),
              ),

              if (width < 700) const BottomMenu(),
            ],
          ),
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
                          style: TextStyle(color: ControlOptions.instance.colorMainText, fontSize: ControlOptions.instance.sizeH4),
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
                children: filters(width: width),
              ),
            ),
          )
        ],
      ),
    );
  }

/* ----------------------------------------------------------------- Поля фильтров ---------------------------------------------------------------- */
  List<Widget> filters({required double width}) {
    Widget wrapFlexible({required Widget child}) {
      if (width > 700) {
        return Flexible(child: child);
      } else {
        return child;
      }
    }

    return [
      // if (width > 700)
      //   wrapFlexible(
      //     child: Tooltip(
      //       message: 'Поиск по тексту задачи, Описание задачи',
      //       child: SizedBox(
      //         height: 37,
      //         child: TextField(
      //             controller: textEditController,
      //             decoration: InputDecoration(
      //                 filled: false,
      //                 fillColor: ControlOptions.instance.colorMainLight,
      //                 border: OutlineInputBorder(
      //                     gapPadding: 1,
      //                     borderSide: BorderSide(color: ControlOptions.instance.colorMainDark),
      //                     borderRadius: const BorderRadius.all(Radius.circular(10))),
      //                 suffixIcon: IconButton(
      //                     onPressed: (() {
      //                       setState(() {
      //                         textEditController.clear();
      //                         searchvalue = '';
      //                       });
      //                     }),
      //                     icon: const Icon(Icons.cancel)),
      //                 // prefixIcon: Icon(Icons.search),
      //                 hintText: 'Поиск по тексту'),
      //             onChanged: (val) {
      //               searchvalue = val;
      //               taskController.sendNotify();
      //               taskStatusTableController.sendNotify();
      //             }),
      //       ),
      //     ),
      //   ),
      // wrapFlexible(
      //   child: Tooltip(
      //     message: 'Поиск задач по дате создания',
      //     child: NsgPeriodFilter(
      //       textAlign: TextAlign.left,
      //       controller: taskController,
      //       label: 'Поиск по дате',
      //       // initialTime: DateTime.now(),
      //     ),
      //   ),
      // ),
      if (width < 700)
        wrapFlexible(
            child: NsgButton(
                height: 10,
                borderRadius: 20,
                width: 100,
                onPressed: () {
                  serviceC.currentItem.userAccount = Get.find<DataController>().currentUser;

                  Get.find<TasksController>().refreshData();
                },
                text: 'My Tasks')),
      wrapFlexible(
        child: TTNsgInput(
          label: 'Исполнитель',
          infoString: 'Выберите исполнителя',
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
      wrapFlexible(
        child: TTNsgInput(
            label: 'Выбор доски',
            infoString: 'Выберите доску',
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
      wrapFlexible(
        child: taskBoardController.obx((state) => TTNsgInput(
              label: 'Сортировка',
              dataItem: taskBoardController.currentItem,
              fieldName: TaskBoardGenerated.nameSortBy,
              onEditingComplete: (task, name) {
                taskBoardController.sendNotify();
                taskController.refreshData();
              },
            )),
      ),
      wrapFlexible(
        child: taskBoardController.obx((state) => TTNsgInput(
              label: 'Finished Tasks Period',
              dataItem: taskBoardController.currentItem,
              fieldName: TaskBoardGenerated.namePeriodOfFinishedTasks,
              onEditingComplete: (task, name) {
                taskBoardController.sendNotify();
                taskController.refreshData();
              },
            )),
      ),
      SizedBox(
        height: 40,
        width: 150,
        child: NsgButton(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          text: 'Очистить Фильтры',
          backColor: Colors.transparent,
          color: ControlOptions.instance.colorMain,
          onPressed: () {
            reset();
          },
        ),
      )
    ];
  }
// for taskView

  Widget getStatusListForTaskView() {
    double width = MediaQuery.of(context).size.width;

    List<Widget> list = [];
    List<NsgTabsTab> tabsList = [];
    List<String> statuses = [];

    // var statusList = taskStatusTableController.items.reversed;
    var statusList = taskStatusTableController.items;
    for (var status in statusList) {
      var scrollController = ScrollController();
      statuses.add(status.status.toString());
      if (width > 1050) {
        list.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    // changeStatus(status);
                    // Get.toNamed(Routes.taskrow);
                    // taskStatusTableController.itemPageOpen(status, Routes.taskrow);
                  },
                  child: Text(
                    status.status.toString(),
                    style: TextStyle(
                      fontSize: ControlOptions.instance.sizeL,
                      color: status.status.isDone ? Colors.green : Colors.black,
                    ),
                  ),
                ),
                taskController.obx((state) => searchvalue.isEmpty ? getTasklength(status.status) : const Text('')),
                Expanded(
                  child: SizedBox(
                    width: taskStatusTableController.items.length > 4 ? 250 : 300,
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
                          thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                          radius: const Radius.circular(0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              controller: scrollController,
                              child: taskController.obx((state) => getTaskListForTaskview(status.status))),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
      } else {
        tabsList.add(NsgTabsTab(
            tab: taskController.obx(
              (state) => Container(
                decoration:
                    BoxDecoration(border: Border.all(width: 2, color: Colors.transparent), borderRadius: BorderRadius.circular(3), color: Colors.transparent),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      status.status.name,
                      style: TextStyle(
                        fontSize: ControlOptions.instance.sizeL,
                        color: status.status.isDone ? Colors.green : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: getTasklength(status.status),
                    ),
                  ],
                ),
              ),
            ),
            tabSelected: taskController.obx(
              (state) => Container(
                decoration: BoxDecoration(border: Border.all(width: 2, color: ControlOptions.instance.colorMain), borderRadius: BorderRadius.circular(3)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      status.status.name,
                      style: TextStyle(fontSize: ControlOptions.instance.sizeL, color: status.status.isDone ? Colors.green : Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: getTasklengthForTaskview(status.status),
                    ),
                  ],
                ),
              ),
            ),
            child: Column(
              children: [taskController.obx((state) => getTaskListForTaskview(status.status))],
            )));
      }
    }

    if (width > 1050) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      );
    } else {
      return NsgTabs(tabs: tabsList);
    }
  }

  Widget getTasklengthForTaskview(TaskStatus status) {
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
  Widget getTaskListForTaskview(TaskStatus status) {
    List<Widget> list = [];

    var tasksList = taskController.items;
    for (var tasks in tasksList) {
      if (tasks.taskStatus != status) continue;

      if (tasks.name.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          tasks.description.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
          tasks.assignee.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
        list.add(GestureDetector(
          onTap: () {
            if (kIsWeb || (Platform.isWindows || Platform.isLinux)) {
              setState(() {
                Get.find<TaskFilesController>().requestItems();
                Get.find<TaskCheckListController>().requestItems();
                taskController
                    .setAndRefreshSelectedItem(tasks, [TaskDocGenerated.nameCheckList, TaskDocGenerated.nameTableComments, TaskDocGenerated.nameFiles]);

                taskView = true;
              });
            } else {
              taskController.currentItem = tasks;

              taskController.itemPageOpen(tasks, Routes.newTaskPage, needRefreshSelectedItem: true);
            }
            if (tasks.isReadByAssignee == false &&
                (Get.find<DataController>().currentUser == tasks.assignee || Get.find<DataController>().currentUser == tasks.assignee.mainUserAccount)) {
              tasks.isReadByAssignee = true;
              Get.find<TasksController>().postItems([tasks]);
            }
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: list,
          ),
        ));
  }

/* ------------------------------------------------------- Вывод колонок по статусу ------------------------------------------------------- */
  Widget getStatusList() {
    double width = MediaQuery.of(context).size.width;

    List<Widget> list = [];
    List<NsgTabsTab> tabsList = [];
    List<String> statuses = [];

    // var statusList = taskStatusTableController.items.reversed;
    var statusList = taskStatusTableController.items;
    for (var status in statusList) {
      var scrollController = ScrollController();
      statuses.add(status.status.toString());
      if (width > 1050) {
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
                      InkWell(
                        onTap: () {
                          // changeStatus(status);
                          // Get.toNamed(Routes.taskrow);
                          // taskStatusTableController.itemPageOpen(status, Routes.taskrow);
                        },
                        child: Text(
                          status.status.toString(),
                          style: TextStyle(color: status.status.isDone ? Colors.green : Colors.black, fontSize: ControlOptions.instance.sizeL),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: taskController.obx((state) => searchvalue.isEmpty ? getTasklength(status.status) : const Text(''))),
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
                            thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                            radius: const Radius.circular(0),
                            child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
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
        tabsList.add(NsgTabsTab(
            tab: taskController.obx(
              (state) => Container(
                decoration:
                    BoxDecoration(border: Border.all(width: 2, color: Colors.transparent), borderRadius: BorderRadius.circular(3), color: Colors.transparent),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      status.status.name,
                      style: TextStyle(
                        fontSize: ControlOptions.instance.sizeL,
                        color: status.status.isDone ? Colors.green : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: getTasklength(status.status),
                    ),
                  ],
                ),
              ),
            ),
            tabSelected: taskController.obx(
              (state) => Container(
                decoration: BoxDecoration(border: Border.all(width: 2, color: ControlOptions.instance.colorMain), borderRadius: BorderRadius.circular(3)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      status.status.name,
                      style: TextStyle(
                        fontSize: ControlOptions.instance.sizeL,
                        color: status.status.isDone ? Colors.green : Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: getTasklength(status.status),
                    ),
                  ],
                ),
              ),
            ),
            child: Column(
              children: [taskController.obx((state) => getTaskList(status.status))],
            )));
      }
    }

    if (width > 1050) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      );
    } else {
      return NsgTabs(tabs: tabsList);
    }
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
            if (kIsWeb || (Platform.isWindows || Platform.isLinux)) {
              setState(() {
                Get.find<TaskFilesController>().requestItems();
                Get.find<TaskCheckListController>().requestItems();
                taskController
                    .setAndRefreshSelectedItem(tasks, [TaskDocGenerated.nameCheckList, TaskDocGenerated.nameTableComments, TaskDocGenerated.nameFiles]);

                taskView = true;
              });
            } else {
              taskController.currentItem = tasks;

              taskController.itemPageOpen(tasks, Routes.newTaskPage, needRefreshSelectedItem: true);
            }

            if (tasks.isReadByAssignee == false &&
                (Get.find<DataController>().currentUser == tasks.assignee || Get.find<DataController>().currentUser == tasks.assignee.mainUserAccount)) {
              tasks.isReadByAssignee = true;
              Get.find<TasksController>().postItems([tasks]);
            }
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
        physics: const BouncingScrollPhysics(),
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
              color: accepted.isNotEmpty ? ControlOptions.instance.colorMain.withOpacity(0.4) : Colors.transparent,
            ),
            child: child);
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) async {
        if (status.status != data.taskStatus) {
          data.taskStatus = status.status;
          taskController.currentItem = data;
          taskController.currentItem.dateUpdated = DateTime.now();
          NsgProgressDialog progress = NsgProgressDialog(textDialog: 'Сохранение данных на сервере', canStopped: false);

          progress.show();
          await taskController.postItems([taskController.currentItem]);
          progress.hide();
          taskController.sendNotify();
        }

        //  taskController.itemPagePost(goBack: false);
        //
      },
    );
  }

  reset() {
    setState(() {
      taskBoardController.currentItem.sortBy = ESorting.dateDesc;
      taskBoardController.sendNotify();
      serviceC.currentItem.userAccountId = '';
      isDatesearch = false;
      searchDate = DateTime.now();
      searchvalue = '';
      textEditController.clear();
      taskController.refreshData();
    });
  }
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
    if (Get.width > 700) {
      return Draggable(
        data: widget.tasks,
        onDragUpdate: (details) {
          angle = details.delta.dx / 200;
          if ((angle).abs() < .03) {
            angle = 0;
          }
          if (dataKey.currentState != null) {
            dataKey.currentState!.setAngle(angle);
          }
        },
        feedback: RotatingCard(key: dataKey, tasks: widget.tasks, constraints: widget.constraints),
        childWhenDragging: Opacity(opacity: 0.2, child: taskCard(widget.tasks, widget.constraints, context)),
        child: taskCard(widget.tasks, widget.constraints, context),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: taskCard(widget.tasks, widget.constraints, context),
      );
    }
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
          decoration: BoxDecoration(boxShadow: [BoxShadow(blurRadius: 10, color: ControlOptions.instance.colorGrey.withOpacity(0.7))]),
          child: taskCard(widget.tasks, widget.constraints, context)),
    );
  }
}

changeTaskStatus(TaskDoc tasks) {
  var form = NsgSelection(
    selectedElement: tasks.taskStatus,
    inputType: NsgInputType.reference,
    controller: Get.find<ProjectStatusController>(),
  );
  form.selectFromArray(
    'Смена статуса заявки',
    (item) async {
      tasks.taskStatus = item as TaskStatus;
      tasks.dateUpdated = DateTime.now();
      await Get.find<TasksController>().postItems([tasks]);
      Get.find<TasksController>().sendNotify();
      Get.find<TaskStatusTableController>().sendNotify();

      //Get.find<TaskStatusTableController>().sendNotify();
      //taskBoardController.sendNotify();*/
    },
  );
}

changeStatus(TaskDoc tasks) {
  var form = NsgSelection(
    selectedElement: tasks.taskStatus,
    inputType: NsgInputType.reference,
    controller: Get.find<TaskStatusController>(),
  );
  form.selectFromArray(
    'Смена статуса заявки',
    (item) async {
      tasks.taskStatus = item as TaskStatus;
      await Get.find<TasksController>().postItems([tasks]);
      Get.find<TasksController>().sendNotify();
      Get.find<TaskStatusTableController>().sendNotify();

      //Get.find<TaskStatusTableController>().sendNotify();
      //taskBoardController.sendNotify();*/
    },
  );
}

/* -------------------------------------------------------------- Карточка с задачей -------------------------------------------------------------- */
Widget taskCard(TaskDoc tasks, BoxConstraints constraints, context) {
  var taskC = Get.find<TasksController>();
  return GestureDetector(
    onLongPress: () {
      changeStatus(tasks);
    },
    child: Stack(
      children: [
        if (tasks.priority == EPriority.high)
          SizedBox(
            width: constraints.maxWidth,
            child: Card(
                elevation: 3,
                color: const Color.fromARGB(239, 248, 250, 252),
                child: Stack(
                  children: [
                    ClipPath(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          left: BorderSide(color: Colors.red, width: 5),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [tasksubPart(tasks)],
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              openTaskDialog(tasks, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: ControlOptions.instance.colorGrey,
                                size: 24,
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
          ),
        if (tasks.priority == EPriority.medium)
          SizedBox(
            width: constraints.maxWidth,
            child: Card(
                elevation: 3,
                color: const Color.fromARGB(239, 248, 250, 252),
                child: Stack(
                  children: [
                    ClipPath(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          left: BorderSide(color: Colors.yellow, width: 5),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [tasksubPart(tasks)],
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              openTaskDialog(tasks, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: ControlOptions.instance.colorGrey,
                                size: 24,
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
          ),
        if (tasks.priority == EPriority.low)
          SizedBox(
            width: constraints.maxWidth,
            child: Card(
                elevation: 3,
                color: const Color.fromARGB(239, 248, 250, 252),
                child: Stack(
                  children: [
                    ClipPath(
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                          left: BorderSide(color: Colors.green, width: 5),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [tasksubPart(tasks)],
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              openTaskDialog(tasks, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: ControlOptions.instance.colorGrey,
                                size: 24,
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
          ),
        if (tasks.priority == EPriority.none)
          SizedBox(
            width: constraints.maxWidth,
            child: Card(
                elevation: 3,
                color: const Color.fromARGB(239, 248, 250, 252),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [tasksubPart(tasks)],
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              openTaskDialog(tasks, context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: ControlOptions.instance.colorGrey,
                                size: 24,
                              ),
                            ),
                          ),
                        ))
                  ],
                )),
          ),
      ],
    ),
  );
}

Widget tasksubPart(tasks) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Flexible(
            child: Text(
              tasks.docNumber,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
          if (kIsWeb || (Platform.isWindows || Platform.isLinux))
            Flexible(
              child: IconButton(
                  onPressed: () {
                    if (tasks.isReadByAssignee == false &&
                        (Get.find<DataController>().currentUser == tasks.assignee ||
                            Get.find<DataController>().currentUser == tasks.assignee.mainUserAccount)) {
                      tasks.isReadByAssignee = true;
                      Get.find<TasksController>().postItems([tasks]);
                    }
                    
                    Get.find<TaskCheckListController>().requestItems();
                    Get.find<TasksController>().currentItem = tasks;

                    Get.find<TasksController>().itemPageOpen(tasks, Routes.newTaskPage, needRefreshSelectedItem: true);
                    Get.find<TasksController>().sendNotify();
                  },
                  icon: const Icon(Icons.edit)),
            ),
          if (tasks.isReadByAssignee == true) const Tooltip(message: 'Task Seen by User', child: Icon(Icons.done_all)),
        ],
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
    Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(Icons.access_time, size: ControlOptions.instance.sizeS, color: ControlOptions.instance.colorGreyDark),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  'создано: ${getcreateDay(tasks)}',
                  maxLines: 1,
                  style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF)),
                ),
              ),
              Text(
                getupdateDay(tasks),
                maxLines: 1,
                style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF)),
              ),
            ],
          ),
        ),
        Row(
          children: [
            if (Get.find<TaskCommentsController>().items.where((element) => element.ownerId == tasks.id).length.isGreaterThan(0))
              Tooltip(
                message: 'Comments',
                child: NsgCircle(text: Get.find<TaskCommentsController>().items.where((element) => element.ownerId == tasks.id).length.toString()),
              ),
            ClipOval(
              child: tasks.assignee.photoName.isEmpty
                  ? Container(
                      decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                      width: 32,
                      height: 32,
                      child: Icon(
                        Icons.account_circle,
                        size: 20,
                        color: ControlOptions.instance.colorMain.withOpacity(0.4),
                      ),
                    )
                  : Tooltip(
                      message: tasks.assignee.toString(),
                      child: Image.network(
                        TaskFilesController.getFilePath(tasks.assignee.photoName),
                        fit: BoxFit.cover,
                        width: 32,
                        height: 32,
                      ),
                    ),
            ),
          ],
        ),
      ],
    )
  ]);
}

openTaskDialog(tasks, context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  // set up the button

  // Widget statusButton = ElevatedButton(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: Colors.white,
  //     // elevation: 3,
  //     minimumSize: Size(width, height * 0.08),
  //   ),
  //   child: const Text("Change Status"),
  //   onPressed: () {
  //     changeTaskStatus(tasks);
  //   },
  // );
  Widget copy = ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      // elevation: 3,
      minimumSize: Size(width, height * 0.08),
    ),
    child: const Text("Copy Task to another Project"),
    onPressed: () {
      selectProjectCopy(tasks);
    },
  );
  Widget move = ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      // elevation: 3,
      minimumSize: Size(width, height * 0.08),
    ),
    child: const Text("Move Task to another Project"),
    onPressed: () {
      selectProjectMove(tasks);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    actions: [copy, move],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

selectProjectCopy(TaskDoc tasks) {
  var form = NsgSelection(
    selectedElement: ProjectItem(),
    inputType: NsgInputType.reference,
    controller: Get.find<ProjectController>(),
  );
  form.selectFromArray(
    'Select Project',
    (item) async {
      tasks.state = NsgDataItemState.create;
      tasks.projectId = Get.find<ProjectController>().currentItem.id;
      tasks.id = Guid.newGuid();
      if (tasks.assignee !=
          Get.find<ProjectController>()
              .currentItem
              .tableUsers
              .rows
              .firstWhere((element) => element.userAccount == tasks.assignee, orElse: () => ProjectItemUserTable())
              .userAccount) {
        tasks.assignee == Get.find<ProjectController>().currentItem.defaultUser;
      }
      Get.find<TasksController>().currentItem = tasks;

      await Get.find<TasksController>().postItems([tasks]);
    },
  );
}

selectProjectMove(TaskDoc tasks) {
  var form = NsgSelection(
    selectedElement: ProjectItem(),
    inputType: NsgInputType.reference,
    controller: Get.find<ProjectController>(),
  );
  form.selectFromArray(
    'Select Project',
    (item) async {
      tasks.projectId = Get.find<ProjectController>().currentItem.id;
      tasks.docNumber = Get.find<ProjectController>().currentItem.projectPrefix;
       if (tasks.assignee !=
          Get.find<ProjectController>()
              .currentItem
              .tableUsers
              .rows
              .firstWhere((element) => element.userAccount == tasks.assignee, orElse: () => ProjectItemUserTable())
              .userAccount) {
        tasks.assignee == Get.find<ProjectController>().currentItem.defaultUser;
      }
      await Get.find<TaskCopyMoveController>().postItems([tasks]);
    },
  );
}

String getupdateDay(TaskDoc tasks) {
  var todayDate = DateTime.now();
  final lastDate = tasks.dateUpdated;
  var daysleft = todayDate.difference(lastDate).inDays;
  if (daysleft > 7) {
    return 'Обновлено: ${NsgDateFormat.dateFormat(tasks.dateUpdated, format: 'dd.MM.yy HH:mm')}';
  }
  var minutes = todayDate.difference(lastDate).inMinutes;
  if (minutes == 0) {
    return 'Обновлено: только что';
  }
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

String getcreateDay(TaskDoc tasks) {
  var todayDate = DateTime.now();
  final lastDate = tasks.date;
  var daysleft = todayDate.difference(lastDate).inDays;
  if (daysleft > 7) {
    return '${NsgDateFormat.dateFormat(tasks.date, format: 'dd.MM.yy HH:mm')}';
  }
  var minutes = todayDate.difference(lastDate).inMinutes;
  if (minutes == 0) {
    return 'только что';
  }
  if (minutes < 60) {
    return '$minutes мин. назад';
  }
  var hours = todayDate.difference(lastDate).inHours;
  if (hours <= 24) {
    return '$hours Час. назад';
  }

  if (daysleft <= 7) {
    return '$daysleft дн. назад';
  }

  return '$daysleft дн. назад';
}
