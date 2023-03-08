import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

class IconsTabsTab {
  Widget page;
  IconData icon;
  String? title;
  bool showAlert;
  IconsTabsTab({required this.page, required this.icon, this.title, this.showAlert = false});
}

class IconsTabs extends StatefulWidget {
  final NavigationBarStyle barStyle;
  final NavigationBodyStyle bodyStyle;
  final List<IconsTabsTab> tabs;
  final bool showIdentifier;

  const IconsTabs({
    super.key,
    this.showIdentifier = false,
    required this.tabs,
    this.barStyle = const NavigationBarStyle(
      position: NavigationPosition.bottom,
      background: Colors.white,
      elevation: 0.0,
    ),
    this.bodyStyle = const NavigationBodyStyle(
      background: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  });

  @override
  State<IconsTabs> createState() => _IconsTabsState();
}

class _IconsTabsState extends State<IconsTabs> {
  @override
  Widget build(BuildContext context) {
    return ScrollNavigation(
      physics: true,
      showIdentifier: widget.showIdentifier,
      identiferStyle: NavigationIdentiferStyle(
        color: ControlOptions.instance.colorMain,
      ),
      bodyStyle: widget.bodyStyle,
      barStyle: widget.barStyle,
      pages: getPages(),
      items: getItems(),
    );
  }

  List<ScrollNavigationItem> getItems() {
    List<ScrollNavigationItem> list = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      list.add(ScrollNavigationItem(
        icon: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.topEnd,
          children: [
            Icon(widget.tabs[i].icon, color: Colors.grey),
            Positioned(
              top: -10,
              right: -10,
              child: widget.tabs[i].showAlert
                  ? const Icon(
                      Icons.info,
                      color: Colors.red,
                    )
                  : Container(),
            ),
          ],
        ),
        title: widget.tabs[i].title,
        activeIcon: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.topEnd,
          children: [
            Icon(widget.tabs[i].icon, color: ControlOptions.instance.colorMain),
            Positioned(
              top: -10,
              right: -10,
              child: widget.tabs[i].showAlert
                  ? const Icon(
                      Icons.info,
                      color: Colors.red,
                    )
                  : Container(),
            ),
          ],
        ),
        titleStyle: TextStyle(color: ControlOptions.instance.colorMain, fontWeight: FontWeight.w400),
      ));
    }
    return list;
  }

  List<Widget> getPages() {
    List<Widget> list = [];
    for (int i = 0; i < widget.tabs.length; i++) {
      //
      list.add(widget.tabs[i].page);
    }
    return list;
  }
}
