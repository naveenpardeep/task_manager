import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;

class NsgRichTextImage extends quil.CustomBlockEmbed {
  const NsgRichTextImage(String value) : super(blockType, value);

  static const String blockType = 'nsg_image';

  static NsgRichTextImage fromDocument(quil.Document document) =>
      NsgRichTextImage(jsonEncode(document.toDelta().toJson()));

  //quil.Document get document => quil.Document.fromJson(jsonDecode(data));
  quil.Document get document => quil.Document();
}

class NsgRichTextImageBuilder implements quil.EmbedBuilder {
  NsgRichTextImageBuilder({required this.addEditBlock});

  Future<void> Function(BuildContext context, {quil.Document? document})
      addEditBlock;

  @override
  String get key => 'nsg_image';

  @override
  Widget build(
    BuildContext context,
    quil.QuillController controller,
    quil.Embed block,
    bool readOnly,
  ) {
    final notes = NsgRichTextImage(block.value.data).document;

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
