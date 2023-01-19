import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import '../../app_pages.dart';

class TmMobileMenu extends StatelessWidget {
  const TmMobileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(color: ControlOptions.instance.colorGrey),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed(Routes.projectListPage);
            },
            child: Icon(
              Icons.hub,
              color: ControlOptions.instance.colorMain,
              size: 32,
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed(Routes.tasksListPage);
            },
            child: Icon(
              Icons.task,
              color: ControlOptions.instance.colorMain,
              size: 32,
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed(Routes.userAccountListPage);
            },
            child: Icon(
              Icons.groups,
              color: ControlOptions.instance.colorMain,
              size: 32,
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed(Routes.invitationPage);
            },
            child: Icon(
              Icons.insert_invitation,
              color: ControlOptions.instance.colorMain,
              size: 32,
            ),
          )),
          Expanded(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.network(
                        width: 32,
                        height: 32,
                        'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2080&q=80'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
