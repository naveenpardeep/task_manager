import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/file_picker/nsg_file_picker_table_controller.dart';
import 'package:nsg_controls/nsg_controls.dart';
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

  String getFilePath(String fileName) {
    return '${NsgServerOptions.serverUriDataController}/Data/GetStream?path=$fileName';
  }

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var taskController = Get.find<TasksController>();

    cmp.add(name: TaskDocFilesTableGenerated.nameOwnerId, value: taskController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }

  //TODO: Проверка наличие файлов в richText для удаления лишних
  Future checkImagesInRichText() async {}

  @override
  Future<TaskDocFilesTable> fileObjectToDataItem(NsgFilePickerObject fileObject, File imageFile) async {
    var pic = TaskDocFilesTable();
    pic.id = fileObject.id;
    pic.name = '${fileObject.description}.${extension(fileObject.filePath).replaceAll('.', '')}';
    pic.ownerId = Get.find<TasksController>().currentItem.id;
    pic.file = await imageFile.readAsBytes();
    return pic;
  }

  @override
  Future<NsgFilePickerObject> dataItemToFileObject(NsgDataItem dataItem) async {
    dataItem as TaskDocFilesTable;
    var fileType = NsgFilePicker.getFileType(extension(dataItem.name).replaceAll('.', ''));
    if (fileType == NsgFilePickerObjectType.image) {
      return NsgFilePickerObject(isNew: false, image: Image.network(getFilePath(dataItem.name)), description: '', fileType: fileType, id: dataItem.id);
    } else {
      return NsgFilePickerObject(isNew: false, description: '', fileType: fileType, id: dataItem.id);
    }
  }
}
