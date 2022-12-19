import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';


class UserAccountListPage extends GetView<UserAccountController> {
  UserAccountListPage({Key? key}) : super(key: key);

  final _textTitle = 'User'.toUpperCase();
  final _textNoItems = 'Нет элементов';
  final _elementPage = Routes.userAccount;

  @override
  Widget build(BuildContext context) {
    return NsgListPage(
        type: NsgListPageMode.table,
        controller: controller,
        title: _textTitle,
        textNoItems: _textNoItems,
        elementEditPage: _elementPage,
        columns: [
          NsgTableColumn(
              name: UserAccountGenerated.nameName,
              expanded: true,
              presentation: 'Наименование'),
        ]);
  }
}
