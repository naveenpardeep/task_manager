import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';

class TTInfoList extends StatelessWidget {
  const TTInfoList({super.key, this.rows = const []});

  final List<TTInfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getTitles(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: getValues(),
          ),
        )
      ],
    );
  }

  List<Widget> getTitles() {
    List<Widget> list = [];
    for (var row in rows) {
      list.add(
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(row.title,
                textAlign: TextAlign.start,
                style: TextStyle(fontFamily: 'Inter', fontSize: ControlOptions.instance.sizeM, color: ControlOptions.instance.colorMainLight))),
      );
    }
    return list;
  }

  List<Widget> getValues() {
    List<Widget> list = [];
    for (var row in rows) {
      list.add(Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(row.value, textAlign: TextAlign.start, style: TextStyle(fontFamily: 'Inter', fontSize: ControlOptions.instance.sizeM))));
    }
    return list;
  }
}

class TTInfoRow {
  const TTInfoRow({this.title = '', this.value = ''});
  final String title;
  final String value;
}
