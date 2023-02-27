import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:nsg_controls/nsg_controls.dart';

class NsgQuillController extends quil.QuillController {
  NsgFilePickerController fileController;
  NsgQuillController({required document, required selection, required this.fileController}) : super(document: document, selection: selection);
}
