import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nsg_controls/nsg_controls.dart';

class NsgCarousel extends StatefulWidget {
  NsgCarousel({super.key, required this.widgetList, this.controller, this.autoPlay = false, this.height, this.onChange});

  final List<Widget> widgetList;
  final CarouselController? controller;
  final bool autoPlay;
  final double? height;
  int currentTab = 0;
  final Function(int current)? onChange;

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
    return Column(
      children: [
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
              enlargeFactor: 0.3,
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
        Row(
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
        ),
      ],
    );
  }
}
