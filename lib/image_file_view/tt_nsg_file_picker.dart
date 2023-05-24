import 'dart:io';
import 'dart:async';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_controls/nsg_text.dart';
import 'package:nsg_data/nsg_data.dart';

import 'package:pasteboard/pasteboard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:path/path.dart';
import 'package:task_manager_app/forms/tasks/tasks_controller.dart';
import 'package:task_manager_app/image_file_view/image_file.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player_win/video_player_win.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:file_selector/file_selector.dart' as file;
import 'package:dio/dio.dart' as dio;

import '../forms/tasks/task_file_controller.dart';

/// Пикер и загрузчик изображений и файлов заданных форматов
class TTNsgFilePicker extends StatefulWidget {
  final bool showAsWidget;
  final List<String> allowedImageFormats;
  final List<String> allowedVideoFormats;
  final List<String> allowedFileFormats;
  final bool useFilePicker;

  ///Максимальная ширина картинки. При превышении, картинка будет пережата.
  final double imageMaxWidth;

  ///Максимальная высота картинки. При превышении, картинка будет пережата
  final double imageMaxHeight;

  ///Качество сжатия картинки в jpeg (100 - макс)
  final int imageQuality;

  ///Максимально разрешенный размер файла для выбора. При превышении размера файла, его выбор будет запрещен
  final double fileMaxSize;

  ///Фунция, вызываемая при подтверждении сохранения картинок пользователем
  final Function(List<NsgFilePickerObject>) callback;

  ///Максисально допустимое количество присоединяемых файлов
  ///Например, можно использовать для задания картинки профиля, установив ограничение равное 1
  ///По умолчанию равно нулю - не ограничено
  final int maxFilesCount;
  final String textChooseFile;

  ///Сохраненные объекты (картинки и документы)
  final List<NsgFilePickerObject> objectsList;

  final bool oneFile;
  final bool skipInterface;

  TTNsgFilePicker({
    Key? key,
    this.allowedImageFormats = const ['jpeg', 'jpg', 'gif', 'png', 'bmp'],
    this.allowedVideoFormats = const ['mp4'],
    this.allowedFileFormats = const ['doc', 'docx', 'rtf', 'xls', 'xlsx', 'pdf', 'rtf'],
    this.showAsWidget = false,
    this.useFilePicker = false,
    this.imageMaxWidth = 1440.0,
    this.imageMaxHeight = 1440.0,
    this.imageQuality = 70,
    this.fileMaxSize = 1000000.0,
    this.maxFilesCount = 0,
    required this.callback,
    required this.objectsList,
    this.textChooseFile = 'Добавить фото или файл',
    this.oneFile = false,
    this.skipInterface = false,
//Iterable<ImageFile>? images
  }) : super(key: key) {
    _resisterComponents();

// if (images != null) {
// _images = List.from(images);
// } else {
// _images = [];
// }
  }

//late final List<ImageFile> _images;

  /// Returns [Iterable] of [ImageFile] that user has selected.
//Iterable<ImageFile> get images => _images;

  /// Returns true if user has selected no images.
//bool get hasNoImages => _images.isEmpty;

  static bool _isComponentsRegistered = false;
  static _resisterComponents() {
    if (!_isComponentsRegistered) {
      if (!kIsWeb && (Platform.isWindows || GetPlatform.isLinux)) {
        WindowsVideoPlayer.registerWith();
      }
      _isComponentsRegistered = true;
    }
  }

// popup() {
// Get.dialog(
// NsgPopUp(
// title: 'Загрузите фотографию',
// contentTop: SizedBox(width: 300, height: 300, child: this),
// ),
// barrierDismissible: true);
// }

  @override
  State<TTNsgFilePicker> createState() => _TTNsgFilePickerState();

  static List<String> globalAllowedImageFormats = const ['jpeg', 'jpg', 'gif', 'png', 'bmp'];
  static List<String> globalAllowedVideoFormats = const ['mp4'];
  static List<String> globalAllowedFileFormats = const ['doc', 'docx', 'rtf', 'xls', 'xlsx', 'pdf', 'rtf', 'csv'];

  static NsgFilePickerObjectType getFileTypeByExtension(String ext) {
    if (globalAllowedImageFormats.contains(ext)) {
      return NsgFilePickerObjectType.image;
    }
    if (globalAllowedVideoFormats.contains(ext)) {
      return NsgFilePickerObjectType.video;
    }
    if (globalAllowedFileFormats.contains(ext)) {
      if (ext == 'pdf') {
        return NsgFilePickerObjectType.pdf;
      } else {
        return NsgFilePickerObjectType.other;
      }
    }

    return NsgFilePickerObjectType.unknown;
  }

