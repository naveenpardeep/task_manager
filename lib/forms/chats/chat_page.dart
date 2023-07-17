import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_circle.dart';
import 'package:nsg_data/helpers/nsg_data_format.dart';
import 'package:task_manager_app/forms/chats/chat_controller.dart';
import 'package:task_manager_app/forms/chats/chat_open_page.dart';
import 'package:task_manager_app/forms/chats/chat_tasklist_controller.dart';
import 'package:task_manager_app/forms/notification/notification_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var controller = Get.find<ChatController>();
  var tasklistCont = Get.find<ChatTaskListController>();
  var notificationController = Get.find<NotificationController>();
  var datacontroller = Get.find<DataController>();
  var textEditController = TextEditingController();
  var scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (controller.lateInit) {
      controller.requestItems();
    }
    if (tasklistCont.lateInit) {
      tasklistCont.requestItems();
    }
    if (notificationController.lateInit) {
      notificationController.requestItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Chats'),
          ),
          body: TwoPane(
            padding: const EdgeInsets.all(10),
            paneProportion: 0.3,
            startPane: Container(
                color: const Color(0xffEDEFF3),
                child: Column(
                  children: [
                    SizedBox(
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
                                    setState(() {});
                                    textEditController.clear();
                                  }),
                                  icon: const Icon(Icons.cancel)),
                              hintText: 'Search ...'),
                          textAlignVertical: TextAlignVertical.bottom,
                          style: TextStyle(color: ControlOptions.instance.colorMainLight, fontFamily: 'Inter', fontSize: 16),
                          onChanged: (val) {
                            setState(() {});
                          }),
                    ),
                    Expanded(
                      child: tasklistCont.obx((state) => RawScrollbar(
                          thumbVisibility: true,
                          trackVisibility: true,
                          controller: scrollController,
                          thickness: 10,
                          trackBorderColor: ControlOptions.instance.colorGreyLight,
                          trackColor: ControlOptions.instance.colorGreyLight,
                          thumbColor: ControlOptions.instance.colorMain.withOpacity(0.2),
                          radius: const Radius.circular(0),
                          child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  getAllTaskWithComments(context),
                                  // if (tasklistCont.totalCount! >= tasklistCont.totalcounttask)
                                  //   TextButton(
                                  //       onPressed: () {
                                  //         tasklistCont.totalcounttask = 100 + tasklistCont.totalcounttask;
                                  //         tasklistCont.tasktop = 100 + tasklistCont.tasktop;
                                  //         tasklistCont.refreshData();
                                  //       },
                                  //       child: const Text('Load more')),
                                  // if (tasklistCont.totalCount! <= tasklistCont.totalcounttask)
                                  //   TextButton(
                                  //       onPressed: () {
                                  //         tasklistCont.totalcounttask = 100;
                                  //         tasklistCont.tasktop = 0;
                                  //         tasklistCont.refreshData();
                                  //       },
                                  //       child: const Text('Reset')),
                                  tasklistCont.obx((state) => tasklistCont.pagination(), onLoading: const SizedBox()),
                                ],
                              )))),
                    )
                  ],
                )),
            endPane: Padding(padding: const EdgeInsets.all(16.0), child: controller.obx((state) => const ChatOpenPage())),
            panePriority: TwoPanePriority.both,
          ),
        ),
      ),
    );
    // );
  }

  Widget getAllTaskWithComments(context) {
    List<Widget> taskList = [];
    double width = MediaQuery.of(context).size.width;
    //   DateFormat formateddate = DateFormat("dd.MM.yyyy   HH:mm");

    for (var tasks in tasklistCont.items) {
      if (tasks.name.toString().toLowerCase().contains(textEditController.text.toLowerCase())) {
        taskList.add(InkWell(
          onTap: () {
            Get.find<ChatTaskListController>().currentItem = tasks;
              tasklistCont.refreshItem(tasks, [ChatItemGenerated.nameNumberOfUnreadMessages]);
            // tasklistCont.setAndRefreshSelectedItem(tasks, [ChatItemGenerated.nameNumberOfUnreadMessages]);

            controller.sendNotify();

            setState(() {});
            tasklistCont.sendNotify();
          },
          child: Card(
            child: Container(
              color: tasklistCont.currentItem.id == tasks.id ? const Color.fromARGB(255, 220, 217, 245) : Colors.white,
              width: width,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tasks.name.toString(),
                            maxLines: 1,
                          ),
                        ),
                        if (tasks.numberOfUnreadMessages.isGreaterThan(0))
                          NsgCircle(
                            height: 20,
                            width: 20,
                            fontSize: 10,
                            text: tasks.numberOfUnreadMessages.toString(),
                          ),
                        // if (notificationController.items.where((element) => element.chatId == tasks.id).isNotEmpty)
                        //   notificationController.obx(
                        //     (state) => NsgCircle(
                        //       text: notificationController.items.where((element) => element.chatId == tasks.id).first.chatNumberOfUnreadMessages.toString(),
                        //     ),
                        //  )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Project: ${tasks.project.name}",
                            maxLines: 1,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        Text(
                          getDate(tasks),
                          maxLines: 1,
                          style: const TextStyle(fontSize: 10, fontFamily: 'Inter', color: Color(0xfff3ea8ab)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }
    }
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: taskList,
      ),
    );
  }

  String getDate(ChatItem tasks) {
    var todayDate = DateTime.now();
    final lastDate = tasks.dateLastMessage;
    var daysleft = todayDate.difference(lastDate).inDays;
    if (daysleft > 7) {
      return '${NsgDateFormat.dateFormat(tasks.dateLastMessage, format: 'dd.MM.yy HH:mm')}';
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
}
