import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class RecognitionLayout extends StatefulWidget {
  const RecognitionLayout({Key? key}) : super(key: key);

  @override
  _RecognitionLayoutState createState() => _RecognitionLayoutState();
}

class _RecognitionLayoutState extends State<RecognitionLayout>
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
    animation = Tween(
            begin: CustomDotSet.minBorderRadius,
            end: CustomDotSet.maxBorderRadius)
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

/// 识别点集合
class RecognitionDotSet extends StatefulWidget {
  /// 点位置列表
  final List<Offset> offsetList;

  /// 动画
  final Animation<double> animation;

  const RecognitionDotSet({
    Key? key,
    required this.offsetList,
    required this.animation,
  }) : super(key: key);

  @override
  _RecognitionDotSetState createState() => _RecognitionDotSetState();
}

class _RecognitionDotSetState extends State<RecognitionDotSet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedDotSet(
        offsetList: widget.offsetList, animation: widget.animation);
  }
}

/// 点集合设置动画
class AnimatedDotSet extends AnimatedWidget {
  final List<Offset> offsetList;

  AnimatedDotSet({
    Key? key,
    required this.offsetList,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDotSet((listenable as Animation).value, offsetList),
    );
  }
}

/// 自定义点集合
class CustomDotSet extends CustomPainter {
  Paint _paint = Paint();

  /// 边框半径
  double borderRadius;

  /// 显示位置
  List<Offset> offsetList;

  /// 画笔宽度
  final double strokeWidth = 0.5;

  /// 中心圆点半径
  final double dotRadius = 2.0;

  /// 边框取值范围
  static final double minBorderRadius = 3.0;
  static final double maxBorderRadius = 12.0;

  CustomDotSet(this.borderRadius, this.offsetList)
      : assert(offsetList.isNotEmpty),
        assert(
            borderRadius >= minBorderRadius && borderRadius <= maxBorderRadius);

  @override
  void paint(Canvas canvas, Size size) {
    _paint
      ..color = Color.fromARGB(
          ((maxBorderRadius - borderRadius) / maxBorderRadius * 255).toInt(),
          255,
          255,
          255)
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;
    offsetList.forEach((element) {
      canvas.drawOval(
          Rect.fromCircle(center: element, radius: dotRadius), _paint);
    });

    _paint..style = PaintingStyle.stroke;
    offsetList.forEach((element) {
      canvas.drawCircle(element, borderRadius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
