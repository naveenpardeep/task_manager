import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/widgets/task_tuner_button.dart';

import '../app_pages.dart';
import '../forms/invitation/invitation_controller.dart';

class LoginConfirmPage extends StatelessWidget {
  const LoginConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Профиль успешно создан',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/images/task_img.svg',
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'Ваш профиль был успешно создан!\nТеперь вы можете приступить к использованию планировщика задач Task Tuner',
                      style: TextStyle(fontSize: ControlOptions.instance.sizeM, fontFamily: 'Inter'),
                    )
                  ],
                )),
                Row(
                  children: [
                    Expanded(
                        child: TaskButton(
                      style: TaskButtonStyle.light,
                      text: 'Назад',
                      onTap: () {
                        Get.back();
                      },
                    )),
                    Expanded(
                        child: TaskButton(
                      text: 'Далее',
                      onTap: () async {
                        await Get.find<InvitationController>().requestItems();
                        Get.find<InvitationController>().itemNewPageOpen(Routes.acceptInvitationPage);
                      },
                    )),
                  ],
                ),
              ],
            )));
  }
}
