import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager_app/image_file_view/image_file.dart';



/// Controller for the [MultiImagePickerView].
/// This controller contains all them images that the user has selected.
class NsgMultiImagePickerController with ChangeNotifier {
  final List<String> allowedImageTypes;
  final int maxImages;
  final bool withData;
  final bool withReadStream;

  NsgMultiImagePickerController(
      {this.allowedImageTypes = const ['png', 'jpeg', 'jpg'],
      this.maxImages = 10,
      this.withData = false,
      this.withReadStream = false,
      Iterable<ImageFile>? images}) {
    if (images != null) {
      _images = List.from(images);
    } else {
      _images = [];
    }
  }

  late final List<ImageFile> _images;

  /// Returns [Iterable] of [ImageFile] that user has selected.
  Iterable<ImageFile> get images => _images;

  /// Returns true if user has selected no images.
  bool get hasNoImages => _images.isEmpty;

  /// manually pick images. i.e. on click on external button.
  /// this method open Image picking window.
  /// It returns [Future] of [bool], true if user has selected images.
  Future<bool> pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: maxImages > 1 ? true : false,
        type: FileType.custom,
        withData: kIsWeb ? true : withData,
        withReadStream: kIsWeb ? false : withReadStream,
        allowedExtensions: allowedImageTypes);
    if (result != null && result.files.isNotEmpty) {
      _addImages(result.files
          .where((e) =>
              e.extension != null &&
              allowedImageTypes.contains(e.extension?.toLowerCase()))
          .map((e) => ImageFile(UniqueKey().toString(),
              name: e.name,
              extension: e.extension!,
              bytes: e.bytes,
              readStream: e.readStream,
              path: !kIsWeb ? e.path : null)));
      notifyListeners();
      return true;
    }
    return false;
  }

  void _addImages(Iterable<ImageFile> images) {
    int i = 0;
    while (_images.length < maxImages && images.length > i) {
      _images.add(images.elementAt(i));
      i++;
    }
  }

  void addImage(ImageFile imageFile) {
    _images.add(imageFile);
    notifyListeners();
  }

  /// Manually re-order image, i.e. move image from one position to another position.
  void reOrderImage(int oldIndex, int newIndex) {
    final oldItem = _images.removeAt(oldIndex);
    oldItem.size;
    _images.insert(newIndex, oldItem);
    notifyListeners();
  }

  /// Manually remove image from list.
  void removeImage(ImageFile imageFile) {
    _images.remove(imageFile);
    notifyListeners();
  }

  /// Remove all selected images and show default UI
  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}
