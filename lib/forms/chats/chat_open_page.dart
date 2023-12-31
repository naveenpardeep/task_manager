// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/app_pages.dart';
import 'package:task_manager_app/forms/chats/chat_controller.dart';
import 'package:task_manager_app/forms/chats/chat_tasklist_controller.dart';
import 'package:task_manager_app/forms/tasks/task_file_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';

class ChatOpenPage extends StatefulWidget {
  const ChatOpenPage({Key? key}) : super(key: key);
  @override
  State<ChatOpenPage> createState() => _ChatOpenPageState();
}

class _ChatOpenPageState extends State<ChatOpenPage> {
  var controller = Get.find<ChatController>();
  var taskcontroller = Get.find<ChatTaskListController>();
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  bool isReply = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.toString()
      ..selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (controller.lateInit) {
      controller.requestItems();
    }
    if (taskcontroller.lateInit) {
      taskcontroller.requestItems();
    }

    return SafeArea(
      child: Scaffold(
        appBar: width < 700
            ? AppBar(
                backgroundColor: Colors.white,
                title: const Text('Chat'),
                leading: IconButton(
                    onPressed: () {
                      taskcontroller.selectedItem = null;
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              )
            : null,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) => Column(
            children: <Widget>[
              Animate(effects: const [FlipEffect()], child: Expanded(child: SingleChildScrollView(reverse: true, child: commentList(context)))),
              Offstage(
                offstage: !isReply,
                child: getRepylMessage(),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (width > 700)
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipOval(
                          child: Get.find<DataController>().currentUser.photoName.isEmpty
                              ? Container(
                                  decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(0.2)),
                                  width: 48,
                                  height: 48,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 20,
                                    color: ControlOptions.instance.colorMain.withOpacity(0.4),
                                  ),
                                )
                              : Image.network(
                                  TaskFilesController.getFilePath(Get.find<DataController>().currentUser.photoName),
                                  fit: BoxFit.fill,
                                  width: 48,
                                  height: 48,
                                ),
                        )),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IconButton(
                      iconSize: width > 700 ? 40 : 28,
                      onPressed: () {
                        setState(() {
                          emojiShowing = !emojiShowing;
                        });
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Color.fromARGB(255, 250, 221, 60),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      autofocus: true,
                      onKey: (event) async {
                        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                          controller.currentItem.ownerId = taskcontroller.currentItem.ownerId;
                          controller.currentItem.text = _controller.text;
                          await controller.currentItem.post();
                          controller.items.add(controller.currentItem);
                          _controller.text = '';
                          isReply = false;

                          await controller.createNewItemAsync();
                          taskcontroller.currentItem.dateLastMessage = DateTime.now();
                          taskcontroller.requestItems();
                        }
                      },
                      // child: TTNsgInput(

                      //   borderRadius: 100,
                      //   dataItem: controller.currentItem,
                      //   fieldName: TaskCommentGenerated.nameText,
                      //   label: '',
                      //   infoString: 'Комментарий',
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                            controller: _controller,
                            style: const TextStyle(fontSize: 20.0, color: Colors.black87),
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.only(left: 10.0, bottom: 8.0, top: 8.0, right: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffABF4FF),
                      ),
                      child: IconButton(
                          onPressed: () async {
                            controller.currentItem.ownerId = taskcontroller.currentItem.ownerId;
                            controller.currentItem.text = _controller.text;

                            //  await controller.itemPagePost(goBack: false);

                            await controller.currentItem.post();
                            controller.items.add(controller.currentItem);
                            _controller.text = '';
                            isReply = false;

                            await controller.createNewItemAsync();
                            taskcontroller.currentItem.dateLastMessage = DateTime.now();
                            taskcontroller.requestItems();
                          },
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Color(0xff0859FF),
                            size: 15,
                          )),
                    ),
                  ),
                ],
              ),
              Offstage(
                offstage: !emojiShowing,
                child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      textEditingController: _controller,
                      onBackspacePressed: _onBackspacePressed,
                      config: Config(
                        columns: 7,
                        emojiSizeMax: 32 * (GetPlatform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        backspaceColor: Colors.blue,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        recentTabBehavior: RecentTabBehavior.RECENT,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: const Text(
                          'No Recents',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        loadingIndicator: const SizedBox.shrink(),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                        checkPlatformCompatibility: true,
                      ),
                    )),
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
        list.add(Stack(
          children: [
            Get.find<DataController>().currentUser == comment.author.mainUserAccount
                ? currentUser(context, comment, width)
                : anotherUsers(context, comment, width)
          ],
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

  Future<void> showPopUpMenu(Offset globalPosition, TaskComment comment, BuildContext context) async {
    double left = globalPosition.dx;
    double top = globalPosition.dy;
    double width = MediaQuery.of(context).size.width;

    await showMenu(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      color: const Color(0xffEDEFF3),
      context: context,
      position: RelativeRect.fromLTRB(left, top, left + 1, top + 1),
      items: [
        const PopupMenuItem(
          value: 1,
          child: Padding(
            padding: EdgeInsets.only(left: 0, right: 40),
            child: Text(
              "Reply",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        if (Get.find<DataController>().currentUser == comment.author.mainUserAccount)
          const PopupMenuItem(
            value: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 40),
              child: Text(
                "Edit",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        if (Get.find<DataController>().currentUser == comment.author.mainUserAccount)
          const PopupMenuItem(
            value: 3,
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 40),
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 1) {
        controller.currentItem.mainComment = comment;
        setState(() {
          isReply = true;
        });
      }
      if (value == 2) {
        _controller.text = comment.text;

        if (width > 700) {
          controller.itemPageOpen(comment, Routes.chatPage);
        }
        else{
          controller.itemPageOpen(comment, Routes.chatopenpage);
        }
        controller.sendNotify();
      }
      if (value == 3) {
        controller.currentItem = comment;
        controller.deleteItems([controller.currentItem]);
        controller.currentItem.text = '';
        controller.sendNotify();
      }
    });
  }

  Widget currentUser(context, TaskComment comment, width) {
    DateFormat formateddate = DateFormat("dd.MM.yyyy   HH:mm");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              showPopUpMenu(details.globalPosition, comment, context);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xfff0859ff),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(0), bottomLeft: Radius.circular(10))),
                width: width <= 700 ? width * 0.65 : 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(comment.author.toString(),
                            style: const TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white)),
                      ),
                    ),
                    if (comment.mainComment.isNotEmpty) getReply(comment),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          comment.text,
                          softWrap: true,
                          style: const TextStyle(fontFamily: 'NotoSans', fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(formateddate.format(comment.date),
                            maxLines: 1,
                            // textScaleFactor: 0.8,
                            style: const TextStyle(fontSize: 10, fontFamily: 'Inter', color: Colors.white70)),
                      ),
                    ),
                  ],
                ),
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
                        width: 48,
                        height: 48,
                        child: Icon(
                          Icons.account_circle,
                          size: 20,
                          color: ControlOptions.instance.colorMain.withOpacity(0.4),
                        ),
                      )
                    : Image.network(
                        TaskFilesController.getFilePath(comment.author.photoName),
                        fit: BoxFit.fill,
                        width: 48,
                        height: 48,
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
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(comment.author.toString()),
      content: SizedBox(
        height: 250,
        child: SingleChildScrollView(
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
                        fit: BoxFit.fill,
                        width: 200,
                        height: 200,
                      ),
              ),
              SelectableText(comment.author.phoneNumber),
              SelectableText(comment.author.email)
            ],
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

  Widget anotherUsers(context, comment, width) {
    DateFormat formateddate = DateFormat("dd.MM.yyyy   HH:mm");
    return Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.start, children: [
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
                      width: 48,
                      height: 48,
                      child: Icon(
                        Icons.account_circle,
                        size: 20,
                        color: ControlOptions.instance.colorMain.withOpacity(0.4),
                      ),
                    )
                  : Image.network(
                      TaskFilesController.getFilePath(comment.author.photoName),
                      fit: BoxFit.fill,
                      width: 48,
                      height: 48,
                    ),
            )),
      ),
      Flexible(
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            showPopUpMenu(details.globalPosition, comment, context);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xfffdbeaea),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(0))),
              width: width <= 700 ? width * 0.65 : 450,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        comment.author.toString(),
                        style: const TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  if (comment.mainComment.isNotEmpty) getReply(comment),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        comment.text,
                        softWrap: true,
                        style: const TextStyle(fontFamily: 'NotoSans', fontSize: 14),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        formateddate.format(comment.date),
                        maxLines: 1,
                        //  textScaleFactor: 0.8,
                        style: const TextStyle(fontSize: 10, fontFamily: 'Inter', color: Color(0xfff3ea8ab)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 70,
      )
    ]);
  }

  Widget getReply(TaskComment comment) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            color: Colors.green,
            width: 7,
          ),
          const SizedBox(width: 7),
          Expanded(child: buildReplyMessage(comment)),
        ],
      ),
    );
  }

  Widget buildReplyMessage(TaskComment comment) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                '${comment.mainComment.author}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? const Color.fromARGB(255, 7, 241, 46) : Colors.black,
                    fontSize: 13),
              ),
              Text(
                comment.mainComment.text.toString(),
                style: TextStyle(
                    color: Get.find<DataController>().currentUser == comment.author.mainUserAccount ? const Color.fromARGB(255, 3, 235, 243) : Colors.black,
                    fontSize: 13),
              ),
              // if (onCancelReply != null)
              //   GestureDetector(
              //     child: Icon(Icons.close, size: 16),
              //     onTap: onCancelReply,
              //   )
            ],
          ),
          const SizedBox(height: 7),
          //   Text(message.message, style: TextStyle(color: Colors.black54)),
        ],
      );

  Widget getRepylMessage() {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            color: Colors.green,
            width: 7,
          ),
          const SizedBox(width: 7),
          Expanded(child: buildReplyMessageTop()),
        ],
      ),
    );
  }

  Widget buildReplyMessageTop() => Row(
        children: [
          const Icon(
            Icons.forward,
            size: 30,
            color: Colors.green,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.currentItem.mainComment.author}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Text(
                  controller.currentItem.mainComment.text,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            child: const Icon(Icons.close, size: 30),
            onTap: () {
              isReply = false;
              setState(() {});
              controller.selectedItem = null;

              controller.refreshData();
            },
          )
        ],
      );
}
