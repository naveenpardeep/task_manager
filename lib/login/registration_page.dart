import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/authorize/nsgPhoneLoginRegistrationPage.dart';
import 'package:nsg_data/nsg_data.dart';
import 'login_page.dart';

class RegistrationPage extends NsgPhoneLoginRegistrationPage {
  RegistrationPage(NsgDataProvider provider, {super.key}) : super(provider, widgetParams: NsgPhoneLoginParams.defaultParams);

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

  @override
  Widget getButtons() {
    return NsgButton(
        margin: EdgeInsets.zero,
        onPressed: () {
          sendData();
        },
        text: 'Получить код'.toUpperCase());
  }

  @override
  AppBar getAppBar(BuildContext context) {
    return AppBar(title: const Text('РЕГИСТРАЦИЯ'), centerTitle: true);
  }
}
