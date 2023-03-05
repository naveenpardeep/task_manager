import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';

class TaskButton extends StatelessWidget {
  const TaskButton({super.key, this.flex = 1, this.style = TaskButtonStyle.dark, this.onTap, this.text = ''});

  final int flex;
  final TaskButtonStyle style;
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: getColor(style)),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Inter', color: getTextColor(style), fontSize: ControlOptions.instance.sizeM),
              ),
            )));
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
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: getColor(style)),
            child: Stack(children: [
              Icon(
                icon,
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

Color getColor(TaskButtonStyle style, {bool invert = false}) {
  if (invert) {
    switch (style) {
      case TaskButtonStyle.dark:
        return ControlOptions.instance.colorMainLight;
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
