import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/login/registration_page.dart';
import 'login_page.dart';

class VerificationPage extends NsgPhoneLoginVerificationPage {
  VerificationPage(NsgDataProvider provider, {super.key}) : super(provider, widgetParams: NsgPhoneLoginParams.defaultParams);

  @override
  Widget getLogo() {
    var logo = Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 160,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          ControlOptions.instance.colorMain.withOpacity(0),
          ControlOptions.instance.colorMain,
          ControlOptions.instance.colorMain.withOpacity(0),
        ])),
        child: Image.asset('lib/assets/logo.png'));
    return logo;
  }

  // @override
  // Image getBackground() {
  //   var background = const Image(
  //     image: AssetImage('lib/assets/titan-back.png'),
  //   );
  //   return background;
  // }

  @override
  Widget getButtons() {
    return NsgButton(
        margin: EdgeInsets.zero,
        onPressed: () {
          sendData();
        },
        text: 'Отправить код заново'.toUpperCase());
  }

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(title: const Text('РЕГИСТРАЦИЯ'), centerTitle: true);
  }
}
