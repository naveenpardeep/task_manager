import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
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
                  SizedBox(height: height * 0.75, child: commentList(context)),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: NsgInput(
                          dataItem: controller.currentItem,
                          fieldName: TaskDocCommentsTableGenerated.nameText,
                          label: 'Комментарий',
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(
                              onPressed: () async {
                                await controller.itemPagePost(goBack: false);
                                await Get.find<TasksController>()
                                    .itemPagePost(goBack: false);
                                await controller.createNewItemAsync();
                                //   Get.find<TasksController>().sendNotify();
                                // controller.sendNotify();
                              },
                              icon: const Icon(Icons.send)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget commentList(context) {
    DateFormat formateddate = DateFormat("dd-MM-yyyy   HH:mm:ss");
    List<Widget> list = [];
    var scrollController = ScrollController();
    var userC = Get.find<UserAccountController>();
    var comments = controller.items;

    var author = <UserAccount>[];
    for (var element in comments) {
      author.add(element.author);
    }

    for (var comment in comments) {
      {
        list.add(GestureDetector(
          child: InkWell(
            onTap: () {
              if (Get.find<DataController>().currentUser ==
                  comment.author.mainUserAccount) {
                showAlertDialog(context, comment);
              }
              //   controller.currentItem.text = comment.text;
              //   controller.sendNotify();

              // //  if (controller.currentItem.authorId==userC.currentItem.id)
              //   {
              //  controller.itemPageOpen(comment, Routes.commentRowPage);
              //   }
            },
            child: Row(
              mainAxisAlignment: Get.find<DataController>().currentUser ==
                      comment.author.mainUserAccount
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                  color: ControlOptions.instance.colorGreyLighter,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          comment.author.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(comment.text),
                        Text(
                          formateddate.format(comment.date),
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

    return RawScrollbar(
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
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: list,
              ),
            )));
  }

  showAlertDialog(BuildContext context, comment) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () async {
        controller.currentItem.text = comment.text;

        //  if (controller.currentItem.authorId==userC.currentItem.id)
        {
          controller.itemPageOpen(comment, Routes.commentRowPage);
          controller.sendNotify();
        }
        Navigator.of(context).pop();
      },
    );
    Widget noButton = ElevatedButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Do you want to Edit?"),
      actions: [okButton, noButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
