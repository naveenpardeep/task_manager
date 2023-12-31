import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_icon_button.dart';
import 'package:nsg_controls/nsg_simple_progress_bar.dart';
import 'package:nsg_controls/nsg_style_button.dart';
import 'package:nsg_controls/widgets/nsg_circle.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:resizable_widget/resizable_widget.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task%20type/task_type_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/task_status/project_status_controller.dart';
import 'package:task_manager_app/forms/task_status/task_status_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_app_bar.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums.dart';
import 'package:task_manager_app/view/task_load_controller.dart';
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
  String tasktypeName = '';
  String screenName = '';
  String searchvalue = '';
  DateTime searchDate = DateTime.now();
  DateFormat searchformat = DateFormat("dd-MM-yyyy");
  var scrollController = ScrollController();

  DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
  @override
  void initState() {
    super.initState();
    tasktypeName;
    if (taskcommentC.lateInit) {
      taskcommentC.requestItems();
    }
    if (NsgUserSettings.controller!.getSettingItem('userAcc_${projectController.currentItem.id}') != null) {
      serviceC.currentItem.userAccountId = (NsgUserSettings.controller!.getSettingItem('userAcc_${projectController.currentItem.id}') as UserSettings).settings;
    }
    if (NsgUserSettings.controller!.getSettingItem('board_${projectController.currentItem.id}') != null) {
      serviceC.currentItem.boardId = (NsgUserSettings.controller!.getSettingItem('board_${projectController.currentItem.id}') as UserSettings).settings;
    }
    scrollController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    projectName = projectController.currentItem.name;

    // screenName=taskBoardController.currentItem.name;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              if (width > 700) const Divider(),
              Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          projectController.currentItem.name,
                          style: TextStyle(
                            fontSize: width < 700 ? 16 : 20,
                            fontFamily: 'Inter',
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
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          color: ControlOptions.instance.colorMain,
                          size: 16,
                          icon: Icons.settings,
                          onPressed: () {
                            projectController.itemPageOpen(projectController.currentItem, Routes.projectMobilePageview);
                          },
                        ),
                      if (width > 700)
                        IconButton(
                            hoverColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                taskView = false;
                                reset();
                              });
                            },
                            icon: Icon(
                              Icons.refresh,
                              size: width < 700 ? 16 : 24,
                            )),
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
                                        hoverColor: Colors.transparent,
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
                                  setState(() {
                                    taskView = false;
                                  });
                                  searchvalue = val;
                                  taskController.refreshData();
                                  taskStatusTableController.sendNotify();
                                }),
                          ),
                        ),
                      if (width > 700)
                        SizedBox(
                          height: 40,
                          child: NsgButton(
                              backHoverColor: Colors.transparent,
                              color: ControlOptions.instance.colorWhite,
                              borderRadius: 10,
                              width: 100,
                              onPressed: () {
                                var user = Get.find<UserAccountController>().items.firstWhereOrNull((element) =>
                                    element.organizationId == projectController.currentItem.organizationId &&
                                    element.mainUserAccountId == Get.find<DataController>().mainProfile.id);
                                serviceC.currentItem.userAccount = user ?? UserAccount();
                                taskController.refreshData();
                              },
                              text: 'My Tasks'),
                        ),
                      if (projectController.currentItem.isArchived == false)
                        Expanded(
                          child: SizedBox(
                            height: 30,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: NsgButton(
                                borderRadius: 10,
                                width: width > 700 ? 150 : 35,
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                icon: Icons.add,
                                text: width > 700 ? 'Новая Задача' : '',
                                color: width > 700 ? Colors.white : ControlOptions.instance.colorMain,
                                backColor: width > 700 ? ControlOptions.instance.colorMain : Colors.transparent,
                                onPressed: () {
                                  setState(() {
                                    taskView = false;
                                  });
                                  Get.find<TasksController>().selectedItem == null;
                                  Get.find<TasksController>().newItemPageOpen(pageName: Routes.taskEditPage);
                                },
                              ),
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
                                    setState(() {
                                      taskView = false;
                                    });
                                    searchvalue = val;
                                    taskController.refreshData();
                                    taskStatusTableController.sendNotify();
                                  }),
                            ),
                          ),
                          TaskIconButton(
                            nott: 0,
                            style: TaskButtonStyle.light,
                            icon: Icons.filter_alt_outlined,
                            onTap: () {
                              // scaffoldKey.currentState!.openDrawer();
                              showdialogBuilder(context, height, width);
                            },
                          ),
                        ],
                      ),
                    ),

              //  if (taskBoardController.currentItem.isNotEmpty)
              Expanded(
                child: Stack(
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
                              controller: scrollController,
                              child: SizedBox(
                                width: width + 450,
                                child: getStatusListForTaskView(),
                              ))),
                    if (taskView == false) Container(child: getStatusList()),
                    if (taskView == true)
                      Animate(
                        effects: const [FlipEffect()],
                        child: ResizableWidget(
                            percentages: width > 750 ? [0.65, 0.35, 0] : [0, 1, 0],
                            isHorizontalSeparator: false,
                            isDisabledSmartHide: false,
                            separatorColor: Colors.grey,
                            separatorSize: width > 750 ? 7 : 0,
                            children: [
                              const SizedBox(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: taskController.obx((state) => Container(key: GlobalKey(), child: const TaskViewPage())),
                              ),
                              if (taskView)
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          taskView = false;
                                        });
                                      },
                                      icon: const Icon(Icons.close)),
                                ),
                            ]),
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

  Future<void> showdialogBuilder(BuildContext context, height, width) {
    return showModalBottomSheet<void>(
      context: context,
      constraints: BoxConstraints(maxHeight: height - 30),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          insetPadding: const EdgeInsets.all(0),
          child: Column(children: [
            const Padding(padding: EdgeInsets.only(top: 5)),
            TTAppBar(
              title: 'Фильтр',
              rightIcons: [
                TTAppBarIcon(
                  icon: Icons.close,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              leftIcons: [
                TTAppBarIcon(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            SizedBox(
              height: height - 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
            ),
          ]),
        );
      },
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
      if (width < 700)
        wrapFlexible(
            child: SizedBox(
          height: 40,
          child: NsgButton(
              color: ControlOptions.instance.colorWhite,
              borderRadius: 20,
              onPressed: () {
                var user = Get.find<UserAccountController>().items.firstWhereOrNull((element) =>
                    element.organizationId == projectController.currentItem.organizationId &&
                    element.mainUserAccountId == Get.find<DataController>().mainProfile.id);
                serviceC.currentItem.userAccount = user ?? UserAccount();
                taskController.refreshData();
                setState(() {
                  taskView = false;
                });
              },
              text: 'My Tasks'),
        )),
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
            NsgUserSettings.controller!.setSettingItem('userAcc_${projectController.currentItem.id}', (item as ServiceObject).userAccountId);
            //var test = NsgUserSettings.controller!.getSettingItem('taskF');
            taskController.refreshData();
            taskStatusTableController.sendNotify();
            taskBoardController.sendNotify();
            setState(() {
              taskView = false;
            });
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
                NsgUserSettings.controller!.setSettingItem('board_${projectController.currentItem.id}', (item as ServiceObject).boardId);
                screenName = serviceC.currentItem.boardId;

                taskController.refreshData();
                taskStatusTableController.refreshData();
                taskBoardController.refreshData();
                taskView = false;
              });
            }),
      ),
      wrapFlexible(
        child: TTNsgInput(
            label: 'Тип задачи',
            infoString: 'Выберите тип задачи',
            selectionController: Get.find<TaskTypeController>(),
            dataItem: serviceC.currentItem,
            fieldName: ServiceObjectGenerated.nameTaskTypeId,
            onEditingComplete: (item, field) {
              setState(() {
                taskController.refreshData();

                taskView = false;
              });
            }),
      ),
      wrapFlexible(
        child: TTNsgInput(
          label: 'Сортировка',
          dataItem: taskBoardController.currentItem,
          fieldName: TaskBoardGenerated.nameSortBy,
          onEditingComplete: (task, name) {
            NsgUserSettings.controller!.setSettingItem('sort_${projectController.currentItem.id}', (task as TaskBoard).sortBy.value.toString());
            taskBoardController.sendNotify();
            taskController.refreshData();
            setState(() {
              taskView = false;
            });
          },
        ),
      ),
      wrapFlexible(
        child: TTNsgInput(
          label: 'Finished Tasks Period',
          dataItem: taskBoardController.currentItem,
          fieldName: TaskBoardGenerated.namePeriodOfFinishedTasks,
          onEditingComplete: (task, name) {
            NsgUserSettings.controller!
                .setSettingItem('period_${projectController.currentItem.id}', (task as TaskBoard).periodOfFinishedTasks.value.toString());
            taskBoardController.sendNotify();
            taskController.refreshData();
            setState(() {
              taskView = false;
            });
          },
        ),
      ),
      SizedBox(
        height: 40,
        width: 150,
        child: IconButton(
          hoverColor: Colors.transparent,
          padding: EdgeInsets.zero,
          icon: const Text('Очистить Фильтры'),
          color: ControlOptions.instance.colorMain,
          onPressed: () {
            reset();
            if (width < 700) {
              Navigator.of(context).pop();
            }
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

    for (var status in taskStatusTableController.items) {
      var scrollController = ScrollController();
      statuses.add(status.status.toString());
      if (width > 1050) {
        list.add(Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  status.status.toString(),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: status.status.isDone ? Colors.green : const Color(0xff529FBF),
                  ),
                ),
                taskController.obx((state) => searchvalue.isEmpty ? getTasklength(status.status) : const Text('')),
                Expanded(
                  child: SizedBox(
                    width: taskStatusTableController.items.length > 4 ? 250 : 300,
                    child: wrapdragTarget(
                      status: status,
                      child: RawScrollbar(
                        key: const PageStorageKey<String>('scrollController'),
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: scrollController,
                        thickness: width > 700 ? 10 : 0,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child:
                            SingleChildScrollView(scrollDirection: Axis.vertical, controller: scrollController, child: getTaskListForTaskview(status.status)),
                      ),
                    ),
                  ),
                ),
              ],
            )));
      } else {
        tabsList.add(NsgTabsTab(
          tab: Container(
            decoration:
                BoxDecoration(border: Border.all(width: 2, color: Colors.transparent), borderRadius: BorderRadius.circular(3), color: Colors.transparent),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  status.status.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: status.status.isDone ? Colors.green : const Color(0xff529FBF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: getTasklength(status.status),
                ),
              ],
            ),
          ),
          tabSelected: Container(
            decoration: BoxDecoration(border: Border.all(width: 2, color: ControlOptions.instance.colorMain), borderRadius: BorderRadius.circular(3)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  status.status.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: status.status.isDone ? Colors.green : const Color(0xff529FBF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: getTasklength(status.status),
                ),
              ],
            ),
          ),
          child: SingleChildScrollView(child: getTaskListForTaskview(status.status)),
        ));
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

