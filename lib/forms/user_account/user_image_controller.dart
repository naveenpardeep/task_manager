import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/widgets/nsg_error_widget.dart';
import 'package:nsg_data/controllers/nsgImageController.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:task_manager_app/forms/user_account/user_account_controller.dart';

import '../../model/data_controller_model.dart';

class UserImageController extends NsgImageController<Picture> {
  UserImageController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 3);

  var images = <NsgFilePickerObject>[];

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    var userController = Get.find<UserAccountController>();

    cmp.add(
        name: PictureGenerated.nameOwnerId,
        value: userController.currentItem.id);
    return NsgDataRequestParams(compare: cmp);
  }

  Future<bool> saveImages() async {
    var progress = NsgProgressDialog(textDialog: 'Сохранение фото');
    progress.show();
    var ids = <String>[];
    try {
      for (var img in images) {
        if (img.image == null) continue;
        if (img.id == '') {
          var pic = Picture();
          pic.name = img.description;
          pic.ownerId = Get.find<UserAccountController>().currentItem.id;

          if (kIsWeb) {
            File imagefile = File.fromUri(Uri(path: img.filePath));
            pic.image = await imagefile.readAsBytes();
          } else {
            File imagefile = File(img.filePath);
            pic.image = await imagefile.readAsBytes();
          }
          await pic.post();
        }
        ids.add(img.id);
      }
      //Удаляем "лишние" картинки
      var itemsToDelete = items.where((e) => !ids.contains(e.id)).toList();
      if (itemsToDelete.isNotEmpty) {
        deleteItems(itemsToDelete);
      }
      progress.hide();
      // Get.back();
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
    images.clear();
    for (var element in items) {
      images.add(NsgFilePickerObject(
          image: Image.memory(Uint8List.fromList(element.image)),
          description: element.name,
          fileType: 'jpg',
          id: element.id));
    }
    if (items.isNotEmpty) {
      currentItem = items.first;
    }
    return;
  }
}