  static NsgFilePickerObjectType getFileTypeByPath(String path) {
    var ext = extension(path).replaceAll('.', '').toLowerCase();
    return getFileTypeByExtension(ext);
  }
}

class _TTNsgFilePickerState extends State<TTNsgFilePicker> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String error = '';
  bool galleryPage = true;
  ScrollController scrollController = ScrollController();
//List<NsgFilePickerObject> objectsList = [];
  Widget _appBar() {
    return NsgAppBar(
      text: widget.objectsList.isEmpty ? 'Добавление фотографий'.toUpperCase() : 'Сохранение фотографий'.toUpperCase(),
      text2: widget.objectsList.isNotEmpty ? 'вы добавили ${widget.objectsList.length} фото' : null,
      icon: Icons.arrow_back_ios_new,
      color: ControlOptions.instance.colorInverted,
      colorsInverted: true,
      bottomCircular: true,
      onPressed: () {
        Get.back();
      },
      icon2: Icons.check,
      onPressed2: () {
        widget.callback(widget.objectsList);
        Get.back();
      },
    );
  }

// Pick an image
  Future galleryImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: [...widget.allowedFileFormats, ...widget.allowedImageFormats, ...widget.allowedVideoFormats]);

      if (result != null) {
        galleryPage = true;

        for (var element in result.files) {
          Uint8List? fileBytes = element.bytes;
          String fileName = element.name;
          var fileType = TTNsgFilePicker.getFileTypeByPath(fileName);

// var file = File(element.name);

// if ((await file.length()) > widget.fileMaxSize) {
// error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
// setState(() {});
// return;
// }
          if (fileType == NsgFilePickerObjectType.image) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                image: Image.memory(fileBytes!),
                fileContent: fileBytes,
                description: basenameWithoutExtension(fileName),
                fileType: fileType,
                filePath: fileName));
          } else if (fileType != NsgFilePickerObjectType.unknown) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                file: File(fileBytes.toString()),
                fileContent: fileBytes,
                image: null,
                description: basenameWithoutExtension(fileName),
                fileType: fileType,
                filePath: fileName));
          } else {
            error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
            setState(() {});
          }
        }
        if (widget.skipInterface) {
          widget.callback(widget.objectsList);
        } else {
          setState(() {});
        }
      }
    } else if (GetPlatform.isWindows || GetPlatform.isLinux || GetPlatform.isAndroid || GetPlatform.isIOS) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: [...widget.allowedFileFormats, ...widget.allowedImageFormats, ...widget.allowedVideoFormats]);

      if (result != null) {
        galleryPage = true;

        for (var element in result.files) {
          var fileType = TTNsgFilePicker.getFileTypeByPath(element.name);

          if (!GetPlatform.isLinux) {
            //var file = File(element.name);

            // if ((await file.length()) > widget.fileMaxSize) {
            //   error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
            //   setState(() {});
            //   return;
            // }
            if (fileType == NsgFilePickerObjectType.image) {
              widget.objectsList.add(NsgFilePickerObject(
                  isNew: true,
                  image: Image.file(File(element.name.toString())),
                  description: basenameWithoutExtension(element.name.toString()),
                  fileType: fileType,
                  filePath: element.path ?? ''));
            } else if (fileType != NsgFilePickerObjectType.unknown) {
              widget.objectsList.add(NsgFilePickerObject(
                  isNew: true,
                  file: File(element.name),
                  image: null,
                  description: basenameWithoutExtension(element.name),
                  fileType: fileType,
                  filePath: element.path ?? ''));
            } else {
              error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
              setState(() {});
            }
          }
          if (GetPlatform.isLinux) {
            //File file = File(element.path.toString());

            // if ((await file.length()) > widget.fileMaxSize) {
            //   error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
            //   setState(() {});
            //   return;
            // }
            if (fileType == NsgFilePickerObjectType.image) {
              widget.objectsList.add(NsgFilePickerObject(
                  isNew: true,
                  image: Image.file(File(element.path.toString())),
                  description: basenameWithoutExtension(element.path.toString()),
                  fileType: fileType,
                  filePath: element.path.toString()));
            } else if (fileType != NsgFilePickerObjectType.unknown) {
              widget.objectsList.add(NsgFilePickerObject(
                  isNew: true,
                  file: File(element.name),
                  image: null,
                  description: basenameWithoutExtension(element.name),
                  fileType: fileType,
                  filePath: element.path ?? ''));
            } else {
              error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
              setState(() {});
            }
          }
        }
        if (widget.skipInterface) {
          widget.callback(widget.objectsList);
        } else {
          setState(() {});
        }
      }
    } else if (GetPlatform.isMacOS) {
      var jpgsTypeGroup = const file.XTypeGroup(
        label: 'JPEGs',
        extensions: <String>['jpg', 'jpeg'],
      );
      var pngTypeGroup = const file.XTypeGroup(
        label: 'PNGs',
        extensions: <String>['png'],
      );
      List<XFile> result = await file.openFiles(acceptedTypeGroups: <file.XTypeGroup>[
        jpgsTypeGroup,
        pngTypeGroup,
      ]);

      if (result.isNotEmpty) {
        galleryPage = true;

        /// Если стоит ограничение на 1 файл
        if (widget.oneFile) {
          result = [result[0]];
          widget.objectsList.clear();
        }
        for (var element in result) {
          var fileType = TTNsgFilePicker.getFileTypeByPath(element.path);

          if (fileType == NsgFilePickerObjectType.image) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                image: Image.file(File(element.path)),
                description: basenameWithoutExtension(element.path),
                fileType: fileType,
                filePath: element.path));
          } else if (fileType != NsgFilePickerObjectType.unknown) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                file: File(element.path),
                image: null,
                description: basenameWithoutExtension(element.path),
                fileType: fileType,
                filePath: element.path));
          } else {
            error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
            setState(() {});
          }
        }
      }
      if (widget.skipInterface) {
        widget.callback(widget.objectsList);
      } else {
        setState(() {});
      }
    } else {
      var result = await ImagePicker().pickMultiImage(
        imageQuality: widget.imageQuality,
        maxWidth: widget.imageMaxWidth,
        maxHeight: widget.imageMaxHeight,
      );

      galleryPage = true;

      /// Если стоит ограничение на 1 файл
      if (widget.oneFile) {
        if (result.isNotEmpty) result = [result[0]];
        widget.objectsList.clear();
      }
      for (var element in result) {
        var fileType = TTNsgFilePicker.getFileTypeByPath(element.path);

        if (fileType == NsgFilePickerObjectType.image) {
          widget.objectsList.add(NsgFilePickerObject(
              isNew: true,
              image: Image.file(File(element.path)),
              description: basenameWithoutExtension(element.path),
              fileType: fileType,
              filePath: element.path));
        } else if (fileType != NsgFilePickerObjectType.unknown) {
          widget.objectsList.add(NsgFilePickerObject(
              isNew: true,
              file: File(element.path),
              image: null,
              description: basenameWithoutExtension(element.path),
              fileType: fileType,
              filePath: element.path));
        } else {
          error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
          setState(() {});
        }
      }

      if (widget.skipInterface) {
        widget.callback(widget.objectsList);
      } else {
        setState(() {});
      }
    }
  }

  /// Pick an image
  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [...widget.allowedFileFormats, ...widget.allowedImageFormats, ...widget.allowedVideoFormats]);
    if (result != null) {
      galleryPage = true;
      for (var element in result.files) {
        var fileType = TTNsgFilePicker.getFileTypeByPath(element.name);

        if (kIsWeb) {
          var file = File(element.bytes.toString());

          if ((await file.length()) > widget.fileMaxSize) {
            error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
            setState(() {});
            return;
          }
          if (fileType == NsgFilePickerObjectType.image) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                image: Image.network(element.path.toString()),
                description: basenameWithoutExtension(element.name),
                fileType: fileType,
                filePath: ''));
          } else if (fileType != NsgFilePickerObjectType.unknown) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                file: File(element.bytes!.toString()),
                image: null,
                description: basenameWithoutExtension(element.bytes.toString()),
                fileType: fileType,
                filePath: ''));
          } else {
            error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
            setState(() {});
          }
        } else if (GetPlatform.isWindows) {
          var file = File(element.name);

          if ((await file.length()) > widget.fileMaxSize) {
            error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
            setState(() {});
            return;
          }
          if (fileType == NsgFilePickerObjectType.image) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                image: Image.file(File(element.name.toString())),
                description: basenameWithoutExtension(element.name.toString()),
                fileType: fileType,
                filePath: element.path ?? ''));
          } else if (fileType != NsgFilePickerObjectType.unknown) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                file: File(element.name),
                image: null,
                description: basenameWithoutExtension(element.name),
                fileType: fileType,
                filePath: element.path ?? ''));
          } else {
            error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
            setState(() {});
          }
        }
        if (GetPlatform.isLinux || GetPlatform.isMacOS || GetPlatform.isAndroid || GetPlatform.isIOS) {
          //File file = File(element.path.toString());

          // if ((await file.length()) > widget.fileMaxSize) {
          //   error = 'Превышен максимальный размер файла ${(widget.fileMaxSize / 1024).toString()} кБайт';
          //   setState(() {});
          //   return;
          // }
          if (fileType == NsgFilePickerObjectType.image) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                image: Image.file(File(element.path.toString())),
                description: basenameWithoutExtension(element.name.toString()),
                fileType: fileType,
                filePath: element.path ?? ''));
          } else if (fileType != NsgFilePickerObjectType.unknown) {
            widget.objectsList.add(NsgFilePickerObject(
                isNew: true,
                file: File(element.name),
                image: null,
                description: basenameWithoutExtension(element.name),
                fileType: fileType,
                filePath: element.path ?? ''));
          } else {
            error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
            setState(() {});
          }
        }
      }
      if (widget.skipInterface) {
        widget.callback(widget.objectsList);
      } else {
        setState(() {});
      }
    }
  }

  Future galleryImageMobile() async {
    {
      var result = await ImagePicker().pickMultiImage(
        imageQuality: widget.imageQuality,
        maxWidth: widget.imageMaxWidth,
        maxHeight: widget.imageMaxHeight,
      );

      galleryPage = true;

      /// Если стоит ограничение на 1 файл
      if (widget.oneFile) {
        if (result.isNotEmpty) result = [result[0]];
        widget.objectsList.clear();
      }
      for (var element in result) {
        var fileType = NsgFilePicker.getFileType(extension(element.path).replaceAll('.', ''));

        if (fileType == NsgFilePickerObjectType.image) {
          widget.objectsList.add(NsgFilePickerObject(
              isNew: true,
              image: Image.file(File(element.path)),
              description: basenameWithoutExtension(element.path),
              fileType: fileType,
              filePath: element.path));
        } else if (fileType != NsgFilePickerObjectType.unknown) {
          widget.objectsList.add(NsgFilePickerObject(
              isNew: true,
              file: File(element.path),
              image: null,
              description: basenameWithoutExtension(element.path),
              fileType: fileType,
              filePath: element.path));
        } else {
          error = '${fileType.toString().toUpperCase()} - неподдерживаемый формат';
          setState(() {});
        }
      }

      if (widget.skipInterface) {
        widget.callback(widget.objectsList);
      } else {
        setState(() {});
      }
    }
  }

  /// Capture a photo
  Future cameraImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        widget.objectsList.add(
            NsgFilePickerObject(isNew: true, image: Image.file(File(image.path)), description: basenameWithoutExtension(image.path), filePath: image.path));
        galleryPage = false;
      });
    } else {
      setState(() {
        error = 'Ошибка камеры';
      });
    }
  }

  Widget _showFileType(NsgFilePickerObject element) {
    return Container(
        height: 100,
        decoration: BoxDecoration(
          color: ControlOptions.instance.colorMain.withOpacity(0.2),
        ),
        child: Center(
            child: Opacity(
          opacity: 0.5,
          child: NsgText(
            extension(element.filePath).replaceAll('.', ''),
            margin: const EdgeInsets.only(top: 10),
            color: ControlOptions.instance.colorMain,
            type: NsgTextType(const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          ),
        )));
  }

  Future saveFile(NsgFilePickerObject fileObject) async {
    if (GetPlatform.isIOS || GetPlatform.isAndroid) {
      String? message;
      String? imagepath = TaskFilesController.getFilePath(fileObject.image.toString());

      try {
        // Download image
        final http.Response response = await http.get(Uri.parse(imagepath));

        // Get temporary directory
        final dir = await getTemporaryDirectory();

        // Create an image name
        var filename = '${dir.path}/filename';

        // Save to filesystem
        final file = File(filename);
        await file.writeAsBytes(response.bodyBytes);

        final params = SaveFileDialogParams(sourceFilePath: file.path);
        final finalPath = await FlutterFileDialog.saveFile(params: params);

        if (finalPath != null) {
          message = 'Image saved';
        }
      } catch (e) {
        message = 'An error occurred while saving the image';
      }

      if (message != null) {
        Get.snackbar('', message);
      }
    } else {
      FileType fileType = FileType.any;

      switch (fileObject.fileType) {
        case NsgFilePickerObjectType.image:
          fileType = FileType.image;
          break;
        case NsgFilePickerObjectType.video:
          fileType = FileType.video;
          break;
        case NsgFilePickerObjectType.pdf:
          fileType = FileType.any;
          break;
        default:
          fileType = FileType.any;
      }
      var fileName = await FilePicker.platform
          .saveFile(dialogTitle: 'Сохранить файл', type: fileType, allowedExtensions: [extension(fileObject.filePath).replaceAll('.', '')]);
      if (fileName == null) return;
      var ext = extension(fileName);
      if (ext.isEmpty) {
        fileName += extension(fileObject.filePath);
      }

//TODO: add progress
      dio.Dio io = dio.Dio();
      await io.download(fileObject.filePath, fileName, onReceiveProgress: (receivedBytes, totalBytes) {
//setState(() {
// downloading = true;
// progress =
// ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
      });
      await launchUrlString('file:$fileName');
    }
  }

  /// Вывод галереи на экран
  Widget _getImages() {
    List<Widget> list = [];
    for (var element in widget.objectsList) {
      list.add(Container(
        decoration: BoxDecoration(border: Border.all(width: 2, color: ControlOptions.instance.colorMain)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: ControlOptions.instance.colorMain.withOpacity(1)),
                  padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                  alignment: Alignment.centerLeft,
                  height: 40,
                  child: Text(
                    '',
                    maxLines: 3,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 10,
                      color: ControlOptions.instance.colorInverted,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    color: ControlOptions.instance.colorMain.withOpacity(0),
                    child: InkWell(
                      hoverColor: ControlOptions.instance.colorMainDark,
                      onTap: () {
                        saveFile(element);
                      },
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.save_as, size: 18, color: ControlOptions.instance.colorInverted),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: ControlOptions.instance.colorMain.withOpacity(0),
                    child: InkWell(
                      hoverColor: ControlOptions.instance.colorMainDark,
                      onTap: () {
                        Get.dialog(NsgPopUp(
                          title: 'Удаление фотографии',
                          text: 'После удаления, фотографию нельзя будет восстановить. Удалить?',
                          onConfirm: () {
                            widget.objectsList.remove(element);
                            setState(() {});
                            Get.back();
                          },
                        ));
                      },
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.close, size: 18, color: ControlOptions.instance.colorInverted),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
//hoverColor: ControlOptions.instance.colorMain,
                onTap: () {
                  if (element.fileType == NsgFilePickerObjectType.unknown) {
                    element.fileType = TTNsgFilePicker.getFileTypeByPath(element.filePath);
                  }
                  if (element.fileType != NsgFilePickerObjectType.other && element.fileType != NsgFilePickerObjectType.unknown) {
                    List<NsgFilePickerObject> imagesList = [];
                    for (var el in widget.objectsList) {
                      if (el.fileType != NsgFilePickerObjectType.other && el.fileType != NsgFilePickerObjectType.unknown) {
                        imagesList.add(el);
                      }
                    }
                    int currentPage = imagesList.indexOf(element);
                    Get.dialog(
                        NsgPopUp(
                            onCancel: () {
                              Get.back();
                            },
                            onConfirm: () {
                              Get.back();
                            },
                            margin: const EdgeInsets.all(15),
                            title: "Просмотр изображений",
                            width: Get.width,
                            height: Get.height,
                            getContent: () => [
                                  NsgGallery(
                                    imagesList: imagesList,
                                    currentPage: currentPage,
                                  )
                                ]),
                        barrierDismissible: true);
                  } else {
                    Get.snackbar('Ошибка', 'Этот файл не является изображением',
                        duration: const Duration(seconds: 3),
                        maxWidth: 300,
                        snackPosition: SnackPosition.bottom,
                        barBlur: 0,
                        overlayBlur: 0,
                        colorText: ControlOptions.instance.colorMainText,
                        backgroundColor: ControlOptions.instance.colorMainDark);
                  }
                },
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: element.image != null
                              ? Image(
                                  image: element.image!.image,
                                  fit: BoxFit.cover,
                                )
                              : _showFileType(element),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));
    }
    List<Widget> listWithPlus = list;
    listWithPlus.add(NsgImagePickerButton(
      textChooseFile: widget.textChooseFile,
      onPressed: () {
        if (kIsWeb) {
          galleryImage();
        } else if (GetPlatform.isWindows || GetPlatform.isLinux || GetPlatform.isMacOS) {
          pickFile();
        } else {
          galleryImageMobile();
        }
      },
      onPressed2: () {
        pickFile();
      },
      onPressed3: () {
        cameraImage();
      },
      objectsList1: widget.objectsList,
    ));

    return RawScrollbar(
        minOverscrollLength: 100,
        minThumbLength: 100,
        thickness: 16,
        trackBorderColor: ControlOptions.instance.colorMainDark,
        trackColor: ControlOptions.instance.colorMainDark,
        thumbColor: ControlOptions.instance.colorMain,
        radius: const Radius.circular(0),
        thumbVisibility: true,
        trackVisibility: true,
        controller: scrollController,
        child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ResponsiveGridList(scroll: false, minSpacing: 10, desiredItemWidth: 100, children: listWithPlus),
            )));
  }

  Widget body() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (error != '')
          NsgText(
            margin: const EdgeInsets.only(top: 10),
            error,
            backColor: ControlOptions.instance.colorError.withOpacity(0.2),
          ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _getImages(),
        )),
      ],
    );
  }

  @override
  void initState() {
//objectsList.addAll(widget.objectsList);
    super.initState();
  }

