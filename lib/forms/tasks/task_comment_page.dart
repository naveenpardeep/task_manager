import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class TasksCommentRowPage extends GetView<CommentTableTasksController> {
  const TasksCommentRowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            NsgText(controller.currentItem.text),
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
                                        onPressed: () {
                                          Get.find<TasksController>()
                                              .itemPagePost(goBack: false);
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
}
