import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';

class UserAccountListPage extends GetView<UserAccountController> {
  UserAccountListPage({Key? key}) : super(key: key);

  final _textTitle = 'Список пользователей'.toUpperCase();
  final _textNoItems = 'Нет пользователя';
  final _elementPage = Routes.userAccount;

  @override
  Widget build(BuildContext context) {
    return NsgListPage(
        appBarColor: Colors.white,
        type: NsgListPageMode.table,
        controller: controller,
        title: _textTitle,
        textNoItems: _textNoItems,
        appBarIcon2: Icons.check,
         appBarOnPressed2: () {
                    controller.itemPagePost();
                  },
        elementEditPage: _elementPage,
        availableButtons: const [
          NsgTableMenuButtonType.createNewElement,
          NsgTableMenuButtonType.editElement
        ],
        columns: [
          NsgTableColumn(
              name: UserAccountGenerated.nameName,
              expanded: true,
              presentation: 'Наименование'),
        ]);
  }
}
