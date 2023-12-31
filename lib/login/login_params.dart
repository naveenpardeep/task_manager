import 'package:flutter/material.dart';
import 'package:nsg_data/nsg_data.dart';

import '../app_pages.dart';

class LoginParams extends NsgPhoneLoginParams {
  LoginParams()
      : super(
            mainPage: Routes.splashPage,
            cardColor: Colors.grey[100],
            buttonSize: 32,
            useEmailLogin: true,
            usePhoneLogin: true,
            usePasswordLogin: true,
            //headerMessage: 'TASK TUNER',
            headerMessageVisible: false,
            headerMessageLogin: 'Вход',
            headerMessageRegistration: 'Регистрация',
            headerMessageVerification: 'Введите проверочный код',
            //  descriptionMessegeVerification: 'Мы отправили проверочный код\nна ваш e-mail: {{phone}}',
            // textEnterPhone: 'Телефон',
            // textEnterEmail: 'E-mail',
            // textEnterPassword: 'Пароль',
            // textResendSms: 'Назад',
            // textSendSms: 'Отправить код',
            // textEnterCaptcha: 'Введите текст',
            textLoginSuccessful: 'Успешная авторизация',
            textCheckInternet: 'Проверьте интернет соединение',
            appbar: false,
            useCaptcha: false);

  @override
  String errorMessage(int statusCode) {
    String message;
    switch (statusCode) {
      case 40101:
        message = 'Необходимо получить капчу';
        break;
      case 40102:
        message = 'Капча устарела. Попробуйте снова!';
        break;
      case 40103:
        message = 'Неправильный текст капчи. Попробуйте снова!';
        break;
      case 40104:
        message = 'Введите E-mail!';
        break;
      case 40105:
        message = 'Неверный пароль';
        break;
      case 40300:
        message = 'Проверочный код неправильный. Попробуйте снова!';
        break;
      case 40301:
        message = 'Слишком много попыток ввода кода. Попробуйте снова!';
        break;
      case 40302:
        message = 'Код безопасности устарел';
        break;
      case 40303:
        message = 'Необходимо ввести код подтверждения';
        break;
      default:
        message = statusCode == 0 ? '' : 'Произошла ошибка $statusCode';
    }
    return message;
  }
}
