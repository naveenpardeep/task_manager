// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/task_comment/task_comment_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/tt_nsg_input.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class TasksCommentPage extends GetView<TaskCommentsController> {
  const TasksCommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.lateInit) {
      controller.requestItems();
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Column(
            children: <Widget>[
              Expanded(child: SingleChildScrollView(reverse: true, child: commentList(context))),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 5),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      autofocus: true,
                      onKey: (event) async {
                        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                          await controller.itemPagePost(goBack: false);

                          await controller.createNewItemAsync();
                        }
                      },
                      child: TTNsgInput(
                        borderRadius: 10,
                        dataItem: controller.currentItem,
                        fieldName: TaskCommentGenerated.nameText,
                        label: '',
                        infoString: 'Комментарий',
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                          onPressed: () async {
                            await controller.itemPagePost(goBack: false);

                            await controller.createNewItemAsync();
                          },
                          icon: const Icon(Icons.send_rounded)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commentList(context) {
    double width = MediaQuery.of(context).size.width;

    List<Widget> list = [];
    var scrollController = ScrollController();
    Get.find<UserAccountController>();
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
              if (Get.find<DataController>().currentUser == comment.author.mainUserAccount) {
                showEditDelete(context, comment);
              }
            },
            child: Stack(
              children: [
                Get.find<DataController>().currentUser == comment.author.mainUserAccount
                    ? currentUser(context, comment, width)
                    : anotherUsers(context, comment, width)
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
            reverse: true,
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: list,
              ),
            )));
  }

  showEditDelete(BuildContext context, TaskComment comment) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // set up the button
    Widget edit = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        // elevation: 3,
        minimumSize: Size(width, height * 0.08),
      ),
      child: const Text("Edit"),
      onPressed: () {
        controller.currentItem.text = comment.text;

        controller.itemPageOpen(comment, Routes.newTaskPage);
        controller.sendNotify();

        Navigator.of(context).pop();
      },
    );
    Widget delete = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        // elevation: 3,
        minimumSize: Size(width, height * 0.08),
      ),
      child: const Text("Delete"),
      onPressed: () async {
        controller.currentItem = comment;
        await controller.deleteItems([controller.currentItem]);

        controller.refreshData();

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actions: [edit, delete],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget currentUser(context, comment, width) {
    DateFormat formateddate = DateFormat("dd.MM.yyyy   HH:mm");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? const Color(0xfff0859ff) : const Color(0xfffdbeaea),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(0), bottomLeft: Radius.circular(10))),
              width: width <= 700 ? width * 0.65 : 300,
              child: Column(
                crossAxisAlignment:
                    Get.find<DataController>().currentUser == comment.author.mainUserAccount ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        comment.author.toString(),
                        style: Get.find<DataController>().currentUser == comment.author.mainUserAccount
                            ? const TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white)
                            : const TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        comment.text,
                        softWrap: true,
                        style: Get.find<DataController>().currentUser == comment.author.mainUserAccount
                            ? const TextStyle(fontFamily: 'NotoSans', fontSize: 14, color: Colors.white)
                            : const TextStyle(fontFamily: 'NotoSans', fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? Alignment.topRight : Alignment.topRight,
                      child: Text(
                        formateddate.format(comment.date),
                        maxLines: 1,
                        // textScaleFactor: 0.8,
                        style: Get.find<DataController>().currentUser == comment.author.mainUserAccount
                            ? const TextStyle(fontSize: 10, fontFamily: 'Inter', color: Colors.white70)
                            : const TextStyle(fontSize: 10, fontFamily: 'Inter', color: Color(0xfff3ea8ab)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showuser(context, comment);
          },
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipOval(
                child: comment.author.photoName.isEmpty
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
                              TaskFilesController.getFilePath(comment.author.photoName),
                              fit: BoxFit.cover,
                              width: 32,
                              height: 32,
                            ),
              )),
        ),
        const SizedBox(
          height: 70,
        )
      ],
    );
  }

  showuser(BuildContext context, TaskComment comment) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(comment.author.toString()),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(4.0),
                child: comment.author.photoName.isEmpty
                    ? Container(
                        decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.account_circle,
                          size: 20,
                          color: ControlOptions.instance.colorMain.withOpacity(0.4),
                        ),
                      )
                    : Image.network(
                              TaskFilesController.getFilePath(comment.author.photoName),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),),
            Text(comment.author.phoneNumber),
            Text(comment.author.email)
          ],
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

  Widget anotherUsers(context, comment, width) {
    DateFormat formateddate = DateFormat("dd.MM.yyyy   HH:mm");
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showuser(context, comment);
            },
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipOval(
                  child: comment.author.photoName.isEmpty
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
                              TaskFilesController.getFilePath(comment.author.photoName),
                              fit: BoxFit.cover,
                              width: 32,
                              height: 32,
                            ),
                )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? const Color(0xfff0859ff) : const Color(0xfffdbeaea),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(0))),
                width: width <= 700 ? width * 0.65 : 300,
                child: Column(
                  crossAxisAlignment:
                      Get.find<DataController>().currentUser == comment.author.mainUserAccount ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          comment.author.toString(),
                          style: Get.find<DataController>().currentUser == comment.author.mainUserAccount
                              ? const TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white)
                              : const TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          comment.text,
                          softWrap: true,
                          style: Get.find<DataController>().currentUser == comment.author.mainUserAccount
                              ? const TextStyle(fontFamily: 'NotoSans', fontSize: 14, color: Colors.white)
                              : const TextStyle(fontFamily: 'NotoSans', fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? Alignment.topRight : Alignment.topRight,
                        child: Text(
                          formateddate.format(comment.date),
                          maxLines: 1,
                          //  textScaleFactor: 0.8,
                          style: Get.find<DataController>().currentUser == comment.author.mainUserAccount
                              ? const TextStyle(fontSize: 10, fontFamily: 'Inter', color: Colors.white70)
                              : const TextStyle(fontSize: 10, fontFamily: 'Inter', color: Color(0xfff3ea8ab)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ]);
  }
}
