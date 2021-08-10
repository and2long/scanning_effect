import 'package:flutter/material.dart';

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
