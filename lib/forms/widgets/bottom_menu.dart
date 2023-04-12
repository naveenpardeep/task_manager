
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/organization/organization_controller.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/forms/user_account/service_object_controller.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';
import 'package:task_manager_app/model/data_controller.dart';

import '../../app_pages.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({super.key, this.menuItems = const []});

  final List<NsgBottomMenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NsgBottomMenuItem(
          'Проекты',
          icon: Icons.folder,
          link: Routes.projectListPage,
          controller: Get.find<ProjectController>(),
        ),
        NsgBottomMenuItem(
          'Задачи',
          icon: Icons.task,
          link: Routes.tasksListPage,
          controller: Get.find<TasksController>(),
        ),
        NsgBottomMenuItem(
          'Компании',
          icon: Icons.apartment,
          link: Routes.organizationListMobilePage,
          controller: Get.find<OrganizationController>(),
        ),
        NsgBottomMenuItem(
          'Аккаунт',
          icon: Icons.photo,
          isProfileItem: true,
          link: Routes.profileViewPage,
          controller: Get.find<UserAccountController>(),
        ),
      ],
    );
  }
}

enum MenuItemType { profile, icon }

class NsgBottomMenuItem extends StatefulWidget {
  final String text;
  final bool isProfileItem;
  final IconData icon;
  final String link;
  final int? count;
  final NsgDataController? controller;
  const NsgBottomMenuItem(this.text, {super.key, required this.icon, required this.link, this.count, this.controller, this.isProfileItem = false});

  @override
  State<NsgBottomMenuItem> createState() => _NsgBottomMenuItemState();
}

class _NsgBottomMenuItemState extends State<NsgBottomMenuItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.link == Get.currentRoute;
    return Expanded(
        child: InkWell(
      onTap: () {
          Get.find<ServiceObjectController>().selectedItem=null;
        if (widget.controller != null) {
          widget.controller!.refreshData();
          if (widget.controller!.currentItem.isNotEmpty) {
            widget.controller?.itemPageOpen(widget.controller?.currentItem as NsgDataItem, widget.link, needRefreshSelectedItem: true);
          } else {
            widget.controller?.itemPageOpen(widget.controller?.currentItem as NsgDataItem, widget.link);
          }
        } else {
          Get.offAndToNamed(widget.link);
        }
        //Get.find<DataController>().setCurrentProfile();
        //Get.find<ProfileItemController>().profileItem = null;
        //
      },
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          height: 65,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  children: [
                    if (!widget.isProfileItem)
                      Icon(
                        widget.icon,
                        color: isSelected ? ControlOptions.instance.colorMain : ControlOptions.instance.colorMainLight,
                        size: 32,
                      ),
                    if (widget.isProfileItem) ClipOval(child: getPhoto()),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        widget.text,
                        style: TextStyle(
                            fontSize: ControlOptions.instance.sizeXS,
                            color: isSelected ? ControlOptions.instance.colorMain : ControlOptions.instance.colorMainLight),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.count != null)
                Container(
                  margin: const EdgeInsets.only(left: 32, top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  decoration: BoxDecoration(
                      color: isSelected ? ControlOptions.instance.colorMain : ControlOptions.instance.colorGreyDark, borderRadius: BorderRadius.circular(3)),
                  child: Text(
                    '${widget.count}',
                    style: TextStyle(fontSize: ControlOptions.instance.sizeXS, color: ControlOptions.instance.colorMainText),
                  ),
                ),
            ],
          )),
    ));
  }

  Widget getPhoto() {
    //Get.find<DataController>().currentUser;
    var userAccountController = Get.find<UserAccountController>();
    if (userAccountController.currentItem.photoName.isNotEmpty) {
      return Image.network(
        DataController.getFilePath(userAccountController.currentItem.photoName),
        width: 32,
        height: 32,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        width: 32,
        height: 32,
        //padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: ControlOptions.instance.colorMainLighter,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add_a_photo,
          color: ControlOptions.instance.colorMainLight,
          size: ControlOptions.instance.sizeXL,
        ),
      );
    }
  }
}
