import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';
import 'package:task_manager_app/model/data_controller.dart';

import '../app_pages.dart';
import '../forms/user_account/user_account_controller.dart';

// ignore: must_be_immutable
class StartPage extends StatelessWidget {
  StartPage({super.key});

  var userC = Get.find<UserAccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //image: AssetImage('assets/images/start_page.png'),
            //fit: BoxFit.cover,
            //)
            ),
        child: Center(
            child: IntrinsicWidth(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Flexible(
                  child: Text(
                'Task Tuner -\nНастройся на рабочий лад',
                style: TextStyle(fontSize: ControlOptions.instance.sizeH3),
              )),
            ),
            TaskButton(
              style: TaskButtonStyle.dark,
              text: 'Начать!',
              onTap: () {
                Get.find<UserAccountController>().itemPageOpen(Get.find<DataController>().mainProfile, Routes.firstTimeUserAccountPage);
              },
            )
          ],
        ))),
      ),
    );
  }
}
