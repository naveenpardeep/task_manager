import 'package:flutter_quill/flutter_quill.dart' as quil;
import 'package:nsg_controls/file_picker/nsg_file_picker_interface.dart';

class NsgQuillController extends quil.QuillController {
  NsgFilePickerInterface fileController;
  NsgQuillController({required document, required selection, required this.fileController}) : super(document: document, selection: selection);
}
