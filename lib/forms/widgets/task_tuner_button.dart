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
                  color: style == TaskButtonStyle.dark ? ControlOptions.instance.colorMain : ControlOptions.instance.colorMainLighter),
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: style == TaskButtonStyle.dark ? ControlOptions.instance.colorMain : ControlOptions.instance.colorMainLighter),
            child: Stack(children: [
              Icon(
                icon,
                color: style == TaskButtonStyle.dark ? ControlOptions.instance.colorMainLight : ControlOptions.instance.colorMain,
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
