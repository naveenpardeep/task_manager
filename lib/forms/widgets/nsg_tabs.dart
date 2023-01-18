import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsg_controls/nsg_control_options.dart';

class NsgTabsTab {
  String name;
  Widget child;
  NsgTabsTab({required this.name, required this.child});
}

class NsgTabs extends StatefulWidget {
  final int currentTab;
  final List<NsgTabsTab> tabs;
  const NsgTabs({super.key, required this.tabs, this.currentTab = 0});

  @override
  State<NsgTabs> createState() => _NsgTabsState();
}

class _NsgTabsState extends State<NsgTabs> {
  late int currentTab;
  late double width;
  final tabNamesC = ScrollController();
  final tabWidgetsC = ScrollController();
  final List<ScrollController> scrollControllers = [];
  final List<GlobalKey> gKeys = [];
  final widgetKey = GlobalKey();
  bool isScrolling = false;

  @override
  void initState() {
    currentTab = widget.currentTab;
    super.initState();
  }

  @override
  void dispose() {
    tabNamesC.dispose();
    tabWidgetsC.dispose();
    for (var element in scrollControllers) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = Get.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SingleChildScrollView(
            controller: tabNamesC,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabNames(),
            ),
          ),
        ),
        Expanded(
          child: NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                currentTab = (tabWidgetsC.offset + width / 2) ~/ width;
                setNamePos(key: currentTab, topOnly: true);
                setState(() {});
                return true;
              } else if (scrollNotification is ScrollEndNotification && !isScrolling) {
                //  _onEndScroll(scrollNotification.metrics);
                currentTab = (tabWidgetsC.offset + width / 2) ~/ width;
                setNamePos(key: currentTab);

                //scrollTo();
                return true;
              } else {
                return true;
              }
            },
            child: SingleChildScrollView(
              controller: tabWidgetsC,
              physics: const PageScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tabWidgets(),
              ),
            ),
          ),
        ),
      ],
    );
  }

/* -------------------------------------------------------------- Верхняя часть табов ------------------------------------------------------------- */
  List<Widget> tabNames() {
    List<Widget> list = [];
    widget.tabs.asMap().forEach((key, tab) {
      gKeys.add(GlobalKey());
      list.add(InkWell(
          key: gKeys[key],
          hoverColor: Colors.transparent,
          onTap: () {
            currentTab = key;
            setNamePos(key: key);
          },
          child: Container(
            decoration:
                BoxDecoration(color: currentTab == key ? ControlOptions.instance.colorMain : Colors.transparent),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              tab.name,
              style: TextStyle(
                  fontSize: ControlOptions.instance.sizeL,
                  color: currentTab == key ? ControlOptions.instance.colorMainText : ControlOptions.instance.colorText),
            ),
          )));
    });
    return list;
  }

  Future setNamePos({required int key, bool topOnly = false}) async {
    isScrolling = true;
    //currentTab = key;
    //setState(() {});
    RenderBox box = gKeys[key].currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double x = position.dx + tabNamesC.offset - width / 2;
    Future.wait([
      tabNamesC.animateTo(x, duration: const Duration(milliseconds: 300), curve: Curves.easeOut),
      if (!topOnly)
        tabWidgetsC.animateTo(width * currentTab, curve: Curves.easeOut, duration: const Duration(milliseconds: 300))
    ]);
    isScrolling = false;
  }

/* ------------------------------------------------------------ Виджеты/страницы табов ------------------------------------------------------------ */
  List<Widget> tabWidgets() {
    List<Widget> list = [];
    widget.tabs.asMap().forEach((key, tab) {
      scrollControllers.add(ScrollController());
      list.add(SizedBox(
          width: width,
          child: RawScrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              controller: scrollControllers[key],
              thickness: 10,
              trackBorderColor: ControlOptions.instance.colorGreyLight,
              trackColor: ControlOptions.instance.colorGreyLight,
              thumbColor: ControlOptions.instance.colorMain.withOpacity(0.5),
              radius: const Radius.circular(0),
              child: SingleChildScrollView(
                controller: scrollControllers[key],
                child: Center(child: tab.child),
              ))));
    });
    return list;
  }

  Future scrollTo() async {
    isScrolling = true;
    Future.delayed(Duration.zero, () {
      tabWidgetsC.animateTo(width * currentTab, curve: Curves.linear, duration: const Duration(milliseconds: 100));
    });
    isScrolling = false;
  }
}
