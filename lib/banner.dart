import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef void OnBannerClickListener(int index, dynamic itemData);
typedef Widget BuildShowView(int index, dynamic itemData);

const IntegerMax = 0x7fffffff;

class BannerView extends StatefulWidget {
  final OnBannerClickListener onBannerClickListener;

  //延迟多少秒进入下一页
  final int delayTime; //秒
  //滑动需要秒数
  final int scrollTime; //毫秒
  final double height;
  final List data;
  final BuildShowView buildShowView;

  BannerView(
      {Key key,
        @required this.data,
        @required this.buildShowView,
        this.onBannerClickListener,
        this.delayTime = 3,
        this.scrollTime = 500,
        this.height = 200.0})
      : super(key: key) {
    print(delayTime);
  }

  @override
  State<StatefulWidget> createState() => new BannerViewState();
}

class BannerViewState extends State<BannerView> {
//  double.infinity
  final pageController = new PageController(initialPage: IntegerMax ~/ 2);
  Timer timer;

  BannerViewState() {
//    print(widget.delayTime);
  }

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  resetTimer() {
    clearTimer();
    timer = Zone.current.createPeriodicTimer(
        new Duration(seconds: widget.delayTime), (Timer timer) {
      var i = pageController.page.toInt() + 1;
      pageController.animateToPage(i == 3 ? 0 : i,
          duration: new Duration(milliseconds: widget.scrollTime),
          curve: new Interval(0.0, 1.0));
    });
  }

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
        height: widget.height,
        child: new GestureDetector(
          onTap: () {
//            print('onTap');
            widget.onBannerClickListener(pageController.page.toInt(),
                widget.data[pageController.page.toInt()]);
          },
          onTapDown: (details) {
//            print('onTapDown');
            clearTimer();
          },
          onTapUp: (details) {
//            print('onTapUp');
            resetTimer();
          },
          onTapCancel: () {
            resetTimer();
          },
          child: new PageView.custom(
            controller: pageController,
            physics:
            const PageScrollPhysics(parent: const BouncingScrollPhysics()),
            childrenDelegate: new SliverChildBuilderDelegate(
                  (context, index) => widget.buildShowView(
                  index, widget.data[index % widget.data.length]),
              childCount: IntegerMax,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}