/* --------------------------------------------------------------------- Build -------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    if (widget.skipInterface) {
      if (kIsWeb) {
        if (widget.useFilePicker) {
          pickFile();
        } else {
          galleryImage();
        }
      } else if (GetPlatform.isWindows || GetPlatform.isLinux || GetPlatform.isMacOS) {
        if (widget.useFilePicker) {
          pickFile();
        } else {
          galleryImage();
        }
      } else {
        galleryImageMobile();
      }
      return const SizedBox();
    } else {
      return widget.showAsWidget == true
          ? body()
          : BodyWrap(
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.white,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    //  _appBar(),
                    Expanded(
                      child: body(),
                    ),
                  ],
                ),
              ),
            );
    }
  }
}

class NsgImagePickerButton extends StatelessWidget {
  final void Function() onPressed;
  final void Function() onPressed2;
  final void Function() onPressed3;
  final List<NsgFilePickerObject> objectsList1;
  final String textChooseFile;
  const NsgImagePickerButton(
      {Key? key, required this.onPressed, required this.onPressed2, required this.onPressed3, required this.textChooseFile, required this.objectsList1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!GetPlatform.isAndroid && !GetPlatform.isIOS)
        ? InkWell(
            hoverColor: ControlOptions.instance.colorMain,
            onTap: onPressed,
            onLongPress: () async {
              final bytes = await Pasteboard.image;

              //   var length=bytes?.length ?? 0;
              try {
                if ((Pasteboard.image.isBlank == null || !Pasteboard.image.isBlank!) && bytes != null) {
                  objectsList1.add(
                    NsgFilePickerObject(
                        isNew: true,
                        image: Image.memory(bytes),
                        //TODO: convert image to jpg and check max size
                        description: "${Guid.newGuid()}.jpg",
                        fileContent: Uint8List.fromList(bytes),
                        fileType: NsgFilePickerObjectType.image),
                  );
                  Get.find<TasksController>().sendNotify();
                } else {
                  var files = await Pasteboard.files();
                  if (files.isEmpty) {
                    Get.snackbar('', 'Clipboard empty');
                  } else {
                    for (var fileName in files) {
                      var fileType = TTNsgFilePicker.getFileTypeByPath(fileName);
                      if (fileType == NsgFilePickerObjectType.unknown) {
                        Get.snackbar('', 'File format doesn' 't supported $fileName');
                        continue;
                      }
                      var file = File(fileName);
                      objectsList1.add(NsgFilePickerObject(
                        isNew: true,
                        image: (fileType == NsgFilePickerObjectType.image ? Image.file(file) : null),
                        description: fileName,
                        filePath: fileName,
                        file: file,
                        //fileContent: Uint8List.fromList(bytes),
                        fileType: fileType,
                      ));
                    }
                    Get.find<TasksController>().sendNotify();
                  }
                }
              } catch (e) {
                Get.snackbar('', 'Clipboard empty');
              }
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xffEDEFF3),
                  ),
                  width: 160,
                  height: 100,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.attach_file, color: Color(0xff529FBF)),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Загрузить файл',
                            style: TextStyle(color: Color(0xff529FBF), fontSize: 12),
                          )),
                      Tooltip(message: 'Longpress to paste photo from Clipboard', child: Icon(Icons.info, color: Color(0xff529FBF)))
                    ],
                  ),
                ),
                const Text('or'),
                DropTarget(
                  onDragDone: (detail)  {
                    List<XFile> file = detail.files;
                    for (var listfile in file) {
                      //  PickedFile localFile = PickedFile(listfile.path);
                      //  Uint8List bytes = localFile.readAsBytes();
                     

                      String fileName = listfile.name;
                      var fileType = TTNsgFilePicker.getFileTypeByPath(fileName);

                      objectsList1.add(NsgFilePickerObject(
                        isNew: true,
                        image: kIsWeb ? null : ((fileType == NsgFilePickerObjectType.image) ? Image.file(File(listfile.path)) : null),
                        description: fileName,
                        filePath: kIsWeb ? '' : listfile.path,
                        file: kIsWeb ? null : File(listfile.path),
                        fileType: fileType,
                        // fileContent: kIsWeb ? fileBytes : null
                      ));
                    }

                    Get.find<TasksController>().sendNotify();
                  },
                  onDragEntered: (detail) {},
                  onDragExited: (detail) {},
                  child: Container(
                    height: 100,
                    width: 160,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xffEDEFF3)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_upload_rounded),
                        Center(child: Text("Drop files here")),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : InkWell(
            hoverColor: ControlOptions.instance.colorMain,
            onTap: () {
              Scaffold.of(context as BuildContext).showBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                (BuildContext context) {
                  return Card(
                    elevation: 3,
                    child: Container(
                      height: 150,
                      decoration: const BoxDecoration(
                          color: Color(0xffEDEFF3), borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.photo),
                              onPressed: onPressed,
                            ),
                            IconButton(
                              icon: const Icon(Icons.folder),
                              onPressed: onPressed2,
                            ),
                            if (GetPlatform.isAndroid || GetPlatform.isIOS)
                              IconButton(
                                icon: const Icon(Icons.add_a_photo),
                                onPressed: onPressed3,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            onLongPress: GetPlatform.isIOS
                ? () async {
                    final bytes = await Pasteboard.image;

                    //   var length=bytes?.length ?? 0;
                    try {
                      if ((Pasteboard.image.isBlank == null || !Pasteboard.image.isBlank!) && bytes != null) {
                        objectsList1.add(
                          NsgFilePickerObject(
                              isNew: true,
                              image: Image.memory(bytes),
                              //TODO: convert image to jpg and check max size
                              description: "${Guid.newGuid()}.jpg",
                              fileContent: Uint8List.fromList(bytes),
                              fileType: NsgFilePickerObjectType.image),
                        );
                        Get.find<TasksController>().sendNotify();
                      } else {
                        var files = await Pasteboard.files();
                        if (files.isEmpty) {
                          Get.snackbar('', 'Clipboard empty');
                        } else {
                          for (var fileName in files) {
                            var fileType = TTNsgFilePicker.getFileTypeByPath(fileName);
                            if (fileType == NsgFilePickerObjectType.unknown) {
                              Get.snackbar('', 'File format doesn' 't supported $fileName');
                              continue;
                            }
                            var file = File(fileName);
                            objectsList1.add(NsgFilePickerObject(
                              isNew: true,
                              image: (fileType == NsgFilePickerObjectType.image ? Image.file(file) : null),
                              description: fileName,
                              filePath: fileName,
                              file: file,
                              //fileContent: Uint8List.fromList(bytes),
                              fileType: fileType,
                            ));
                          }
                          Get.find<TasksController>().sendNotify();
                        }
                      }
                    } catch (e) {
                      Get.snackbar('', 'Clipboard empty');
                    }
                  }
                : () => Get.snackbar('', 'Android not supported yet'),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffEDEFF3),
              ),
              width: 160,
              height: 159,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.attach_file, color: Color(0xff529FBF)),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Загрузить файл',
                        style: TextStyle(color: Color(0xff529FBF), fontSize: 12),
                      ))
                ],
              ),
            ),
          );
  }
}
