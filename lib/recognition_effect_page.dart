import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scanning_effect/components/recognition_dot.dart';

class RecognitionEffectPage extends StatefulWidget {
  const RecognitionEffectPage({Key? key}) : super(key: key);

  @override
  _RecognitionEffectPageState createState() => _RecognitionEffectPageState();
}

class _RecognitionEffectPageState extends State<RecognitionEffectPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> animation;

  bool _show = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    animation =
        Tween(begin: CustomDotSet.minBorderRadius, end: CustomDotSet.maxBorderRadius)
            .animate(_controller)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  setState(() {
                    _show = false;
                    _controller.reset();
                  });
                }
              });
    _controller.forward();
    _timer = Timer.periodic(Duration(milliseconds: 1500), (timer) {
      setState(() {
        _show = true;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  List<Offset> _generateData() {
    // 1. 随机5到10个点
    int count = Random().nextInt(6) + 5;
    // 2. 随机位置，宽：30 ~ (屏幕宽度-30)，高：等宽居中
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // 3. 位置设置一点边距
    int marginValue = 30;
    List<Offset> list = [];
    for (int i = 0; i < count; i++) {
      double dx =
          Random().nextDouble() * (width - marginValue * 2) + marginValue;
      double dy = Random().nextDouble() * (width - marginValue * 2) +
          marginValue +
          (height - width) / 2;

      Offset offset = Offset(dx, dy);
      list.add(offset);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return _show
        ? RecognitionDotSet(
            offsetList: _generateData(),
            animation: animation,
          )
        : Container();
  }
}
