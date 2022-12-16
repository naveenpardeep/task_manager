import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nsg_controls/formfields/nsg_input.dart';
import 'package:nsg_controls/formfields/nsg_input_type.dart';
import 'package:nsg_controls/nsg_selection.dart';
import 'package:task_manager_app/forms/project/project_controller.dart';

import '../model/generated/project_item.g.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String projectName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projectName;
  }

  var projectController = Get.find<ProjectController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            Image.asset(
              'lib/assets/images/logo.png',
              height: 70,
            ),
          ],
          backgroundColor: const Color(0xff7876D9),
          flexibleSpace:
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  child: Row(
                    children: const [
                      Text(
                        'Проекты',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                  onPressed: () {
                    var form = NsgSelection(
                      inputType: NsgInputType.reference,
                      controller: projectController,
                    );
                    form.selectFromArray(
                      'Проекты',
                      (item) {
                        var row = ProjectItemGenerated();
                        // row.name = item as ProjectItem;
                        setState(() {
                          projectName = projectController.currentItem.name;
                        });

                        projectController.sendNotify();
                      },
                    );
                  },
                )),
            const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Все заявки",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
            const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Мои задачи",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )),
          ])),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                projectName.isEmpty ? 'Select Project' : projectName,
                textScaleFactor: 1.4,
              )),
        ],
      ),
    );
  }
}
