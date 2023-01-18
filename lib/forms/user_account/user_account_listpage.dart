import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/controllers/nsg_controller_regime.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/forms/widgets/top_menu.dart';
import 'package:task_manager_app/model/data_controller_model.dart';
import '../../app_pages.dart';

class UserAccountListPage extends GetView<UserAccountController> {
  UserAccountListPage({Key? key}) : super(key: key);

  final _textTitle = 'Список пользователей'.toUpperCase();
  final _textNoItems = 'Нет пользователя';
  final _elementPage = Routes.userAccount;

  @override
  Widget build(BuildContext context) {
    return BodyWrap(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Get.find<UserAccountController>().regime != NsgControllerRegime.selection) TmTopMenu(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                Get.find<UserAccountController>().regime != NsgControllerRegime.selection
                    ? 'Все пользователи'
                    : 'Выберите пользователя',
                style: TextStyle(fontSize: ControlOptions.instance.sizeXL),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: NsgListPage(
                   appBar: SizedBox(),
                    appBarColor: Colors.white,
                    type: NsgListPageMode.table,
                    controller: controller,
                   title: '',
                    textNoItems: '',
                    appBarIcon:  Icons.arrow_back_ios_new,
                    appBarOnPressed: ()  {
                   controller.currentItem.isEmpty;
                   Get.back();
            
                      
                    },
                     appBarIcon2: null,
                    // appBarOnPressed2: () {
                    //   controller.itemPagePost();
                    // },
                    elementEditPage: _elementPage,
                  
                    availableButtons:  [
                      if(Get.find<UserAccountController>().regime != NsgControllerRegime.selection)
                  
                      NsgTableMenuButtonType.createNewElement,
                      if(Get.find<UserAccountController>().regime != NsgControllerRegime.selection)
                  
                      NsgTableMenuButtonType.editElement,
                      if(Get.find<UserAccountController>().regime != NsgControllerRegime.selection)
                  
                      NsgTableMenuButtonType.removeElement
                    ]
                   
                
                    ,
                    columns: [
                      NsgTableColumn(name: UserAccountGenerated.nameName, expanded: true, presentation: 'Наименование'),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
