import 'package:flutter/material.dart';

class QRCodeLayout extends StatefulWidget {
  /// 扫描框的大小
  final Size size;

  /// 直角长度
  final double? angleLength;

  /// 直角宽度
  final double? angleWidth;

  /// 边框宽度
  final double? borderWidth;

  /// 是否显示边框
  final bool? showBorder;

  /// 扫描横线宽度
  final double? scannerWidth;

  /// 动画时长，默认 1500 毫秒
  final int? animationDuration;

  const QRCodeLayout({
    Key? key,
    required this.size,
    this.angleWidth,
    this.angleLength,
    this.borderWidth,
    this.showBorder,
    this.scannerWidth,
    this.animationDuration,
  }) : super(key: key);

  @override
  _QRCodeLayoutState createState() => _QRCodeLayoutState();
}

class _QRCodeLayoutState extends State<QRCodeLayout>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration ?? 1500),
        vsync: this);
    _animation =
        Tween(begin: 0.0, end: widget.size.height).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedQRCodeScanner(
      size: widget.size,
      animation: _animation,
      angleLength: widget.angleLength,
      angleWidth: widget.angleWidth,
      borderWidth: widget.borderWidth,
      showBorder: widget.showBorder,
      scannerWidth: widget.scannerWidth,
    );
  }
}

class AnimatedQRCodeScanner extends AnimatedWidget {
  final Size size;

  /// 直角长度
  final double? angleLength;

  /// 直角宽度
  final double? angleWidth;

  /// 边框宽度
  final double? borderWidth;

  /// 是否显示边框
  final bool? showBorder;

  /// 扫描横线宽度
  final double? scannerWidth;

  AnimatedQRCodeScanner({
    required Animation<double> animation,
    required this.size,
    this.angleLength,
    this.angleWidth,
    this.borderWidth,
    this.showBorder,
    this.scannerWidth,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: QRCodeBorderPainter(
        angleLength: angleLength,
        angleWidth: angleWidth,
        borderWidth: borderWidth,
        showBorder: showBorder,
      ),
      foregroundPainter: QRCodeScannerPainter(
        (listenable as Animation).value,
        scannerWidth,
      ),
    );
  }
}

/// 二维码边框
class QRCodeBorderPainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true;

  /// 直角长度
  double? angleLength;

  /// 直角宽度
  double? angleWidth;

  /// 边框宽度
  double? borderWidth;

  /// 是否显示边框
  bool? showBorder;

  QRCodeBorderPainter({
    this.angleLength,
    this.angleWidth,
    this.borderWidth,
    this.showBorder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _paint.strokeWidth = angleWidth ?? 5;
    double length = angleLength ?? 30;
    // 左上角
    canvas.drawLine(Offset(0, 0), Offset(0, length), _paint);
    canvas.drawLine(Offset(0, 0), Offset(length, 0), _paint);
    // 右上角
    canvas.drawLine(
        Offset(size.width - length, 0), Offset(size.width, 0), _paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, length), _paint);
    // 左下角
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - length), _paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(length, size.height), _paint);
    // 右下角
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - length), _paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - length, size.height), _paint);
    // 绘制边框
    if (showBorder ?? true) {
      _paint.strokeWidth = borderWidth ?? 1;
      // 左
      canvas.drawLine(
          Offset(0, length), Offset(0, size.height - length), _paint);
      // 上
      canvas.drawLine(
          Offset(length, 0), Offset(size.width - length, 0), _paint);
      // 右
      canvas.drawLine(Offset(size.width, length),
          Offset(size.width, size.height - length), _paint);
      // 下
      canvas.drawLine(Offset(length, size.height),
          Offset(size.width - length, size.height), _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// 中间扫描器
class QRCodeScannerPainter extends CustomPainter {
  Paint _paint = Paint()..color = Colors.green;

  final double yOffset;
  final double? lineWidth;

  QRCodeScannerPainter(this.yOffset, this.lineWidth) : assert(yOffset >= 0);

  @override
  void paint(Canvas canvas, Size size) {
    _paint..strokeWidth = (lineWidth ?? 2);
    canvas.drawLine(Offset(0, yOffset), Offset(size.width, yOffset), _paint);
    // Path path = Path();
    // path.moveTo(0, 100);
    // path.conicTo(size.width / 2, 50, size.width, 100, 1);
    // canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
