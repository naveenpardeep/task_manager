import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_control_options.dart';

class TTTabsTab {
  String name;
  Function(TTTabsTab tab) onTap;
  TTTabsTab({required this.name, required this.onTap});
}

class TTTabs extends StatefulWidget {
  final TTTabsTab currentTab;
  final List<TTTabsTab> tabs;
  const TTTabs({super.key, required this.tabs, required this.currentTab});

  @override
  State<TTTabs> createState() => _TTTabsState();
}

class _TTTabsState extends State<TTTabs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Row(
            children: showTabs(),
          ),
        ],
      ),
    );
  }

  List<Widget> showTabs() {
    List<Widget> list = [];
    for (var tab in widget.tabs) {
      list.add(
        Expanded(
            child: InkWell(
          hoverColor: Colors.transparent,
          onTap: () {
            tab.onTap(tab);
          },
          child: Container(
              height: 40,
              decoration: widget.currentTab.name == tab.name
                  ? BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: ControlOptions.instance.colorMain)))
                  : null,
              child: Center(
                child: Text(
                  tab.name,
                  style: TextStyle(
                      fontSize: ControlOptions.instance.sizeM,
                      color: widget.currentTab.name == tab.name ? ControlOptions.instance.colorMain : ControlOptions.instance.colorMainLight),
                ),
              )),
        )),
      );
    }
    return list;
  }
}
