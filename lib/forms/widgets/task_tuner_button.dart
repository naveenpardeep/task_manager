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
    return Expanded(
        flex: flex,
        child: InkWell(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: style == TaskButtonStyle.dark ? ControlOptions.instance.colorMain : ControlOptions.instance.colorMainLight),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Inter',
                    color: style == TaskButtonStyle.dark ? Colors.white : ControlOptions.instance.colorMain,
                    fontSize: ControlOptions.instance.sizeM),
              ),
            )));
  }
}

enum TaskButtonStyle { light, dark }
