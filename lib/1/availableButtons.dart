import 'package:flutter/material.dart';

enum AvailableButtons {
  showDividers('Divider', Icons.safety_divider_sharp),
  showFontFamily('Font Family', Icons.abc),
  showFontSize('Font Size', Icons.copy),
  showBoldButton('Bold', Icons.format_bold),
  showItalicButton('Italic', Icons.format_italic),
  showUnderLineButton('Underline', Icons.format_underline),
  showStrikeThrough('Strikethrough', Icons.strikethrough_s),
  showInlineCode('InlineCode', Icons.code),
  showColorButton('Color', Icons.color_lens),
  showBackgroundColorButton('BackColor', Icons.border_color),

  showClearFormat('Clear all', Icons.clear),
  showLeftAlignment('Left Alignment', Icons.format_align_left),
  showCenterAlignment('Center Alignment', Icons.format_align_center),
  showRightAlignment('Right Alignment', Icons.format_align_right),
  showJustifyAlignment('Justify ALignment', Icons.format_align_justify),
  showHeaderStyle('Underline', Icons.hdr_auto_sharp),
  showListNumbers('Number', Icons.numbers_rounded),
  showListBullets('List Bullets', Icons.format_list_bulleted_sharp),
  showListCheck('List Check', Icons.check_box),
  showCodeBlock('Code Block', Icons.code),

  showQuote('Quote', Icons.format_quote),
  showIndent('Indent', Icons.format_indent_decrease),
  showLink('add link', Icons.link),
  showUndo('Undo', Icons.undo),
  showRedo('Redo', Icons.redo),
  multiRowsDisplay('Multiple Rows', Icons.table_rows),
  showSearchButton('Search', Icons.search_rounded),
  ;

  final String tooltip;
  final IconData icon;

  const AvailableButtons(this.tooltip, this.icon);

  static const allValues = [
    showClearFormat,
    showLeftAlignment,
    showCenterAlignment,
    showRightAlignment,
    showJustifyAlignment,
    showHeaderStyle,
    showListNumbers,
    showListBullets,
    showListCheck,
    showBackgroundColorButton,
    showClearFormat,
    showLeftAlignment,
    showCenterAlignment,
    showRightAlignment,
    showJustifyAlignment,
    showHeaderStyle,
    showListNumbers,
    showListBullets,
    showListCheck,
    showCodeBlock,
    showQuote,
    showIndent,
    showLink,
    showUndo,
    showRedo,
    multiRowsDisplay,
    showSearchButton,
  ];

  static allExceptSelected(List<AvailableButtons> excepted) {
    return allValues.where((element) => !excepted.contains(element)).toList();
  }
}
