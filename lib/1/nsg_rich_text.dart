import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/file_picker/nsg_file_picker_interface.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:flutter/material.dart';
import 'package:nsg_controls/widgets/nsg_error_widget.dart';
import 'package:nsg_data/nsg_data.dart';
import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:path/path.dart';
import 'package:task_manager_app/1/availableButtons.dart';
import 'package:task_manager_app/1/nsg_quill_controller.dart';
import 'package:task_manager_app/1/nsg_rich_text_file.dart';
import 'package:file_picker/file_picker.dart';

class NsgRichText extends StatefulWidget {
  final String label;
  final bool disabled;
  final bool? gesture;
  final double? fontSize;
  final EdgeInsets? margin;
  final String? hint;
  final Widget? widget;
  final double borderRadius;
  final Function(NsgDataItem)? onChanged;
  final VoidCallback? onPressed;
  final Function(NsgDataItem, String)? onEditingComplete;
  final int maxLines;
  final int minLines;

  /// Красный текст валидации под текстовым полем
  final String validateText;

  /// Обязательное поле (будет помечено звездочкой)
  final bool? required;

  /// Высота
  final double? height;

  /// Объект, значение поля которого отображается
  final NsgDataItem dataItem;

  /// Поле для отображения и задания значения
  final String fieldName;

  ///Максимально разрешенный размер файла для выбора. При превышении размера файла, его выбор будет запрещен
  final double fileMaxSize;

  /// Контроллер
  final NsgDataController? controller;

  /// Контроллер, которому будет подаваться update при изменении значения в Input
  final NsgDataController? updateController;

  ///Контроллер, управляющий картинками
  final NsgFilePickerInterface fileController;

  final List<String> allowedImageFormats;
  final List<String> allowedVideoFormats;
  final List<String> allowedFileFormats;

  final List<AvailableButtons> availableButtons;

  const NsgRichText(
      {Key? key,
      this.validateText = '',
      required this.dataItem,
      required this.fieldName,
      this.controller,
      this.updateController,
      this.label = '',
      this.disabled = false,
      this.fontSize,
      this.borderRadius = 15,
      this.margin = const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      this.gesture,
      this.hint,
      this.onChanged,
      this.onPressed,
      this.onEditingComplete,
      this.maxLines = 1,
      this.minLines = 1,
      this.height = 50,
      this.widget,
      this.required,
      this.fileMaxSize = 2000000.0,
      this.allowedImageFormats = const ['jpeg', 'jpg', 'gif', 'png', 'bmp'],
      this.allowedVideoFormats = const ['mp4'],
      this.allowedFileFormats = const ['doc', 'docx', 'rtf', 'xls', 'xlsx', 'pdf', 'rtf'],
      this.availableButtons = AvailableButtons.allValues,
      required this.fileController})
      : super(key: key);

  @override
  State<NsgRichText> createState() => _NsgRichTextState();
}

class _NsgRichTextState extends State<NsgRichText> {
  final ValueNotifier<bool> _notifier = ValueNotifier(false);
  late double textScaleFactor;
  late double fontSize;
  FocusNode focus = FocusNode();
  bool isFocused = false;
  late NsgQuillController quillController;
  late ScrollController scrollController;
  String error = '';

  @override
  void initState() {
    super.initState();
    fontSize = widget.fontSize ?? ControlOptions.instance.sizeM;
    focus.addListener(() {
      if (focus.hasFocus) {
        setState(() {});
      } else {
        setState(() {});
      }

      if (!focus.hasFocus) {
        // widget.dataItem[widget.fieldName] =
        //     jsonEncode(quillController.document.toDelta().toJson());
        //widget.onEditingComplete!(widget.dataItem, widget.fieldName);
      }
    });

    var textValue = widget.dataItem[widget.fieldName].toString();
    List<dynamic> jsonValue = [];
    quil.Document doc = quil.Document();
    try {
      jsonValue = jsonDecode(textValue);
      doc = quil.Document.fromJson(jsonValue);
    } catch (e) {
      jsonValue = [
        {"insert": '$textValue\n'}
      ];
      doc = quil.Document.fromJson(jsonValue);
    }
    quillController = NsgQuillController(document: doc, selection: const TextSelection.collapsed(offset: 0), fileController: widget.fileController);
    quillController.document.changes.listen((event) {
      widget.dataItem[widget.fieldName] = jsonEncode(quillController.document.toDelta().toJson());
      if (widget.disabled) {
        quillController.undo();
      }
    });
    scrollController = ScrollController();
    //Проверяем, выбран ли тип инпута пользователем
  }