/* ------------------------------------------------------- Список задач в колонке по статусу ------------------------------------------------------ */
  Widget getTaskListForTaskview(TaskStatus status) {
    List<Widget> list = [];
    late TaskLoadController taskLoadC;

    //assert();
    var taskLoadCFind = taskController.tasksControllersList.where((element) => element.currentTaskStatus == status).toList();
    if (taskLoadCFind.isNotEmpty) {
      taskLoadC = taskLoadCFind[0];
      //  var tasktypes = serviceC.currentItem.taskTypeId == ''
      //     ? taskLoadC.currentStatusTasks
      //    : taskLoadC.currentStatusTasks.where((element) => element.taskTypeId == serviceC.currentItem.taskTypeId);
      return taskLoadC.obx((state) {
        list = [];
        for (var tasks in taskLoadC.currentStatusTasks) {
          if (tasks.taskStatus != status) continue;
          if (tasks.name.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
              tasks.assignee.toString().toLowerCase().contains(searchvalue.toLowerCase()) ||
              tasks.taskNumber.toString().toLowerCase().contains(searchvalue.toLowerCase())) {
            list.add(GestureDetector(
              onTap: () {
                Get.find<TasksController>().isPeriodicController = false;
                Get.find<TaskCommentsController>().isTaskCommentCont = true;
                if (kIsWeb || (Platform.isWindows || Platform.isLinux)) {
                  setState(() {
                    Get.find<TaskFilesController>().requestItems();
                    Get.find<TaskCheckListController>().requestItems();
                    taskController.setAndRefreshSelectedItem(tasks, [TaskDocGenerated.nameCheckList, TaskDocGenerated.nameFiles]);
                    scrollController.keepScrollOffset;
                    taskView = true;
                  });
                } else {
                  taskController.itemPageOpen(tasks, Routes.taskEditPage, needRefreshSelectedItem: true);
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
        if (list.length < taskLoadC.total) {
          list.add(NsgTextButton(
              text: 'Загрузить еще',
              color: ControlOptions.instance.colorMain,
              onTap: () {
                taskLoadC.loadMoreTasks(3);
              }));
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
          child: Column(
            children: list,
          ),
        );
      }, onLoading: const NsgSimpleProgressBar());
    } else {
      return const NsgSimpleProgressBar();
    }
  }

/* ------------------------------------------------------- Вывод колонок по статусу ------------------------------------------------------- */
  Widget getStatusList() {
    double width = MediaQuery.of(context).size.width;

    List<Widget> list = [];
    List<NsgTabsTab> tabsList = [];
    List<String> statuses = [];

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
                      Text(
                        status.status.toString(),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: status.status.isDone ? Colors.green : const Color(0xff529FBF),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 5), child: searchvalue.isEmpty ? getTasklength(status.status) : const Text('')),
                    ],
                  ),
                  const Divider(thickness: 2, height: 20),
                  Expanded(
                    child: SizedBox(
                      width: width,
                      child: wrapdragTarget(
                        status: status,
                        child: RawScrollbar(
                          key: const PageStorageKey<String>('scrollController'),
                          thumbVisibility: true,
                          trackVisibility: true,
                          controller: scrollController,
                          thickness: width > 700 ? 10 : 0,
                          trackBorderColor: ControlOptions.instance.colorGreyLight,
                          trackColor: ControlOptions.instance.colorGreyLight,
                          thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                          radius: const Radius.circular(0),
                          child: SingleChildScrollView(controller: scrollController, child: getTaskListForTaskview(status.status)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ));
      } else {
        tabsList.add(NsgTabsTab(
            tab: Container(
              decoration:
                  BoxDecoration(border: Border.all(width: 2, color: Colors.transparent), borderRadius: BorderRadius.circular(3), color: Colors.transparent),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    status.status.name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: status.status.isDone ? Colors.green : const Color(0xff529FBF),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: getTasklength(status.status),
                  ),
                ],
              ),
            ),
            tabSelected: Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: ControlOptions.instance.colorMain))),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    status.status.name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      color: status.status.isDone ? Colors.green : ControlOptions.instance.colorMain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: getTasklength(status.status),
                  ),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [getTaskListForTaskview(status.status)],
              ),
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
    late TaskLoadController taskLoadC;
    var taskLoadCFind = taskController.tasksControllersList.where((element) => element.currentTaskStatus == status).toList();
    if (taskLoadCFind.isNotEmpty) {
      taskLoadC = taskLoadCFind[0];

      return taskLoadC.obx((state) {
        return Text(
          taskLoadC.total.toString(),
          style: const TextStyle(fontFamily: 'Inter', fontSize: 16, color: Color(0xff529FBF)),
        );
      },
          onLoading: Text(
            '...',
            style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.w600),
          ));
    } else {
      return Text(
        '...',
        style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.w600),
      );
    }
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
        late TaskLoadController taskLoadC;
        late TaskLoadController taskLoadC1;
        var taskLoadforcurrent = taskController.tasksControllersList.where((element) => element.currentTaskStatus == status.status).toList();
        var taskLoadforanotherstatus = taskController.tasksControllersList.where((element) => element.currentTaskStatus == data.taskStatus).toList();

        if (status.status != data.taskStatus) {
          data.taskStatus = status.status;
          taskController.currentItem = data;
          taskController.currentItem.dateUpdated = DateTime.now();

          NsgProgressDialog progress = NsgProgressDialog(textDialog: 'Сохранение данных на сервере', canStopped: false);

          progress.show();
          await taskController.postItems([taskController.currentItem]);

          progress.hide();

          // taskLoadC = taskLoadforcurrent[0];
          // taskLoadC1 = taskLoadforanotherstatus[0];
          // taskLoadC.loadMoreTasks(
          //   1,
          // );
          // taskLoadC1.loadMoreTasks(
          //   1,
          // );
           taskController.refreshData();
        }
      },
    );
  }

  void reset() {
    setState(() {
      serviceC.currentItem.taskTypeId = '';
      taskBoardController.currentItem.sortBy = ESorting.dateDesc;
      taskBoardController.currentItem.periodOfFinishedTasks = EPeriod.all;
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

taskStatus(BuildContext context, tasks) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Center(child: Text('Смена статуса заявки')),
    content: SizedBox(
      child: SingleChildScrollView(
        child: Column(
          children: [statuslist(context, tasks)],
        ),
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget statuslist(context, TaskDoc taskDoc) {
  List<Widget> list = [];
  double width = MediaQuery.of(context).size.width;
  var taskboardstaus = Get.find<TaskBoardController>().currentItem;

  var stsList = Get.find<ProjectStatusController>().items;

  for (var status in stsList) {
    list.add(Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
        child: InkWell(
            onTap: () async {
              taskDoc.taskStatus = status;
              Navigator.of(context).pop();
              await Get.find<TasksController>().postItems([taskDoc]);

              Get.find<TasksController>().refreshData();
            },
            onLongPress: () {},
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: width > 700 ? width / 2 : width,
                color: taskDoc.taskStatus == status ? const Color.fromARGB(255, 208, 243, 209) : Colors.white,
                child: Center(
                  child: Text(
                    status.name,
                    style: TextStyle(
                        fontSize: ControlOptions.instance.sizeL,
                        color: taskboardstaus.statusTable.rows.where((element) => element.status.name == status.name).isNotEmpty ? Colors.black : Colors.red),
                  ),
                ),
              ),
            ]))));
  }
  return SingleChildScrollView(child: Column(children: list));
}

changeTaskStatus(TaskDoc tasks,context, [int? value]) {
  var form = NsgSelection(
    selectedElement: tasks.taskStatus,
    inputType: NsgInputType.reference,
    controller: value == 2 ? Get.find<TaskStatusController>() : Get.find<ProjectStatusController>(),
  );
  form.selectFromArray(
    'Смена статуса заявки',
    (item) async {
      tasks.taskStatus = item as TaskStatus;
      tasks.dateUpdated = DateTime.now();
      await Get.find<TasksController>().postItems([tasks]);
      Get.find<TasksController>().refreshData();
      Get.find<TaskStatusTableController>().sendNotify();

      //Get.find<TaskStatusTableController>().sendNotify();
      //taskBoardController.sendNotify();*/
    }, context: context,
  );
}

Color getTaskPriorityColor(EPriority priority) {
  switch (priority.value) {
    //Низкий
    case 1:
      return Colors.green;
    //Средний
    case 2:
      return Colors.yellow;
    //Высокий
    case 3:
      return Colors.red;
    //не назначен
    default:
      return Colors.transparent;
  }
}

/* -------------------------------------------------------------- Карточка с задачей -------------------------------------------------------------- */
Widget taskCard(TaskDoc tasks, BoxConstraints constraints, context) {
  return GestureDetector(
    onLongPress: () {
      taskStatus(context, tasks);
    },
    onDoubleTap: () async {
      Get.find<TasksController>().isPeriodicController = false;
      Get.find<TaskCommentsController>().isTaskCommentCont = true;
      if (tasks.isReadByAssignee == false &&
          (Get.find<DataController>().currentUser == tasks.assignee || Get.find<DataController>().currentUser == tasks.assignee.mainUserAccount)) {
        tasks.isReadByAssignee = true;
        Get.find<TasksController>().postItems([tasks]);
      }

      await Get.find<TasksController>().setAndRefreshSelectedItem(tasks, [TaskDocGenerated.nameCheckList]);
      Get.find<TasksController>().currentItem = tasks;

      Get.find<TasksController>().itemPageOpen(Get.find<TasksController>().currentItem, Routes.taskEditPage, needRefreshSelectedItem: true);
    },
    child: Stack(
      children: [
        SizedBox(
          width: constraints.maxWidth,
          height: 135,
          child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: const Color(0xffEDEFF3),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                        left: BorderSide(color: getTaskPriorityColor(tasks.priority), width: 7),
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
                        child: GestureDetector(
                          onTapDown: (TapDownDetails details) {
                            showPopUpMenu(details.globalPosition, tasks, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
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

Future<void> showPopUpMenu(Offset globalPosition, tasks, context) async {
  double left = globalPosition.dx;
  double top = globalPosition.dy;

  await showMenu(
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    ),
    color: const Color(0xffEDEFF3).withOpacity(0.9),
    context: context,
    position: RelativeRect.fromLTRB(left, top, left + 1, top + 1),
    items: [
      const PopupMenuItem(
        value: 1,
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 20),
          child: Text(
            "Редактировать",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      const PopupMenuItem(
        value: 2,
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 20),
          child: Text(
            "Изменить статус задачи",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      const PopupMenuItem(
        value: 3,
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Text(
            "Перенести в другой проект",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      const PopupMenuItem(
        value: 4,
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Text(
            "Скопировать в другой проект",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      const PopupMenuItem(
        value: 5,
        child: Padding(
          padding: EdgeInsets.only(left: 0, right: 0),
          child: Text(
            "Assign me",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      // const PopupMenuItem(
      //   value: 6,
      //   child: Padding(
      //     padding: EdgeInsets.only(left: 0, right: 20),
      //     child: Text(
      //       "Измените статус из списка статусов проекта",
      //       style: TextStyle(color: Colors.black),
      //     ),
      //   ),
      // ),
    ],
  ).then((value) async {
    if (value == 1) {
      Get.find<TasksController>().isPeriodicController = false;
      Get.find<TaskCommentsController>().isTaskCommentCont = true;
      if (tasks.isReadByAssignee == false &&
          (Get.find<DataController>().currentUser == tasks.assignee || Get.find<DataController>().currentUser == tasks.assignee.mainUserAccount)) {
        tasks.isReadByAssignee = true;
        Get.find<TasksController>().postItems([tasks]);
      }

      await Get.find<TasksController>().setAndRefreshSelectedItem(tasks, [TaskDocGenerated.nameCheckList]);

      Get.find<TasksController>().itemPageOpen(tasks, Routes.taskEditPage, needRefreshSelectedItem: true);
      Get.find<TasksController>().sendNotify();
    }
    if (value == 2) {
      //   changeTaskStatus(tasks, value);
      taskStatus(context, tasks);
    }
    if (value == 3) {
      selectProjectMove(tasks,context);
    }
    if (value == 4) {
      selectProjectCopy(tasks,context);
    }
    if (value == 5) {
      tasks.assignee = Get.find<DataController>().currentUser;

      Get.find<TasksController>().postItems([tasks]);

      Get.find<TasksController>().refreshData();
    }
    // if (value == 6) {
    //   changeTaskStatus(tasks, value);
    // }
  });
}

Widget tasksubPart(tasks) {
  return Column(children: [
    Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Flexible(
            child: Text(
              tasks.docNumber,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
          ),
          if (tasks.isReadByAssignee == true) const Tooltip(message: 'Task Seen by User', child: Icon(Icons.done_all, color: Color(0xff529FBF))),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 38,
              child: Text(
                tasks.name,
                maxLines: 2,
              ),
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
      selectProjectCopy(tasks,context);
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
      selectProjectMove(tasks,context);
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

selectProjectCopy(TaskDoc tasks,context) {
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
      tasks.author = Get.find<DataController>().currentUser;
      if (tasks.assignee !=
          Get.find<ProjectController>()
              .currentItem
              .tableUsers
              .rows
              .firstWhere((element) => element.userAccount == tasks.assignee, orElse: () => ProjectItemUserTable())
              .userAccount) {
        tasks.assignee = Get.find<ProjectController>().currentItem.defaultUser;
      }
      if (tasks.taskStatus !=
          Get.find<ProjectStatusController>().items.firstWhere((element) => element.name == tasks.taskStatus.name, orElse: () => TaskStatus())) {
        tasks.taskStatus = Get.find<ProjectStatusController>().items.first;
      }
      Get.find<TasksController>().currentItem = tasks;

      await Get.find<TasksController>().postItems([tasks]);
      Get.find<TasksController>().itemPageOpen(tasks, Routes.taskEditPage, needRefreshSelectedItem: true);
    }, context: context,
  );
}

selectProjectMove(TaskDoc tasks,context) {
  var form = NsgSelection(
    selectedElement: ProjectItem(),
    inputType: NsgInputType.reference,
    controller: Get.find<ProjectController>(),
  );
  form.selectFromArray(
    'Select Project',
    (item) async {
      tasks.projectId = Get.find<ProjectController>().currentItem.id;
      tasks.taskNumber = 0;
      tasks.author = Get.find<DataController>().currentUser;
      if (tasks.assignee !=
          Get.find<ProjectController>()
              .currentItem
              .tableUsers
              .rows
              .firstWhere((element) => element.userAccount == tasks.assignee, orElse: () => ProjectItemUserTable())
              .userAccount) {
        tasks.assignee = Get.find<ProjectController>().currentItem.defaultUser;
      }
      if (tasks.taskStatus !=
          Get.find<ProjectStatusController>().items.firstWhere((element) => element.name == tasks.taskStatus.name, orElse: () => TaskStatus())) {
        tasks.taskStatus = Get.find<ProjectStatusController>().items.last;
      }
      await Get.find<TasksController>().postItems([tasks]);
      Get.find<TasksController>().itemPageOpen(tasks, Routes.taskEditPage, needRefreshSelectedItem: true);
    }, context: context,
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
