import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/nsg_data.dart';

import '../../model/data_controller_model.dart';

class TaskImageController extends NsgDataController<Picture> {
  TaskImageController()
      : super(requestOnInit: false, autoRepeate: true, autoRepeateCount: 3);

  var images = <NsgFilePickerObject>[];

  @override
  NsgDataRequestParams get getRequestFilter {
    var cmp = NsgCompare();
    // var dataController = Get.find<DataController>();
    // if (dataController.currentPage == NsgPage.naOtgruzku) {
    //   cmp.add(name: PictureGenerated.nameOwnerId, value: Get.find<ZayavkaNaOtgruzkuController>().currentItem.id);
    // }
    return NsgDataRequestParams(compare: cmp);
  }

  Future saveImages() async {
    var progress = NsgProgressDialog(textDialog: 'Сохранение фото');
    progress.show();
    try {
      for (var img in images) {
        if (img.image == null) continue;
        if (img.id == '') {
          var pic = Picture();
          pic.name = img.description;

          if (kIsWeb) {
            File imagefile = File.fromUri(Uri(path: img.filePath));
            pic.image = await imagefile.readAsBytes();
          } else {
            File imagefile = File(img.filePath);
            pic.image = await imagefile.readAsBytes();
          }
          await pic.post();
        }
      }
      progress.hide();
      Get.back();
    } catch (ex) {
      progress.hide();
      Get.showSnackbar(GetSnackBar(
        title: 'ОШИБКА',
        message: ex.toString(),
      ));
    }
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
    return;
  }
}
