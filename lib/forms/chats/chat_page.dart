import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/chats/chat_controller.dart';
import 'package:task_manager_app/forms/chats/chat_open_page.dart';
import 'package:task_manager_app/forms/chats/chat_tasklist_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var controller = Get.find<ChatController>();
  var tasklistCont = Get.find<ChatTaskListController>();
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
    // );
  }

  Widget getAllTaskWithComments(context) {
    List<Widget> taskList = [];
    double width = MediaQuery.of(context).size.width;
    DateFormat formateddate = DateFormat("dd.MM.yyyy   HH:mm");

    for (var tasks in tasklistCont.items) {
      if (tasks.name.toString().toLowerCase().contains(textEditController.text.toLowerCase())) {
        taskList.add(InkWell(
          onTap: () {
            Get.find<ChatTaskListController>().currentItem = tasks;
            controller.sendNotify();
            setState(() {});
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
                    Text(
                      tasks.name.toString(),
                      maxLines: 1,
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
                          formateddate.format(tasks.dateLastComment),
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
}
