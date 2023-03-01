import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_button.dart';
import 'package:nsg_controls/nsg_control_options.dart';
import 'package:nsg_data/nsg_data.dart';

import 'login_params.dart';

class LoginPage extends NsgPhoneLoginPage {
  LoginPage(NsgDataProvider provider, {super.key}) : super(provider, widgetParams: LoginPage.getWidgetParams(), loginType: NsgLoginType.email);

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
  //     image: AssetImage('/assets/images/titan-back.png'),
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
      text: 'Получить СМС'.toUpperCase(),
    );
  }

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(title: Text('Регистрация'.toUpperCase()), centerTitle: true);
  }

  static NsgPhoneLoginParams getWidgetParams() {
    return LoginParams();
  }
}
