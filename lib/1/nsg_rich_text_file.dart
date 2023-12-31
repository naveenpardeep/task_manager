import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:nsg_controls/nsg_controls.dart';

class NsgRichTextFile extends quil.CustomBlockEmbed {
  late NsgFilePickerObject filePickerObject;

  NsgRichTextFile(NsgFilePickerObject fileObj) : super(blockType, fileObj.id.toString()) {
    filePickerObject = fileObj;
  }

  static const String blockType = 'nsg_image';

  static NsgRichTextFile fromDocument(quil.Document document) {
    // var json = document.toDelta().toJson();
    //var id = json.contains('id') ? json['id'].toString() : '';
    return NsgRichTextFile(

        //jsonEncode(document.toDelta().toJson())
        NsgFilePickerObject(description: '', isNew: false));
  }

  static NsgRichTextFile fromMap(Map<String, dynamic> data) {
    var id = '';
    if (data.containsKey('id')) {
      id = data['id'];
    }
    return NsgRichTextFile(
        //jsonEncode(document.toDelta().toJson())
        NsgFilePickerObject(id: id, description: '', isNew: false));
  }

  static NsgRichTextFile fromText(String data) {
    //var json = jsonDecode(data);
    return NsgRichTextFile(
        //jsonEncode(document.toDelta().toJson())
        NsgFilePickerObject(description: '', isNew: false));
  }

  @override
  String toJsonString() => jsonEncode(toJson());

  @override
  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = filePickerObject.id;
    map['fileType'] = filePickerObject.fileType;

    return {type: map};
  }

  //quil.Document get document => quil.Document.fromJson(jsonDecode(data));
  quil.Document get document => quil.Document();
}

class NsgRichTextFileBuilder implements quil.EmbedBuilder {
  NsgRichTextFileBuilder({required this.addEditBlock}) : super();

  Future<void> Function(BuildContext context, {quil.Document? document}) addEditBlock;

  @override
  String get key => NsgRichTextFile.blockType;

  // @override
  // Widget build(BuildContext context, quil.QuillController controller, quil.Embed node, bool readOnly, bool inline) {
  //   {
  //     assert(controller is NsgQuillController);
  //     NsgFilePickerObject? fileObject;
  //     if (block.value.data is Map && (block.value.data as Map).containsKey('id')) {
  //       var id = block.value.data['id'].toString();
  //       fileObject = (controller as NsgQuillController)
  //           .fileController
  //           .files
  //           .firstWhere((e) => e.id == id, orElse: () => NsgFilePickerObject(id: id, description: '', isNew: false));
  //     }

  //     //final notes = NsgRichTextFile.fromMap(block.value.data);

  //     return Container(
  //         constraints: const BoxConstraints(minWidth: 100, maxWidth: 100, minHeight: 100, maxHeight: 100),
  //         decoration: BoxDecoration(border: Border.all(color: Colors.black)),
  //         child: GestureDetector(
  //           child: (fileObject != null && fileObject.image != null)
  //               ? Column(children: [
  //                   Flexible(child: fileObject.image!),
  //                   Text(
  //                     fileObject.description,
  //                     overflow: TextOverflow.clip,
  //                     style: const TextStyle(fontSize: 9),
  //                     maxLines: 1,
  //                   )
  //                 ])
  //               : (fileObject != null)
  //                   ? Column(children: [
  //                       const Flexible(child: Text('PDF')),
  //                       Text(
  //                         fileObject.description,
  //                         overflow: TextOverflow.clip,
  //                         style: const TextStyle(fontSize: 9),
  //                         maxLines: 1,
  //                       )
  //                     ])
  //                   : const Icon(
  //                       Icons.picture_in_picture,
  //                       size: 50,
  //                     ),
  //           onTap: () => (controller as NsgQuillController).fileController.tapFile(fileObject),
  //         ));
  //   }
  // }

  @override
  WidgetSpan buildWidgetSpan(Widget widget) {
    // TODO: implement buildWidgetSpan
    throw UnimplementedError();
  }

  @override
  // TODO: implement expanded
  bool get expanded => throw UnimplementedError();

  @override
  Widget build(BuildContext context, quil.QuillController controller, quil.Embed node, bool readOnly, bool inline, textStyle) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  String toPlainText(quil.Embed node) {
    // TODO: implement toPlainText
    throw UnimplementedError();
  }
}
