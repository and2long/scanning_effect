import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sanning_effect/recognition_dot.dart';

class RecognitionEffectPage extends StatefulWidget {
  const RecognitionEffectPage({Key? key}) : super(key: key);

  @override
  _RecognitionEffectPageState createState() => _RecognitionEffectPageState();
}

class _RecognitionEffectPageState extends State<RecognitionEffectPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  bool _show = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation =
        Tween(begin: CustomDot.minBorderRadius, end: CustomDot.maxBorderRadius)
            .animate(controller)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  setState(() {
                    _show = false;
                  });
                }
              });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
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
        ? RecognitionDot(
            offsetList: _generateData(),
            animation: animation,
          )
        : Container();
  }
}
