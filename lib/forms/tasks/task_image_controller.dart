import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';

import '../../model/data_controller_model.dart';

class TaskImageController extends NsgFilePickerController<Picture> {
  TaskImageController() : super() {
    requestOnInit = false;
    autoRepeate = true;
    autoRepeateCount = 3;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var taskController = Get.find<TasksController>();

    cmp.add(name: PictureGenerated.nameOwnerId, value: taskController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }

  @override
  Future<Picture> fileObjectToDataItem(NsgFilePickerObject fileObject, File imageFile) async {
    var pic = Picture();
    pic.name = fileObject.description;
    pic.ownerId = Get.find<TasksController>().currentItem.id;
    pic.image = await imageFile.readAsBytes();
    return pic;
  }

  @override
  Future<NsgFilePickerObject> dataItemToFileObject(Picture dataItem) async {
    return NsgFilePickerObject(
        isNew: false, image: Image.memory(Uint8List.fromList(dataItem.image)), description: dataItem.name, fileType: 'jpg', id: dataItem.id);
  }

  @override
  Future refreshData({List<NsgUpdateKey>? keys}) async {
    await super.refreshData(keys: keys);
    images.clear();

    for (var element in items) {
      images.add(NsgFilePickerObject(
          isNew: false, image: Image.memory(Uint8List.fromList(element.image)), description: element.name, fileType: 'jpg, mp4', id: element.id));
    }
    return;
  }
}