  @override
  void dispose() {
    _notifier.dispose();
    focus.removeListener(() {});
    focus.dispose();
    quillController.dispose();
    scrollController.dispose();
    super.dispose();
  }

/* --------------------------------------------------------------------- BUILD -------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
        alignment: Alignment.center,
        //height: widget.maxLines > 1 ? null : 24 * textScaleFactor,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: ControlOptions.instance.colorMain))),
        child: Column(children: [
          if (!widget.disabled && width>700)
            quil.QuillToolbar.basic(
              
              showDividers: widget.availableButtons.contains(AvailableButtons.showDividers),
              showFontFamily: widget.availableButtons.contains(AvailableButtons.showFontFamily),
              showFontSize: widget.availableButtons.contains(AvailableButtons.showFontSize),
              showBoldButton: widget.availableButtons.contains(AvailableButtons.showBoldButton),
              showItalicButton: widget.availableButtons.contains(AvailableButtons.showItalicButton),
              showUnderLineButton: widget.availableButtons.contains(AvailableButtons.showUnderLineButton),
              showStrikeThrough: widget.availableButtons.contains(AvailableButtons.showStrikeThrough),
              showInlineCode: widget.availableButtons.contains(AvailableButtons.showInlineCode),
              showColorButton: widget.availableButtons.contains(AvailableButtons.showColorButton),
              showBackgroundColorButton: widget.availableButtons.contains(AvailableButtons.showBackgroundColorButton),
              showClearFormat: widget.availableButtons.contains(AvailableButtons.showClearFormat),
              showLeftAlignment: widget.availableButtons.contains(AvailableButtons.showLeftAlignment),
              showCenterAlignment: widget.availableButtons.contains(AvailableButtons.showCenterAlignment),
              showRightAlignment: widget.availableButtons.contains(AvailableButtons.showRightAlignment),
              showJustifyAlignment: widget.availableButtons.contains(AvailableButtons.showJustifyAlignment),
              showHeaderStyle: widget.availableButtons.contains(AvailableButtons.showHeaderStyle),
              showListNumbers: widget.availableButtons.contains(AvailableButtons.showListNumbers),
              showListBullets: widget.availableButtons.contains(AvailableButtons.showListBullets),
              showListCheck: widget.availableButtons.contains(AvailableButtons.showListCheck),
              showCodeBlock: widget.availableButtons.contains(AvailableButtons.showCodeBlock),
              showQuote: widget.availableButtons.contains(AvailableButtons.showQuote),
              showIndent: widget.availableButtons.contains(AvailableButtons.showIndent),
              showLink: widget.availableButtons.contains(AvailableButtons.showLink),
              showUndo: widget.availableButtons.contains(AvailableButtons.showUndo),
              showRedo: widget.availableButtons.contains(AvailableButtons.showRedo),
              multiRowsDisplay: widget.availableButtons.contains(AvailableButtons.multiRowsDisplay),
              showSearchButton: widget.availableButtons.contains(AvailableButtons.showSearchButton),
              controller: quillController,
              afterButtonPressed: () {},
              customButtons: [quil.QuillCustomButton(icon: Icons.image_sharp, onTap: addImage)],
            ),
          if (!widget.disabled)
            SizedBox(
              height: width>700? 500: 180,
              child: quil.QuillEditor(
                focusNode: focus,
                scrollController: scrollController,
                controller: quillController,
                readOnly: widget.disabled,
                showCursor: !widget.disabled,
                scrollable: true,
                padding: EdgeInsets.zero,
                autoFocus: false,
                expands: false,
                embedBuilders: [NsgRichTextFileBuilder(addEditBlock: addEditBlock)],
              ),
            ),
             if (!widget.disabled && width<700)
            quil.QuillToolbar.basic(
              axis: Axis.horizontal,
              toolbarIconAlignment: WrapAlignment.spaceEvenly,
              showDividers: widget.availableButtons.contains(AvailableButtons.showDividers),
              showFontFamily: widget.availableButtons.contains(AvailableButtons.showFontFamily),
              showFontSize: widget.availableButtons.contains(AvailableButtons.showFontSize),
              showBoldButton: widget.availableButtons.contains(AvailableButtons.showBoldButton),
              showItalicButton: widget.availableButtons.contains(AvailableButtons.showItalicButton),
              showUnderLineButton: widget.availableButtons.contains(AvailableButtons.showUnderLineButton),
              showStrikeThrough: widget.availableButtons.contains(AvailableButtons.showStrikeThrough),
              showInlineCode: widget.availableButtons.contains(AvailableButtons.showInlineCode),
              showColorButton: widget.availableButtons.contains(AvailableButtons.showColorButton),
              showBackgroundColorButton: widget.availableButtons.contains(AvailableButtons.showBackgroundColorButton),
              showClearFormat: widget.availableButtons.contains(AvailableButtons.showClearFormat),
              showLeftAlignment: widget.availableButtons.contains(AvailableButtons.showLeftAlignment),
              showCenterAlignment: widget.availableButtons.contains(AvailableButtons.showCenterAlignment),
              showRightAlignment: widget.availableButtons.contains(AvailableButtons.showRightAlignment),
              showJustifyAlignment: widget.availableButtons.contains(AvailableButtons.showJustifyAlignment),
              showHeaderStyle: widget.availableButtons.contains(AvailableButtons.showHeaderStyle),
              showListNumbers: widget.availableButtons.contains(AvailableButtons.showListNumbers),
              showListBullets: widget.availableButtons.contains(AvailableButtons.showListBullets),
              showListCheck: widget.availableButtons.contains(AvailableButtons.showListCheck),
              showCodeBlock: widget.availableButtons.contains(AvailableButtons.showCodeBlock),
              showQuote: widget.availableButtons.contains(AvailableButtons.showQuote),
              showIndent: widget.availableButtons.contains(AvailableButtons.showIndent),
              showLink: widget.availableButtons.contains(AvailableButtons.showLink),
              showUndo: widget.availableButtons.contains(AvailableButtons.showUndo),
              showRedo: widget.availableButtons.contains(AvailableButtons.showRedo),
              multiRowsDisplay: widget.availableButtons.contains(AvailableButtons.multiRowsDisplay),
              showSearchButton: widget.availableButtons.contains(AvailableButtons.showSearchButton),
              controller: quillController,
              afterButtonPressed: () {},
              customButtons: [quil.QuillCustomButton(icon: Icons.image_sharp, onTap: addImage)],
            ),
          if (widget.disabled)
            SizedBox(
              child: quil.QuillEditor(
                focusNode: focus,
                scrollController: scrollController,
                controller: quillController,
                readOnly: widget.disabled,
                showCursor: !widget.disabled,
                scrollable: true,
                padding: EdgeInsets.zero,
                autoFocus: true,
                expands: false,
                embedBuilders: [NsgRichTextFileBuilder(addEditBlock: addEditBlock)],
              ),
            )
        ]));
  }

  Future<void> addEditBlock(BuildContext context, {quil.Document? document}) async {
    //pickFile();
  }

  void addImage() {
    pickFile();
  }

  Future pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: [...widget.allowedFileFormats, ...widget.allowedImageFormats]);
    if (result != null) {
      for (var element in result.files) {
        var fileType = NsgFilePicker.getFileType(extension(element.name).replaceAll('.', ''));

        if (!kIsWeb && (GetPlatform.isLinux || GetPlatform.isAndroid)) {
          File file = File(element.path.toString());

          if ((await file.length()) > widget.fileMaxSize) {
            error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
            setState(() {});
            return;
          }
          if (fileType == NsgFilePickerObjectType.image) {
            var obj = NsgFilePickerObject(
                isNew: true,
                image: Image.file(File(element.path.toString())),
                description: basenameWithoutExtension(element.name.toString()),
                fileType: fileType,
                filePath: element.path ?? '');
            widget.fileController.files.add(obj);
            addImageBlock(obj);
          } else if (fileType != NsgFilePickerObjectType.unknown) {
            var obj = NsgFilePickerObject(
                isNew: true,
                file: File(element.name),
                image: null,
                description: basenameWithoutExtension(element.name),
                fileType: fileType,
                filePath: element.path ?? '');
            widget.fileController.files.add(obj);
            addImageBlock(obj);
          } else {
            error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
            setState(() {});
          }
        } else {
          var file = File(element.name);
          if ((await file.length()) > widget.fileMaxSize) {
            error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
            NsgErrorWidget.showErrorByString(error);
            //setState(() {});
            return;
          }

          if (fileType == NsgFilePickerObjectType.image) {
            var obj = NsgFilePickerObject(
                isNew: true,
                image: Image.file(File(element.name)),
                description: basenameWithoutExtension(element.name),
                fileType: fileType,
                filePath: element.path ?? '');
            widget.fileController.files.add(obj);
            addImageBlock(obj);
          } else if (fileType != NsgFilePickerObjectType.unknown) {
            var obj = NsgFilePickerObject(
                isNew: true,
                file: File(element.name),
                image: null,
                description: basenameWithoutExtension(element.name),
                fileType: fileType,
                filePath: element.path ?? '');
            widget.fileController.files.add(obj);
            addImageBlock(obj);
          } else {
            error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
            setState(() {});
          }
        }
      }
    }
  }

  void addImageBlock(NsgFilePickerObject filePickerObject) {
    var block = NsgRichTextFile(filePickerObject);
    final index = quillController.selection.baseOffset;
    final length = quillController.selection.extentOffset - index;
    quillController.replaceText(index, length, block, null);
  }
}
