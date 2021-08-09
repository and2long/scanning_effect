import 'package:flutter/material.dart';

/// 识别点
class RecognitionDot extends StatefulWidget {
  final List<Offset> offsetList;
  final Animation<double> animation;

  const RecognitionDot({
    Key? key,
    required this.offsetList,
    required this.animation,
  }) : super(key: key);

  @override
  _RecognitionDotState createState() => _RecognitionDotState();
}

class _RecognitionDotState extends State<RecognitionDot> {
  @override
  Widget build(BuildContext context) {
    return AnimatedDot(
        offsetList: widget.offsetList, animation: widget.animation);
  }
}

class AnimatedDot extends AnimatedWidget {
  final List<Offset> offsetList;

  AnimatedDot({
    Key? key,
    required this.offsetList,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomDot((listenable as Animation).value, offsetList),
    );
  }
}

/// 自定义点
class CustomDot extends CustomPainter {
  Paint _paint = Paint();

  /// 边框半径
  double borderRadius;

  /// 显示位置
  List<Offset> offsetList;

  /// 中心圆点半径
  static final double dotRadius = 2.5;

  /// 边框取值范围
  static final double minBorderRadius = 3.0;
  static final double maxBorderRadius = 12.0;

  CustomDot(this.borderRadius, this.offsetList)
      : assert(offsetList.isNotEmpty),
        assert(
            borderRadius >= minBorderRadius && borderRadius <= maxBorderRadius);

  @override
  void paint(Canvas canvas, Size size) {
    _paint
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    offsetList.forEach((element) {
      canvas.drawOval(
          Rect.fromCircle(center: element, radius: dotRadius), _paint);
    });

    _paint
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(
          ((maxBorderRadius - borderRadius) / maxBorderRadius * 255).toInt(),
          255,
          255,
          255);
    offsetList.forEach((element) {
      canvas.drawCircle(element, borderRadius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
