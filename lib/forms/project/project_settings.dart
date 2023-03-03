import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/forms/project/projectUserMobile.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';
import 'package:task_manager_app/forms/project/project_page_main.dart';
import 'package:task_manager_app/forms/project/project_page_tables.dart';
import 'package:task_manager_app/forms/project/project_page_users.dart';

import '../../app_pages.dart';

class ProjectSettings extends StatefulWidget {
  const ProjectSettings({super.key});

  @override
  State<ProjectSettings> createState() => _ProjectSettingsState();
}

class _ProjectSettingsState extends State<ProjectSettings> with TickerProviderStateMixin {
  late TabController _tabController;

  var projectController = Get.find<ProjectController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                if (projectController.currentItem.name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пожалуйста, введите название проекта ')));
                } else {
                  projectController.itemPagePost();
                }
              },
              icon: const Icon(Icons.check)),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0, //Shadow gone
        centerTitle: true,
        title: Text(
          projectController.currentItem.isEmpty ? 'Новый проект'.toUpperCase() : projectController.currentItem.name.toString().toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
            onTap: (value) {
              setState(() {
                if (_tabController.index == 0) {
                  _tabController.index = 0;
                } else if (_tabController.index == 1) {
                  _tabController.index = 1;
                } else if (_tabController.index == 2) {
                  _tabController.index = 2;
                }
              });
            },
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                child: Text(
                  'Основное',
                  style: TextStyle(color: Color(0xff3EA8AB)),
                ),
              ),
              Tab(
                  child: Text(
                'Доски',
                style: TextStyle(color: Color(0xff3EA8AB)),
              )),
              Tab(
                child: Text(
                  'Участники',
                  style: TextStyle(color: Color(0xff3EA8AB)),
                ),
              ),
            ]),
      ),
      body: projectController.obx(
        // ignore: prefer_const_literals_to_create_immutables
        (state) => TabBarView(controller: _tabController, children: [
          const ProjectPage(),
          const ProjectPageTables(),
          const ProjectUserMobile(),
        ]),
      ),
    ));
  }
}
