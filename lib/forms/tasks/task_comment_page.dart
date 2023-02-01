import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class TasksCommentRowPage extends GetView<CommentTableTasksController> {
  const TasksCommentRowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }
    double height = MediaQuery.of(context).size.height;
    return BodyWrap(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                NsgAppBar(
                  backColor: ControlOptions.instance.colorWhite,
                  text: 'комментарий',
                  icon: Icons.arrow_back_ios_new,
                  colorsInverted: true,
                  bottomCircular: true,
                  onPressed: () {
                    controller.itemPageCancel();
                  },
                  // icon2: Icons.check,
                  // onPressed2: () {
                  //   controller.itemPagePost();
                  // },
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  height: height * 0.7, child: commentList()),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Stack(
                                children: [
                                  NsgInput(
                                    dataItem: controller.currentItem,
                                    fieldName:
                                        TaskDocCommentsTableGenerated.nameText,
                                    label: 'Комментарий',
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () async {
                                          controller.itemPagePost(
                                              goBack: false);
                                          Get.find<TasksController>()
                                              .itemPagePost(goBack: false);
                                          //   Get.find<TasksController>().sendNotify();
                                          controller.sendNotify();
                                        },
                                        icon: const Icon(Icons.send)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commentList() {
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];
    var taskConstroller = Get.find<TasksController>();
    var userCon = Get.find<UserAccountController>();
    var comments = controller.items;

    for (var comment in comments) {
      {
        list.add(GestureDetector(
          child: Container(
            color: ControlOptions.instance.colorGreyLighter,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.author.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(comment.text),
                        Text(
                          'создано: ${formateddate.format(comment.date)}',
                          maxLines: 1,
                          textScaleFactor: 0.8,
                          style: const TextStyle(color: Color(0xff10051C)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
