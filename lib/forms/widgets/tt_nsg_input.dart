import 'package:flutter/gestures.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:nsg_data/controllers/nsg_controller_regime.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:hovering/hovering.dart';
import 'package:flutter/material.dart';
import 'package:nsg_data/nsg_data.dart';

class TTNsgInput extends StatefulWidget {
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

  /// Картинки для выводя рядом с текстом
  final List<String>? imagesList;

  /// Объект, значение поля которого отображается
  final NsgDataItem dataItem;

  /// Поле для отображения и задания значения
  final String fieldName;

  /// Контроллер
  final NsgDataController? controller;

  /// Контроллер для выбора связанного значения
  final NsgBaseController? selectionController;

  /// Контроллер, которому будет подаваться update при изменении значения в Input
  final NsgDataController? updateController;

  /// Функция прорисовки строки
  final Widget Function(NsgDataItem)? rowWidget;

  /// Тип поля ввода. Если тип не задан (NsgInputType.autoselect), он будет выбран автоматически,
  /// исходя из типа данных поля объекта
  final NsgInputType inputType;

  /// В случае задания формы для подбора значений для ссылочный полей, вместо стандартной формы будет выполнен переход
  /// на данную форму в режиме контроллера выбор значения
  final String selectionForm;

  /// Тип клавиатуры
  final TextInputType? keyboard;

  /// Маска текста
  final String? mask;

  /// Самая ранняя дата, доступная для выбора
  final DateTime? firstDateTime;

  /// Самая поздняя дата, доступная для выбора
  final DateTime? lastDateTime;

  /// Дата с которой будет предложен выбор, если поле равно 0г. или 1754г.
  final DateTime? initialDateTime;

  /// Поле с телефоном и специальной маской для телефонов разных стран
  /// Поле с российским номером автомобиля и автокорректировкой символов
  final NsgInputMaskType? maskType;

  ///При работе с enum можно задать возможные варианты для выбора, если не заданы, будут предложены все
  final List<NsgDataItem>? itemsToSelect;

  final String infoString;

  const TTNsgInput(
      {Key? key,
      this.initialDateTime,
      this.firstDateTime,
      this.lastDateTime,
      this.validateText = '',
      this.infoString = '',
      required this.dataItem,
      required this.fieldName,
      this.controller,
      this.selectionController,
      this.updateController,
      this.label = '',
      this.imagesList,
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
      this.rowWidget,
      this.inputType = NsgInputType.autoselect,
      this.selectionForm = '',
      this.keyboard = TextInputType.multiline,
      this.mask,
      this.maskType,
      this.itemsToSelect,
      this.required})
      : super(key: key);

  @override
  State<TTNsgInput> createState() => _TTNsgInputState();

  NsgInputType selectInputType() {
    if (inputType == NsgInputType.autoselect) {
      //Если не выбран, задаем его автоматически, исходя из типа данных fieldName
      if (dataItem.getField(fieldName) is NsgDataReferenceField) {
        return NsgInputType.reference;
      } else if (dataItem.getField(fieldName) is NsgDataEnumReferenceField) {
        return NsgInputType.enumReference;
      } else if (dataItem.getField(fieldName) is NsgDataBoolField) {
        return NsgInputType.boolValue;
      } else if (dataItem.getField(fieldName) is NsgDataStringField ||
          dataItem.getField(fieldName) is NsgDataIntField ||
          dataItem.getField(fieldName) is NsgDataDoubleField) {
        return NsgInputType.stringValue;
      } else if (dataItem.getField(fieldName) is NsgDataDateField) {
        return NsgInputType.dateValue;
      } else {
        throw Exception("Не указан тип поля ввода, тип данных неизвестен");
      }
    } else {
      //Если выбран, проверяем на допустимость типа данный fieldName
      if (inputType == NsgInputType.reference) {
        assert(dataItem.getField(fieldName) is NsgDataReferenceField);
      } else if (inputType == NsgInputType.enumReference) {
        assert(dataItem.getField(fieldName) is NsgDataReferenceField);
      } else if (inputType == NsgInputType.boolValue) {
        assert(dataItem.getField(fieldName) is NsgDataBoolField);
      } else if (inputType == NsgInputType.stringValue) {
        assert(dataItem.getField(fieldName) is NsgDataStringField);
      } else if (inputType == NsgInputType.dateValue) {
        assert(dataItem.getField(fieldName) is NsgDataDateField);
      }
      return inputType;
    }
  }
}

