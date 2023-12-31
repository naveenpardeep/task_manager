import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';

class TaskButton extends StatelessWidget {
  const TaskButton({super.key, this.isEnabled = true, this.flex = 1, this.style = TaskButtonStyle.dark, this.onTap, this.text, this.icon});

  final int flex;
  final IconData? icon;
  final TaskButtonStyle style;
  final void Function()? onTap;
  final String? text;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            InkWell(
                onTap: isEnabled ? onTap : null,
                child: Container(
                    width: text != null ? double.infinity : null,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: getColor(style)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      if (icon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            icon,
                            color: getColor(style, invert: true),
                          ),
                        ),
                      if (text != null)
                        Text(
                          text!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Inter', color: getTextColor(style), fontSize: ControlOptions.instance.sizeM),
                        ),
                    ]))),
            if (!isEnabled)
              Positioned.fill(
                  child: Container(
                color: Colors.white.withAlpha(150),
              ))
          ],
        ));
  }
}

enum TaskButtonStyle { light, dark, warning }

class TaskIconButton extends StatelessWidget {
  const TaskIconButton({super.key, this.style = TaskButtonStyle.dark, this.onTap, required this.icon, this.nott = 0});

  final TaskButtonStyle style;
  final void Function()? onTap;
  final IconData icon;
  final int nott;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: getColor(style)),
            child: Stack(children: [
              Icon(
                
                icon,
                size: 14,
                color: getColor(style, invert: true),
              ),
              if (nott != 0)
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 15,
                      width: 15,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.red),
                      child: Text(
                        '$nott',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )),
            ])));
  }
}

class TaskTextButton extends StatelessWidget {
  const TaskTextButton({super.key, this.text = '', this.onTap});

  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          InkWell(
            onTap: onTap,
            child: Text(text, style: TextStyle(color: ControlOptions.instance.colorError, fontSize: ControlOptions.instance.sizeL, fontFamily: 'Inter')),
          )
        ]));
  }
}

Color getColor(TaskButtonStyle style, {bool invert = false}) {
  if (invert) {
    switch (style) {
      case TaskButtonStyle.dark:
        return ControlOptions.instance.colorWhite;
      case TaskButtonStyle.light:
        return ControlOptions.instance.colorMain;
      case TaskButtonStyle.warning:
        return ControlOptions.instance.colorWarning;
    }
  } else {
    switch (style) {
      case TaskButtonStyle.dark:
        return ControlOptions.instance.colorMain;
      case TaskButtonStyle.light:
        return ControlOptions.instance.colorMainLighter;
      case TaskButtonStyle.warning:
        return ControlOptions.instance.colorError;
    }
  }
}

Color getTextColor(TaskButtonStyle style) {
  switch (style) {
    case TaskButtonStyle.dark:
      return ControlOptions.instance.colorWhite;
    case TaskButtonStyle.light:
      return ControlOptions.instance.colorMain;
    case TaskButtonStyle.warning:
      return ControlOptions.instance.colorWhite;
  }
}
