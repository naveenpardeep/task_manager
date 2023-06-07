import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_grid.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/TaskList/taskList_file_controller.dart';
import 'package:task_manager_app/forms/TaskList/task_type_tasklist_controller.dart';
import 'package:task_manager_app/forms/TaskList/tasklist_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/task_board/task_board_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import 'package:task_manager_app/model/enums/e_priority.dart';
import 'package:task_manager_app/model/enums/e_sorting.dart';
import '../widgets/top_menu.dart';

class NewTasklistPage extends StatefulWidget {
  const NewTasklistPage({Key? key}) : super(key: key);
  @override
  State<NewTasklistPage> createState() => _NewTasklistPageState();
}

class _NewTasklistPageState extends State<NewTasklistPage> {
  var controller = Get.find<TaskListController>();
  var serviceC = Get.find<ServiceObjectController>();
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late double width;
  var textEditController = TextEditingController();
  var tasklistfilecon = Get.find<TaskListFilesController>();
  var author = '';
  var assignee = '';

  @override
  void initState() {
    super.initState();
    author;
    assignee;
  }

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    if (tasklistfilecon.lateInit) {
      tasklistfilecon.requestItems();
    }

    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BodyWrap(
        child: Scaffold(
            key: scaffoldKey,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (width > 700) const TmTopMenu(),

                Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
                            child: SizedBox(
                              height: 35,
                              child: TextField(
                                  controller: textEditController,
                                  decoration: InputDecoration(
                                      filled: false,
                                      fillColor: ControlOptions.instance.colorMainLight,
                                      prefixIcon: width > 700 ? const Icon(Icons.search) : null,
                                      border: OutlineInputBorder(
                                          gapPadding: 1,
                                          borderSide: BorderSide(color: ControlOptions.instance.colorMainDark),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      suffixIcon: IconButton(
                                          hoverColor: Colors.transparent,
                                          padding: const EdgeInsets.only(bottom: 0),
                                          onPressed: (() {
                                            setState(() {});
                                            textEditController.clear();
                                          }),
                                          icon: const Icon(Icons.cancel)),
                                      // prefixIcon: Icon(Icons.search),
                                      hintText: 'Search Tasks...'),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  style: TextStyle(color: ControlOptions.instance.colorMainLight, fontFamily: 'Inter', fontSize: width > 700 ? 16 : 10),
                                  onChanged: (val) {
                                    setState(() {});
                                  }),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: SizedBox(
                              child: TTNsgInput(
                                label: 'Project',
                                infoString: 'Select Project',
                                selectionController: Get.find<ProjectController>(),
                                dataItem: Get.find<ServiceObjectController>().currentItem,
                                fieldName: ServiceObjectGenerated.nameProjectId,
                                onEditingComplete: (p0, p1) {
                                  controller.top = 0;

                                  controller.refreshData();
                                },
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: TTNsgInput(
                        //     label: 'Исполнитель',
                        //     infoString: 'Выберите исполнителя',
                        //     selectionController: Get.find<UserAccountController>(),
                        //     dataItem: Get.find<ServiceObjectController>().currentItem,
                        //     fieldName: ServiceObjectGenerated.nameUserAccountId,
                        //     selectionForm: Routes.userAccountListPage,
                        //     onEditingComplete: (item, field) {
                        //       controller.refreshData();
                        //     },
                        //   ),
                        // ),
                        Expanded(
                          child: TTNsgInput(
                              label: 'Тип задачи',
                              infoString: 'Выберите тип задачи',
                              selectionController: Get.find<TaskTypeTaskListController>(),
                              dataItem: serviceC.currentItem,
                              fieldName: ServiceObjectGenerated.nameTaskTypeId,
                              onEditingComplete: (item, field) {
                                setState(() {
                                  controller.refreshData();
                                });
                              }),
                        ),
                        Expanded(
                          child: TTNsgInput(
                            label: 'Сортировка',
                            dataItem: serviceC.currentItem,
                            fieldName: ServiceObjectGenerated.nameSortTasksBy,
                            onEditingComplete: (task, name) {
                              controller.refreshData();
                              setState(() {});
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
                              serviceC.currentItem.taskTypeId = '';
                              serviceC.currentItem.projectId = '';
                              serviceC.currentItem.userAccountId = '';
                              serviceC.currentItem.sortTasksBy = ESorting.dateDesc;
                              textEditController.clear();
                              setState(() {});
                              controller.refreshData();
                            },
                          ),
                        )
                      ],
                    )),
                // Expanded(
                //     child: RefreshIndicator(
                //   onRefresh: () {
                //     return controller.refreshData();
                //   },
                //   child: RawScrollbar(
                //       thumbVisibility: true,
                //       trackVisibility: true,
                //       controller: scrollController,
                //       thickness: width > 700 ? 10 : 0,
                //       trackBorderColor: ControlOptions.instance.colorGreyLight,
                //       trackColor: ControlOptions.instance.colorGreyLight,
                //       thumbColor: ControlOptions.instance.colorPrimary.withOpacity(0.2),
                //       radius: const Radius.circular(0),
                //       child: SingleChildScrollView(
                //           physics: const BouncingScrollPhysics(),
                //           controller: scrollController,
                //           child: controller.obx((state) {
                //          //  return width > 500 ? NsgGrid(crossAxisCount: width ~/ 200, children: showTasks()) : Column(children: showTasks());
                //
                //           }))),
                // )),
                controller.obx((state) => Expanded(child: getTaskList())),
               
                if (width < 700) const BottomMenu(),
              ],
            )),
      ),
    );
  }

  Widget getTaskList() {
    double width = MediaQuery.of(context).size.width;

    List<Widget> list = [];

    List<String> taskColumns = [];

    var taskColumnName = controller.taskColumns;
    for (var columnName in taskColumnName) {
      var scrollController = ScrollController();
      taskColumns.add(columnName);

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
                    Tooltip(
                      message: columnName == 'My New Tasks' ? 'Not seen tasks' : '',
                      child: Text(
                        columnName,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if(columnName!='My New Tasks')
                      Padding(padding: const EdgeInsets.only(left: 5), child: getTasklength(columnName)),
                  ],
                ),
                const Divider(thickness: 2, height: 20),
                Expanded(
                  child: SizedBox(
                    width: width,
                    child: RawScrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      controller: scrollController,
                      thickness: width > 700 ? 10 : 0,
                      trackBorderColor: ControlOptions.instance.colorGreyLight,
                      trackColor: ControlOptions.instance.colorGreyLight,
                      thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                      radius: const Radius.circular(0),
                      child: SingleChildScrollView(physics: const BouncingScrollPhysics(), controller: scrollController, child: getTaskListView(columnName)),
                    ),
                  ),
                ),
              ],
            )),
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }


  Widget getTaskListView(String columnName) {
    var user = Get.find<UserAccountController>().items.firstWhere((element) => element.mainUserAccount == Get.find<DataController>().currentUser);
    serviceC.currentItem.userAccount = user ;
    List<Widget> list = [];
    var tasklist;
    if (columnName == 'My New Tasks') {
      tasklist = controller.items.where((element) => element.assignee.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.isReadByAssignee == false);
    }
    if (columnName == 'My Tasks') {
      tasklist = controller.items.where((element) => element.assignee.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.taskStatus.isDone == false && element.isReadByAssignee);
    }
    if (columnName == 'Created New') {
      tasklist = controller.items.where((element) => element.author.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.isReadByAssignee == false);
    }
    if (columnName == 'My Created Tasks') {
      tasklist = controller.items.where((element) => element.author.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.taskStatus.isDone == false && element.isReadByAssignee);
    }
    if (columnName == 'Deadline') {
      tasklist = controller.items.where((element) =>
          element.assignee.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount &&
          ((element.dateDeadline.isBefore(DateTime.now())) ||
              element.dateDeadline.day == DateTime.now().day ||
              element.dateDeadline.day == DateTime.now().day + 1 ||
              element.dateDeadline.day == DateTime.now().day + 2 ||
              element.dateDeadline.day == DateTime.now().day + 3) &&
          element.dateDeadline.toString() != '1754-01-01 00:00:00.000' &&
          element.dateDeadline.toString() != '0001-01-01 00:00:00.000' &&
          !element.taskStatus.isDone);
    }
    if (columnName == 'Deadline created') {
      tasklist = controller.items.where((element) =>
          element.author.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount &&
          ((element.dateDeadline.isBefore(DateTime.now())) ||
              element.dateDeadline.day == DateTime.now().day ||
              element.dateDeadline.day == DateTime.now().day + 1 ||
              element.dateDeadline.day == DateTime.now().day + 2 ||
              element.dateDeadline.day == DateTime.now().day + 3) &&
          element.dateDeadline.toString() != '1754-01-01 00:00:00.000' &&
          element.dateDeadline.toString() != '0001-01-01 00:00:00.000' &&
          !element.taskStatus.isDone);
    }
    for (var task in tasklist) {
      if (task.name.toString().toLowerCase().contains(textEditController.text.toLowerCase())) {
        list.add(TaskItemView(
          task: task,
          searchvalue: textEditController.text,
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 30),
      child: Column(
        children: list,
      ),
    );
  }

  getTasklength(String columnName) {
    var tasklist;
    if (columnName == 'My New Tasks') {
      tasklist = controller.items.where((element) => element.assignee.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.isReadByAssignee == false).length;
    }
    if (columnName == 'My Tasks') {
      tasklist = controller.items.where((element) => element.assignee.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.taskStatus.isDone == false && element.isReadByAssignee).length;
    }
     if (columnName == 'Created New') {
      tasklist = controller.items.where((element) => element.author.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.isReadByAssignee == false).length;
    }
    if (columnName == 'My Created Tasks') {
      tasklist = controller.items.where((element) => element.author.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount && element.taskStatus.isDone == false && element.isReadByAssignee).length;
    }
    if (columnName == 'Deadline') {
      tasklist = controller.items
          .where((element) =>
              element.assignee.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount &&
              ((element.dateDeadline.isBefore(DateTime.now())) ||
                  element.dateDeadline.day == DateTime.now().day ||
                  element.dateDeadline.day == DateTime.now().day + 1 ||
                  element.dateDeadline.day == DateTime.now().day + 2 ||
                  element.dateDeadline.day == DateTime.now().day + 3) &&
              element.dateDeadline.toString() != '1754-01-01 00:00:00.000' &&
              element.dateDeadline.toString() != '0001-01-01 00:00:00.000' &&
              !element.taskStatus.isDone)
          .length;
    }
     if (columnName == 'Deadline created') {
      tasklist = controller.items.where((element) =>
          element.author.mainUserAccount == serviceC.currentItem.userAccount.mainUserAccount &&
          ((element.dateDeadline.isBefore(DateTime.now())) ||
              element.dateDeadline.day == DateTime.now().day ||
              element.dateDeadline.day == DateTime.now().day + 1 ||
              element.dateDeadline.day == DateTime.now().day + 2 ||
              element.dateDeadline.day == DateTime.now().day + 3) &&
          element.dateDeadline.toString() != '1754-01-01 00:00:00.000' &&
          element.dateDeadline.toString() != '0001-01-01 00:00:00.000' &&
          !element.taskStatus.isDone).length;
    }

    return Text(
      tasklist.toString(),
      style: const TextStyle(fontFamily: 'Inter', fontSize: 16, color: Color(0xff529FBF)),
    );
  }
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

class TaskItemView extends StatelessWidget {
  TaskItemView({super.key, required this.task, this.searchvalue});

  final TaskDoc task;
  final String? searchvalue;
  var controller = Get.find<TaskListController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          Get.find<TaskFilesController>().requestItems();
          controller.setAndRefreshSelectedItem(task, [TaskDocGenerated.nameFiles]);
          controller.itemPageOpen(task, Routes.taskPageFortaskList, needRefreshSelectedItem: true);
        },
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffEDEFF3),
                      border: Border(
                        left: BorderSide(color: getTaskPriorityColor(task.priority), width: 7),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: SubstringHighlight(
                                        maxLines: 2,
                                        text: task.name,
                                        term: searchvalue,
                                        textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 16, color: Colors.black),
                                        textStyleHighlight: const TextStyle(color: Colors.deepOrange),
                                      )),
                                ),
                              ),

                              // Align(
                              //   alignment: AlignmentDirectional.topEnd,
                              //   child: GestureDetector(
                              //     onTapDown: (TapDownDetails details) {},
                              //     child: const Icon(Icons.more_vert),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Status: ${task.taskStatus}', style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF))),
                                Text('Aut.: ${task.author.name}', style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF))),
                                Text('Assig.: ${task.assignee.name}', style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF))),
                                Text('Proj.: ${task.project}', style: const TextStyle(fontFamily: 'Inter', fontSize: 10, color: Color(0xff529FBF))),
                              ],
                            )),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            ClipOval(
                                child: task.assignee.photoName.isEmpty
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
                                    : Image.network(
                                        TaskFilesController.getFilePath(task.assignee.photoName),
                                        fit: BoxFit.cover,
                                        width: 32,
                                        height: 32,
                                      )),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