class _TTNsgInputState extends State<TTNsgInput> {
  final ValueNotifier<bool> _notifier = ValueNotifier(false);
  late double textScaleFactor;
  late double fontSize;
  FocusNode focus = FocusNode();
  late TextInputType? keyboard;
  late NsgInputType inputType;
  NsgBaseController? selectionController;
  bool isFocused = false;
  PhoneInputFormatter phoneFormatter = PhoneInputFormatter();
  bool _disabled = false;
  late TextEditingController textController;
  get useSelectionController => inputType == NsgInputType.reference || inputType == NsgInputType.referenceList;

  bool _ignoreChange = false;

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

      if (!focus.hasFocus && widget.onEditingComplete != null) {
        widget.onEditingComplete!(widget.dataItem, widget.fieldName);
      }
    });
    //Проверяем, выбран ли тип инпута пользователем
    _disabled = widget.disabled;
    inputType = widget.selectInputType();
    textController = TextEditingController();
    keyboard = widget.keyboard;
    if (widget.dataItem.getField(widget.fieldName) is NsgDataDoubleField) {
      keyboard = TextInputType.number;
    } else if (widget.dataItem.getField(widget.fieldName) is NsgDataIntField) {
      keyboard = TextInputType.number;
    } else if (inputType == NsgInputType.stringValue && widget.maskType == NsgInputMaskType.car) {
      keyboard = TextInputType.number;
    }

    textController.addListener(() {
      if (textController.text == '') {
        _notifier.value = true;
      } else {
        _notifier.value = false;
      }

      if (_ignoreChange) return;

      /// Заменяем в Double запятую на точку, удаляем всё, кроме цифр
      if (widget.dataItem.getField(widget.fieldName) is NsgDataDoubleField) {
        var start = textController.selection.start;
        var end = textController.selection.end;
        String text = textController.text;
        text = text.replaceAll(',', '.');
        text = text.replaceAll(RegExp('[^0-9.]'), '');
        widget.dataItem.setFieldValue(widget.fieldName, text);
        _ignoreChange = true;
        try {
          if (textController.text != text) {
            textController.text = text;
            if (start != -1 && end != -1) {
              textController.selection = TextSelection(baseOffset: start, extentOffset: end);
            }
          }
        } finally {
          _ignoreChange = false;
        }
      } else if (inputType == NsgInputType.stringValue) {
        if (widget.maskType == NsgInputMaskType.car) {
          var start = textController.selection.start;
          var end = textController.selection.end;
          String text = textController.text.toUpperCase();
          text = text.replaceAll(RegExp('[^0-9АВЕКМНОРСТУХABEKMHOPCTYX]'), '');
          if (start > text.length) {
            start = text.length;
            end = start;
          }
          widget.dataItem.setFieldValue(widget.fieldName, text);
          _ignoreChange = true;
          try {
            textController.text = text;
            if (start != -1 && end != -1) {
              textController.selection = TextSelection(baseOffset: start, extentOffset: end);
            }
          } finally {
            _ignoreChange = false;
          }
        }
        widget.dataItem.setFieldValue(widget.fieldName, textController.value.text);
      }
      if (widget.onChanged != null) {
        widget.onChanged!(widget.dataItem);
      }
    });

    if (useSelectionController) {
      var sc = widget.selectionController ?? widget.dataItem.defaultController;
      if (sc == null) {
        assert(widget.dataItem.getField(widget.fieldName) is NsgDataBaseReferenceField, widget.fieldName);
        sc = NsgDefaultController(
            dataType: (widget.dataItem.getField(widget.fieldName) as NsgDataBaseReferenceField).referentElementType,
            controllerMode: NsgDataControllerMode(storageType: widget.dataItem.storageType));
      }
      selectionController = sc;
    }
    if (widget.controller != null && widget.controller!.readOnly == true) {
      //_disabled = true;
    }
  }

  @override
  void dispose() {
    _notifier.dispose();
    textController.dispose();
    focus.unfocus();
    focus.removeListener(() {});
    focus.dispose();

    super.dispose();
  }

