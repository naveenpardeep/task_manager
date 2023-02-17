import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:nsg_controls/nsg_controls.dart';

class NsgRichTextFile extends quil.CustomBlockEmbed {
  NsgRichTextFile(NsgFilePickerObject filePickerObject) : super(blockType, filePickerObject.id.toString());

  static const String blockType = 'nsg_file';

  static NsgRichTextFile fromDocument(quil.Document document) => NsgRichTextFile(
      //jsonEncode(document.toDelta().toJson())
      NsgFilePickerObject(description: ''));

  @override
  String toJsonString() => jsonEncode(toJson());

  //quil.Document get document => quil.Document.fromJson(jsonDecode(data));
  quil.Document get document => quil.Document();

  NsgFilePickerObject? filePickerObject;
}

class NsgRichTextFileBuilder implements quil.EmbedBuilder {
  NsgRichTextFileBuilder({required this.addEditBlock});

  Future<void> Function(BuildContext context, {quil.Document? document}) addEditBlock;

  @override
  String get key => NsgRichTextFile.blockType;

  @override
  Widget build(
    BuildContext context,
    quil.QuillController controller,
    quil.Embed block,
    bool readOnly,
  ) {
    final notes = NsgRichTextFile(block.value.data).document;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: const Icon(
          Icons.picture_in_picture,
          size: 50,
        ),
        onTap: () => addEditBlock(context, document: notes),
      ),
    );
  }
}
