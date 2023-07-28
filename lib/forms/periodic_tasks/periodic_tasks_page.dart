import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_grid.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/periodic_tasks/periodic_tasks_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';
import 'package:task_manager_app/forms/widgets/bottom_menu.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../tasks/tasks_controller.dart';
import '../widgets/top_menu.dart';

class PeriodicTasksPage extends StatefulWidget {
  const PeriodicTasksPage({Key? key}) : super(key: key);
  @override
  State<PeriodicTasksPage> createState() => _PeriodicTasksPageState();
}

class _PeriodicTasksPageState extends State<PeriodicTasksPage> {
  var controller = Get.find<PeriodicTasksController>();
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late double width;
  var textEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }

    width = MediaQuery.of(context).size.width;
    return controller.obx(
      (state) => SafeArea(
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
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: SizedBox(
                                child: TTNsgInput(
                                  infoString: 'Select Project',
                                  selectionController: Get.find<ProjectController>(),
                                  dataItem: Get.find<ServiceObjectController>().currentItem,
                                  fieldName: ServiceObjectGenerated.nameProjectId,
                                  onEditingComplete: (p0, p1) {
                                    controller.refreshData();
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                height: 37,
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
                        ],
                      )),
                  Expanded(
                      child: RefreshIndicator(
                    onRefresh: () {
                      return controller.refreshData();
                    },
                    child: RawScrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        controller: scrollController,
                        thickness: width > 700 ? 10 : 0,
                        trackBorderColor: ControlOptions.instance.colorGreyLight,
                        trackColor: ControlOptions.instance.colorGreyLight,
                        thumbColor: ControlOptions.instance.colorPrimary.withOpacity(0.2),
                        radius: const Radius.circular(0),
                        child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            child: controller.obx((state) {
                              return width > 500 ? NsgGrid(crossAxisCount: width ~/ 200, children: showTasks()) : Column(children: showTasks());
                            }))),
                  )),
                  if (width < 700) const BottomMenu(),
                ],
              )),
        ),
      ),
    );
  }

  List<Widget> showTasks() {
    List<Widget> list = [];
    var periodicTasks = controller.items;
    for (var task in periodicTasks) {
      if (task.name.toString().toLowerCase().contains(textEditController.text.toLowerCase())) {
        list.add(TaskItemView(
          task: task,
          searchvalue: textEditController.text,
        ));
      }
    }
    return list;
  }
}

class TaskItemView extends StatelessWidget {
  const TaskItemView({super.key, required this.task, this.searchvalue});

  final TaskDoc task;
  final String? searchvalue;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PeriodicTasksController>();
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: InkWell(
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          Get.find<PeriodicTaskCheckListController>().requestItems();
          Get.find<TasksController>().isPeriodicController = true;
          controller.itemPageOpen(task, Routes.taskEditPage);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xffEDEFF3),
          ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
              ),
              Expanded(
                child: LinearPercentIndicator(
                  key: GlobalKey(),
                  center: Text(
                    ('${(task.periodicLastClosed.day / task.periodicActualUntil.day * 100).toStringAsFixed(2)}%'),
                    style: const TextStyle(color: Colors.white),
                  ),
                  lineHeight: 20,
                  percent: task.periodicLastClosed.day / task.periodicActualUntil.day,
                  backgroundColor: const Color.fromARGB(255, 207, 200, 200),
                  progressColor: task.periodicLastClosed.day / task.periodicActualUntil.day * 100 == 100 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