/* --------------------------------------------------------------------- BUILD -------------------------------------------------------------------- */
  @override
  Widget build(BuildContext context) {
    //textScaleFactor = MediaQuery.of(context).textScaleFactor;

    var fieldValue = widget.dataItem.getFieldValue(widget.fieldName);
    if (widget.dataItem.isReferenceField(widget.fieldName)) {
      if (fieldValue is List) {
        //ReferentListField
        List listValue = fieldValue;
        fieldValue = '';
        for (var v in listValue) {
          fieldValue += (fieldValue == '' ? '' : ', ') + v.toString();
        }
      } else {
        var refItem = widget.dataItem.getReferentOrNull(widget.fieldName);
        fieldValue = refItem == null ? '' : refItem.toString();
      }
    }
    if (inputType == NsgInputType.dateValue) {
      if (DateTime(01, 01, 01).isAtSameMomentAs(fieldValue) || DateTime(1754, 01, 01).isAtSameMomentAs(fieldValue)) {
        textController.text = '   ';
      } else {
        textController.text = NsgDateFormat.dateFormat(fieldValue);
      }
    } else {
      textController.text = fieldValue.toString();
    }
    if (inputType == NsgInputType.boolValue) {
      return _buildBoolWidget(fieldValue);
    }

    int? maxLength;
    if (widget.dataItem.getField(widget.fieldName) is NsgDataStringField) {
      maxLength = (widget.dataItem.getField(widget.fieldName) as NsgDataStringField).maxLength;
      if (maxLength == 0) {
        maxLength = null;
      }
    }

    if (focus.hasFocus) {
      textController.selection = TextSelection(baseOffset: 0, extentOffset: textController.text.length);
    }

    return Container(
        margin: widget.margin,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.label, textAlign: TextAlign.start, style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: Colors.black)),
          Container(
              child: widget.widget ??
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _gestureWrap(
                        clearIcon: fieldValue.toString() != '',
                        interactiveWidget: Container(
                          padding: const EdgeInsets.fromLTRB(0, 4, 0, 2),
                          alignment: Alignment.center,
                          //height: widget.maxLines > 1 ? null : 24 * textScaleFactor,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (!focus.hasFocus && textController.text == '')
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        (widget.required ?? widget.dataItem.isFieldRequired(widget.fieldName)) ? '${widget.infoString} *' : widget.infoString,
                                        style: TextStyle(fontSize: ControlOptions.instance.sizeL, color: ControlOptions.instance.colorMainLight),
                                      ),
                                    )),
                              if (widget.hint != null && focus.hasFocus && textController.text == '')
                                ValueListenableBuilder(
                                    valueListenable: _notifier,
                                    builder: (BuildContext context, bool val, Widget? child) {
                                      if (_notifier.value == true) {
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            widget.hint!,
                                            style: TextStyle(fontSize: ControlOptions.instance.sizeM, color: ControlOptions.instance.colorGrey),
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    }),
                              TextFormField(
                                controller: textController,
                                inputFormatters: widget.maskType == NsgInputMaskType.phone
                                    ? [phoneFormatter]
                                    : widget.mask != null
                                        ? [
                                            MaskTextInputFormatter(
                                              initialText: fieldValue.toString(),
                                              mask: widget.mask,
                                            )
                                          ]
                                        : null,
                                maxLength: maxLength,
                                autofocus: false,
                                focusNode: focus,
                                maxLines: widget.maxLines,
                                minLines: widget.minLines,
                                keyboardType: keyboard,
                                cursorColor: ControlOptions.instance.colorText,
                                decoration: InputDecoration(
                                  //label: SizedBox(),
                                  prefix: !_disabled
                                      ? null
                                      : Padding(
                                          padding: const EdgeInsets.only(right: 3.0),
                                          child: Icon(
                                            Icons.lock,
                                            size: 12,
                                            color: ControlOptions.instance.colorMain,
                                          ),
                                        ),
                                  counterText: "",
                                  contentPadding: EdgeInsets.fromLTRB(10, 14, useSelectionController ? 25 : 25, 14),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      gapPadding: 1,
                                      borderSide: BorderSide(color: ControlOptions.instance.colorMain),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  //labelStyle: TextStyle(color: ControlOptions.instance.colorMainDark, backgroundColor: Colors.transparent),
                                ),
                                onFieldSubmitted: (string) {
                                  focus.unfocus();
                                  if (widget.onEditingComplete != null) {
                                    //     widget.onEditingComplete!(widget.dataItem, widget.fieldName);
                                  }
                                },
                                style: TextStyle(color: ControlOptions.instance.colorText, fontSize: fontSize),
                                readOnly: _disabled,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget.validateText != '')
                        Text(
                          widget.validateText,
                          style: TextStyle(fontSize: ControlOptions.instance.sizeS, color: ControlOptions.instance.colorError),
                        ),
                    ],
                  ))
        ]));
  }

  /// Оборачивание disabled текстового поля, чтобы обработать нажатие на него
  Widget _gestureWrap({required Widget interactiveWidget, required bool clearIcon}) {
    if (inputType == NsgInputType.stringValue && widget.onPressed == null) {
      return clearIcon == true ? _addClearIcon(interactiveWidget) : interactiveWidget;
    } else {
      return clearIcon == true
          ? _addClearIcon(InkWell(onTap: _onPressed, child: AbsorbPointer(child: interactiveWidget)))
          : InkWell(onTap: _onPressed, child: AbsorbPointer(child: interactiveWidget));
    }
  }

  /// Оборачиваем Stack и добавляем иконку "очистить поле"
  Widget _addClearIcon(Widget child) {
    return Stack(alignment: Alignment.centerRight, children: [
      child,
      if (!_disabled)
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                widget.dataItem[widget.fieldName] = widget.dataItem.getField(widget.fieldName).defaultValue;
                textController.text = widget.dataItem[widget.fieldName].toString();

                Future.delayed(const Duration(milliseconds: 10), () {
                  FocusScope.of(context).requestFocus(focus);
                });
                textController.selection = TextSelection(baseOffset: 0, extentOffset: textController.text.length);
                if (widget.onEditingComplete != null) {
                  widget.onEditingComplete!(widget.dataItem, widget.fieldName);
                }
                setState(() {});
              },
              child: HoverWidget(
                hoverChild: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.close_outlined,
                    color: ControlOptions.instance.colorMain,
                    size: 16,
                  ),
                ),
                onHover: (PointerEnterEvent event) {},
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.close_outlined,
                    color: ControlOptions.instance.colorGrey,
                    size: 16,
                  ),
                ),
              )),
        )
    ]);
  }

  void _onPressed() {
    if (_disabled) {
      return;
    }
    if (inputType == NsgInputType.reference) {
      selectionController!.selectedItem = widget.dataItem.getReferent(widget.fieldName);
      //Зенков 27.12.2022 Вызывается в form.selectFromArray
      //Перенес вызов ниже в случае передачи пользовательской формы
      //selectionController!.refreshData();
      if (widget.selectionForm == '') {
        //Если формы для выбора не задана: вызываем форму подбора по умолчанию
        var form = NsgSelection(inputType: inputType, controller: selectionController, rowWidget: widget.rowWidget);
        form.selectFromArray(
          widget.label,
          (item) {
            widget.dataItem.setFieldValue(widget.fieldName, selectionController!.selectedItem);
            if (widget.onChanged != null) widget.onChanged!(widget.dataItem);
            if (widget.onEditingComplete != null) {
              widget.onEditingComplete!(widget.dataItem, widget.fieldName);
            }
            if (widget.controller != null) {
              widget.controller!.sendNotify();
            } else {
              setState(() {});
            }
            return;
          }, context: context,
        );
      } else {
        //Иначе - вызываем переданную форму для подбора
        //Если формы для выбора не задана: вызываем форму подбора по умолчанию
        selectionController!.refreshData();
        selectionController!.regime = NsgControllerRegime.selection;
        selectionController!.onSelected = (item) {
          Get.back();
          selectionController!.regime = NsgControllerRegime.view;
          selectionController!.onSelected = null;
          widget.dataItem.setFieldValue(widget.fieldName, item);
          if (widget.onChanged != null) widget.onChanged!(widget.dataItem);
          if (widget.onEditingComplete != null) {
            widget.onEditingComplete!(widget.dataItem, widget.fieldName);
          }
          setState(() {});
        };
        Get.toNamed(widget.selectionForm);
      }
    } else if (inputType == NsgInputType.enumReference) {
      var enumItem = widget.dataItem.getReferent(widget.fieldName) as NsgEnum;
      var itemsArray = widget.itemsToSelect ?? enumItem.getAll();
      var form = NsgSelection(allValues: itemsArray, selectedElement: enumItem, rowWidget: widget.rowWidget, inputType: NsgInputType.enumReference);
      form.selectFromArray(
        widget.label,
        (item) {
          widget.dataItem.setFieldValue(widget.fieldName, item);
          if (widget.onChanged != null) widget.onChanged!(widget.dataItem);
          if (widget.onEditingComplete != null) {
            widget.onEditingComplete!(widget.dataItem, widget.fieldName);
          }
          setState(() {});
          return null;
        }, context: context,
      );
    } else if (inputType == NsgInputType.referenceList) {
      var form = NsgMultiSelection(controller: selectionController!);
      form.selectedItems = (widget.dataItem[widget.fieldName] as List).cast<NsgDataItem>();
      selectionController!.refreshData();
      if (widget.selectionForm == '') {
        //Если формы для выбора не задана: вызываем форму подбора по умолчанию
        form.selectFromArray(
          widget.label,
          '',
          (items) {
            widget.dataItem.setFieldValue(widget.fieldName, items);
            if (widget.onChanged != null) widget.onChanged!(widget.dataItem);
            if (widget.onEditingComplete != null) {
              widget.onEditingComplete!(widget.dataItem, widget.fieldName);
            }
            setState(() {});
          },
        );
      } else {
        NsgNavigator.instance.toPage(widget.selectionForm);
      }
    } else if (inputType == NsgInputType.dateValue) {
      NsgDatePicker(
              firstDateTime: widget.firstDateTime,
              lastDateTime: widget.lastDateTime,
              initialTime: DateTime(01, 01, 01).isAtSameMomentAs(widget.dataItem[widget.fieldName]) ||
                      DateTime(1754, 01, 01).isAtSameMomentAs(widget.dataItem[widget.fieldName])
                  ? widget.initialDateTime ?? DateTime.now()
                  : widget.dataItem[widget.fieldName],
              onClose: (value) {})
          .showPopup(context, widget.dataItem[widget.fieldName], (value) {
        if (widget.onChanged != null) widget.onChanged!(widget.dataItem);
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete!(widget.dataItem, widget.fieldName);
        }
        widget.dataItem[widget.fieldName] = value;
        setState(() {});
      });
    }
  }

  Widget _buildBoolWidget(bool fieldValue) {
    return Container(
        margin: widget.margin,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: IntrinsicHeight(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(fontSize: ControlOptions.instance.sizeL, fontFamily: 'Inter'),
                ),
                if (widget.infoString != '')
                  Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        widget.infoString,
                        style: TextStyle(fontSize: ControlOptions.instance.sizeS, fontFamily: 'Inter', color: ControlOptions.instance.colorMainLight),
                      )),
              ],
            )),
            const Padding(padding: EdgeInsets.only(left: 20)),
            StatefulBuilder(
              builder: ((context, setState) => FlutterSwitch(
                  value: fieldValue,
                  inactiveToggleColor: ControlOptions.instance.colorMainLight,
                  inactiveColor: ControlOptions.instance.colorGreyLight,
                  activeColor: ControlOptions.instance.colorMain,
                  onToggle: (value) {
                    fieldValue = !fieldValue;
                    widget.dataItem.setFieldValue(widget.fieldName, fieldValue);
                    if (widget.updateController != null) {
                      widget.updateController!.update();
                    } else {
                      if (widget.controller != null) {
                        widget.controller!.sendNotify();
                      }

                      setState(() {});
                    }
                  })),
            )
          ],
        )));
  }
}
