import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/file_picker/nsg_file_picker_table_controller.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_error_widget.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:path/path.dart';

import '../../model/data_controller_model.dart';
import '../../model/options/server_options.dart';
import 'tasks_controller.dart';

class TaskFilesController extends NsgFilePickerTableController<TaskDocFilesTable> {
  TaskFilesController() : super(masterController: Get.find<TasksController>(), tableFieldName: TaskDocGenerated.nameFiles) {
    readOnly = false;
    editModeAllowed = true;
    requestOnInit = true;
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var taskController = Get.find<TasksController>();

    cmp.add(name: TaskDocFilesTableGenerated.nameOwnerId, value: taskController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }

  @override
  Future refreshData({List<NsgUpdateKey>? keys}) async {
    await super.refreshData(keys: keys);
    files.clear();

    for (var element in items) {
      files.add(NsgFilePickerObject(
          isNew: false,
          filePath: '${NsgServerOptions.serverUriDataController}/Data/GetStream?path=${element.name}',
          image: Image.network('${NsgServerOptions.serverUriDataController}/Data/GetStream?path=${element.name}'),
          description: element.name,
          //fileType: 'jpg',
          fileType: extension(element.name),
          id: element.id));
    }
    return;
  }

  //TODO: Проверка наличие файлов в richText для удаления лишних
  Future checkImagesInRichText() async {}

  @override
  Future<TaskDocFilesTable> fileObjectToDataItem(NsgFilePickerObject fileObject, File imageFile) async {
    var pic = TaskDocFilesTable();
    pic.id = fileObject.id;
    pic.name = '${fileObject.description}.${fileObject.fileType ?? ''}';
    pic.ownerId = Get.find<TasksController>().currentItem.id;
    pic.file = await imageFile.readAsBytes();
    return pic;
  }

  @override
  Future<NsgFilePickerObject> dataItemToFileObject(NsgDataItem dataItem) async {
    dataItem as TaskDocFilesTable;
    return NsgFilePickerObject(
        isNew: false,
        image: Image.network('${NsgServerOptions.serverUriDataController}/Data/GetStream?path=${dataItem.name}'),
        description: dataItem.name,
        fileType: 'jpg',
        id: dataItem.id);
  }
}
