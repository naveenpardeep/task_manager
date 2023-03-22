import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';
import 'package:task_manager_app/model/data_controller.dart';

class NsgCarousel extends StatefulWidget {
  NsgCarousel(
      {super.key,
      required this.widgetList,
      this.controller,
      this.autoPlay = false,
      this.height,
      this.onChange,
      this.sliderPosition = SliderPosition.bottomOut,
      this.maxSliderItems = 6});

  final List<Widget> widgetList;
  final CarouselController? controller;
  final bool autoPlay;
  final double? height;
  int currentTab = 0;
  final SliderPosition sliderPosition;
  final Function(int current)? onChange;
  final int maxSliderItems;

  @override
  State<NsgCarousel> createState() => _NsgCarouselState();
}

class _NsgCarouselState extends State<NsgCarousel> {
  late CarouselController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.sliderPosition == SliderPosition.bottomIn
        ? Stack(alignment: Alignment.bottomCenter, children: getBody())
        : Column(
            children: getBody(),
          );
  }

  List<Widget> getBody() {
    return [
      CarouselSlider(
          carouselController: _controller,
          items: widget.widgetList.map((item) => item).toList(),
          options: CarouselOptions(
            aspectRatio: 1,
            height: widget.height,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: widget.widgetList.length > 1 ? true : false,
            reverse: false,
            autoPlay: widget.autoPlay,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0,
            onPageChanged: (i, v) {
              setState(() {
                widget.currentTab = i;
                if (widget.onChange != null) {
                  widget.onChange!(i);
                }
              });
            },
            scrollDirection: Axis.horizontal,
          )),
      widget.maxSliderItems > widget.widgetList.length
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.widgetList.asMap().entries.map((entry) {
                return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                        width: 20,
                        height: 5,
                        margin: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 15),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: widget.currentTab == entry.key ? ControlOptions.instance.colorMain : ControlOptions.instance.colorGrey,
                        )));
              }).toList(),
            )
          : Text(
              '${widget.currentTab + 1}/${widget.widgetList.length}',
              style: TextStyle(color: ControlOptions.instance.colorMain, fontFamily: 'Inter', fontWeight: FontWeight.w400),
            ),
    ];
  }
}

enum SliderPosition {
  bottomIn,
  bottomOut,
}
