import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import '../../app_pages.dart';

class TmTopMenu extends StatelessWidget {
  const TmTopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ControlOptions.instance.colorMain),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.projectListPage);
                      },
                      child: Text(
                        'Проекты',
                        style: TextStyle(
                            color: ControlOptions.instance.colorMainText,
                            fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.tasksListPage);
                      },
                      child: Text(
                        'Задачи',
                        style: TextStyle(
                            color: ControlOptions.instance.colorMainText,
                            fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.userAccountListPage);
                      },
                      child: Text(
                        'Пользователи',
                        style: TextStyle(
                            color: ControlOptions.instance.colorMainText,
                            fontSize: ControlOptions.instance.sizeXL),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.invitationPage);
                      },
                      child: Icon(
                        Icons.insert_invitation_sharp,
                        color: ControlOptions.instance.colorMainText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2, color: ControlOptions.instance.colorMainText)),
            child: ClipOval(
              child: Image.network(
                  width: 32,
                  height: 32,
                  'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80'),
            ),
          ),
        ],
      ),
    );
  }
}
