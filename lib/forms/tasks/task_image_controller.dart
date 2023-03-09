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

  Future<bool> saveFiles() async {
    var progress = NsgProgressDialog(textDialog: 'Сохранение File');
    progress.show();
    var ids = <String>[];
    try {
      for (var file in files) {
        if (file.file == null) continue;
        if (file.id == '') {
          var filename = TaskDocFilesTable();
          filename.name = filename.name;
          filename.ownerId = Get.find<TasksController>().currentItem.id;

          if (kIsWeb) {
            File filesupload = File.fromUri(Uri(path: file.filePath));
            filename.file = await filesupload.readAsBytes();
          } else {
            File filesUpload = File(file.filePath);
            filename.file = await filesUpload.readAsBytes();
          }
          await filename.post();
        }
        ids.add(file.id);
      }

      var itemsToDelete = items.where((e) => !ids.contains(e.id)).toList();
      if (itemsToDelete.isNotEmpty) {
        deleteItems(itemsToDelete);
      }
      progress.hide();
    } on Exception catch (ex) {
      progress.hide();
      NsgErrorWidget.showError(ex);
      rethrow;
    }
    return true;
  }

  @override
  Future refreshData({List<NsgUpdateKey>? keys}) async {
    await super.refreshData(keys: keys);
    files.clear();

    for (var element in items) {
      files.add(NsgFilePickerObject(
          isNew: false,
          filePath: element.name,
          //image: Image.memory(Uint8List.fromList(element.file)),
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
    pic.name = fileObject.description;
    pic.ownerId = Get.find<TasksController>().currentItem.id;
    pic.file = await imageFile.readAsBytes();
    return pic;
  }

  @override
  Future<NsgFilePickerObject> dataItemToFileObject(NsgDataItem dataItem) async {
    dataItem as TaskDocFilesTable;
    return NsgFilePickerObject(
        isNew: false, image: Image.memory(Uint8List.fromList(dataItem.file)), description: dataItem.name, fileType: 'jpg', id: dataItem.id);
  }
}
